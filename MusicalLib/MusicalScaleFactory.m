//
//  MLScaleFactory.m
//  MusicalLib
//
//  Created by Hari Karam Singh on 26/01/2015.
//
//

#import "MusicalScaleFactory.h"

#import "MusicalLibException.h"

#undef echo
#if DEBUG && (!defined(LOG_MUSICAL_LIB_DATASTORE) || LOG_MUSICAL_LIB_DATASTORE)
#   define echo(fmt, ...) NSLog((@"[MUSICAL_LIB_DATASTORE] " fmt), ##__VA_ARGS__);
#else
#   define echo(...)
#endif
#undef warn
#define warn(fmt, ...) NSLog((@"[MUSICAL_LIB_DATASTORE] WARNING: " fmt), ##__VA_ARGS__);

/////////////////////////////////////////////////////////////////////////
#pragma mark - Defs & Consts
/////////////////////////////////////////////////////////////////////////

/** The default name of the subfolder to create/use in the Docs folder for persistent data. Overrideable by the API */
static NSString *_DATASTORE_SUBFOLDER = @"MusicalLib";

/** Default name JSON filename for above */
static NSString *_FAVORITES_STORE_FILENAME = @"MusicalLib_User.json";



/////////////////////////////////////////////////////////////////////////
#pragma mark -
/////////////////////////////////////////////////////////////////////////

@implementation MusicalScaleFactory
{
    /** Cache of the values in the main json file */
    NSArray *_scaleCategs;
    NSArray *_scaleDefs;
    NSArray *_favoriteScaleDefs;
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////


+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [self new];
    });
    return shared;
}

//---------------------------------------------------------------------

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _favoriteScaleDefs = [NSArray array];
        [self _setupAndLoadData];
    }
    return self;
}

//---------------------------------------------------------------------

- (void)_setupAndLoadData
{
    echo("Setup...");
    
    /////////////////////////////////////////
    // DATASTORE FOLDER
    /////////////////////////////////////////
    // Create the folder for the persisted data
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self _dataStoreFolder].path isDirectory:NULL])
    {
        echo("...Creating datastore folder at %@", [self _dataStoreFolder].path);

        NSError *err;
        [[NSFileManager defaultManager] createDirectoryAtPath:[self _dataStoreFolder].path withIntermediateDirectories:YES attributes:nil error:&err];
        if (err) {
            @throw [MusicalLibException exceptionWithReason:@"Error creating datastore folder" underlyingError:err];
        }
    }
    
    /////////////////////////////////////////
    // SCALE DEFS
    /////////////////////////////////////////
    {
        echo("...Loading built-in scale JSON data...");
        
        NSURL *scaleDefsURL = [[NSBundle mainBundle] URLForResource:@"MusicalScaleData" withExtension:@"json"];
        NSAssert(scaleDefsURL, @"Could not find MusicalScaleData.json in bundle!");
        NSData *jsonData = [NSData dataWithContentsOfURL:scaleDefsURL];
        NSAssert(jsonData, @"Could not load MusicalScaleData.json!");
        NSError *err;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            @throw [MusicalLibException exceptionWithReason:@"Error parsing datastore JSON data" underlyingError:err];
        }
        
        // CATEGORIES...
        NSMutableArray *categs = [NSMutableArray array];
        for (NSDictionary *entry in json[@"categories"])
        {
            [categs addObject:[MusicalScaleCategory scaleCategoryWithWithID:entry[@"id"] name:entry[@"name"]]];
        }
        _scaleCategs = [NSArray arrayWithArray:categs];
        echo("...%i categories loaded", (int)_scaleCategs.count);
        
        // SCALE DEFS
        NSMutableArray *scaleDefs = [NSMutableArray array];
        for (NSDictionary *entry in json[@"scaleDefinitions"])
        {
            NSArray *categs = [self _scaleCategoriesWithIDs:entry[@"categories"]];
            [scaleDefs addObject:[MusicalScaleDefinition scaleDefinitionWithID:entry[@"id"]
                                                                          name:entry[@"name"]
                                                                      categories:categs
                                                                          isUser:NO
                                                                  halfstepsArray:entry[@"halfsteps"]]];
        }
        _scaleDefs = [NSArray arrayWithArray:scaleDefs];
        echo("...%i scale definitions loaded", (int)_scaleDefs.count);
    }
    
    
    /////////////////////////////////////////
    // FAVOURITES
    /////////////////////////////////////////
    
    [self _reloadFavorites];
    
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods
/////////////////////////////////////////////////////////////////////////

- (NSArray *)allCategories
{
    return _scaleCategs;
}

//---------------------------------------------------------------------

- (NSArray *)scaleDefinitionsForCategory:(MusicalScaleCategory *)scaleCategory
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%@ in categories.ID", scaleCategory.ID];
    return [_scaleDefs filteredArrayUsingPredicate:pred];
}

//---------------------------------------------------------------------

- (MusicalScaleDefinition *)scaleDefinitionWithID:(NSString *)scaleDefID
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ID LIKE %@", scaleDefID];
    NSArray *res = [_scaleDefs filteredArrayUsingPredicate:pred];
    if (!res || res.count == 0) {
        warn("Scale definition not found for ID: %@", scaleDefID);
        return nil;
    }
    return res[0];  // there should be only one
}

//---------------------------------------------------------------------

- (NSArray *)favoriteScaleDefinitions
{
    return _favoriteScaleDefs;
}

//---------------------------------------------------------------------

- (BOOL)isFavorite:(MusicalScaleDefinition *)scaleDefinition
{
    return [self.favoriteScaleDefinitions containsObject:scaleDefinition];
}

//---------------------------------------------------------------------

- (MusicalScale *)scaleWithID:(NSString *)ID keyStr:(NSString *)keyStr
{
    return [self scaleWithID:ID key:MusicalKeyFromString(keyStr)];
}

//---------------------------------------------------------------------

- (MusicalScale *)scaleWithID:(NSString *)ID key:(MusicalKey)key
{
    // Get the definition
    MusicalScaleDefinition *scaleDef = [self scaleDefinitionWithID:ID];
    if (!scaleDef) return nil;
        
    return [MusicalScale scaleWithDefinition:scaleDef key:key];
}

//---------------------------------------------------------------------

- (MusicalNoteSet *)noteSetWithScaleID:(NSString *)scaleDefinitionID keyStr:(NSString *)keyStr insideRangeFromNoteStr:(NSString *)fromNote toNoteStr:(NSString *)toNote
{
    // Convert the key string to the reqd enum and init the class
    MusicalScale *aScale = [self scaleWithID:scaleDefinitionID keyStr:keyStr];
    
    if (!aScale) {
        [NSException raise:@"MusicalLibScaleNotFound"
                    format:@"The scale %@ could not be found.", scaleDefinitionID];
    }
    
    // And init with our method
    return [MusicalNoteSet noteSetWithScale:aScale
                        insideRangeFromNote:[MusicalNote noteFromString:fromNote]
                                     toNote:[MusicalNote noteFromString:toNote]];
}

//---------------------------------------------------------------------

- (void)storeScaleDefinitionInFavorites:(MusicalScaleDefinition *)scaleDef isFavorite:(BOOL)isFavorite
{
    echo("%@ favorite Scale Definition %@...", (isFavorite?@"Adding":@"Removing"), scaleDef.ID);
    
    // Add or remove from favourites and save
    NSMutableArray *newFavs = [_favoriteScaleDefs mutableCopy];
    
    // If adding, check we dont have it already
    if (isFavorite)
    {
        if ([newFavs containsObject:scaleDef]) {
            echo("...WARNING: Scale Definition already exists in favorites!");
            return;
        }
        [newFavs addObject:scaleDef];
    }
    else
    {
        // Remove it if it exists
        if (![newFavs containsObject:scaleDef]) {
            echo("...WARNING: Scale Definition DNE in favorites!");
            return;
        }
        [newFavs removeObject:scaleDef];
    }
    
    // Update our local cache
    _favoriteScaleDefs = [NSArray arrayWithArray:newFavs];
    
    // Convert to JSON. See `_reloadFavorites` for format
    __block NSMutableArray *favEntries = [NSMutableArray array];
    [_favoriteScaleDefs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [favEntries addObject:@{@"id": [obj ID]}];
    }];
    NSDictionary *favsJSON = @{ @"favorites": favEntries };
    
    // Save JSON file
    echo("...saving data to persistent store.");
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:favsJSON options:kNilOptions error:&err];
    if (err) {
        @throw [MusicalLibException exceptionWithReason:@"Couldn't parse Favorites JSON for save" underlyingError:err];
    }

    // Write the file. Atomic to ensure no corruption
    if (![jsonData writeToURL:[self _favoritesStoreFileURL] options:NSDataWritingAtomic error:&err]) {
        @throw [MusicalLibException exceptionWithReason:@"Error writing to Favorites JSON file." underlyingError:err];
    }
}

//---------------------------------------------------------------------

- (void)deleteAllFavorites
{
    NSError *err;
    NSString *favPath = [self _favoritesStoreFileURL].path;
    if ([[NSFileManager defaultManager] fileExistsAtPath:favPath isDirectory:NULL]) {
        [[NSFileManager defaultManager] removeItemAtPath:favPath error:&err];
        
        if (err) {
            @throw [MusicalLibException exceptionWithReason:@"Failed to remove favorites data store" underlyingError:err];
        }
        echo("Favorites data store deleted.");
    }
    
    // Clear the local cache as well
    _favoriteScaleDefs = [NSArray array];;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Additional Privates
/////////////////////////////////////////////////////////////////////////

- (NSURL *)_dataStoreFolder
{
    NSFileManager* sharedFM = [NSFileManager defaultManager];
    NSArray* possibleURLs = [sharedFM URLsForDirectory:NSDocumentDirectory
                                             inDomains:NSUserDomainMask];
    NSURL* url = nil;
    
    if ([possibleURLs count] >= 1) {
        // Use the first directory (if multiple are returned)
        url = [possibleURLs objectAtIndex:0];
    }
    
    url = [url URLByAppendingPathComponent:_DATASTORE_SUBFOLDER];
    
    return url;
}

//---------------------------------------------------------------------

- (NSURL *)_favoritesStoreFileURL
{
    return [[self _dataStoreFolder] URLByAppendingPathComponent:_FAVORITES_STORE_FILENAME];
}

//---------------------------------------------------------------------

- (void)_reloadFavorites
{
    NSData *jsonData = [NSData dataWithContentsOfURL:[self _favoritesStoreFileURL]];
    if (!jsonData)
    {
        echo("...Favourites not yet created. Skipping.");
    }
    else
    {
        NSError *err;
        
        // The JSON format:
        /*
         {
         "favorites": [
         { "id": "pentatonic-blues" },
         { "id": "minor" },
         ...
         ]
         }
         */
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
        
        if (err) {
            @throw [MusicalLibException exceptionWithReason:@"Error parsing favourites JSON" underlyingError:err];
        }
        
        // Convert to scaleDef objects
        NSMutableArray *favs = [NSMutableArray array];
        for (NSDictionary *favEntry in json[@"favorites"])
        {
            [favs addObject:[self scaleDefinitionWithID:favEntry[@"id"]]];
        }
        _favoriteScaleDefs = [NSArray arrayWithArray:favs];
        echo("...%i favorites loaded", (int)_favoriteScaleDefs.count);
    }
}

//---------------------------------------------------------------------

/** Return array of objects for the given id strings */
- (NSArray *)_scaleCategoriesWithIDs:(NSArray *)categoryIDs
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ID in %@", categoryIDs];
    return [_scaleCategs filteredArrayUsingPredicate:pred];
}

//---------------------------------------------------------------------

- (MusicalScaleCategory *)_scaleCategoryWithID:(NSString *)categoryID
{
    for (MusicalScaleCategory *categ in _scaleCategs)
    {
        if ([categ.ID isEqualToString:categoryID]) return categ;
    }
    return nil;
}


@end
