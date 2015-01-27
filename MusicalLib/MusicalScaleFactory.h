//
//  MLScaleFactory.h
//  MusicalLib
//
//  Created by Hari Karam Singh on 26/01/2015.
//
//

#import <Foundation/Foundation.h>
#import "MusicalScaleDefinition.h"
#import "MusicalScale.h"
#import "MusicalScaleCategory.h"
#import "MusicalNoteSet.h"

/** 
 For creating MusicalScale objects and managing MusicalScaleDefinitions, favourites, etc. Eventually for user created scales too.
 
 This is manually managed JSON backed store. The main scale defs are from a bundle file and the favourites are stored in a JSON file in the app's userdocs folder. Everything is loaded into memory on `-setup` so the queries don't throw exceptions.
 */
@interface MusicalScaleFactory : NSObject


/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

/**
On first call, initialises the JSON data stores creating the folder in the documents directory if DNE. Loads the data from the bundle file and the datastores into memory. Best to call this early.

@throws MusicalLibException on failure to create folder or read files. Possible on first call only.
*/
+ (instancetype)sharedInstance;


/////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods
/////////////////////////////////////////////////////////////////////////

- (NSArray *)allCategories;
- (NSArray *)scaleDefinitionsForCategory:(MusicalScaleCategory *)scaleCategory;
- (MusicalScaleDefinition *)scaleDefinitionWithID:(NSString *)scaleDefID;
- (NSArray *)favoriteScaleDefinitions;

- (MusicalScale *)scaleWithID:(NSString *)ID key:(MusicalKey)key;

/** Usually used when reloading from user defaults in which the id and key were stored */
- (MusicalScale *)scaleWithID:(NSString *)ID keyStr:(NSString *)keyStr;

/**
 Convenience constructor for NoteSet
 */
- (MusicalNoteSet *)noteSetWithScaleID:(NSString *)scaleDefinitionID
                                keyStr:(NSString *)keyStr
                insideRangeFromNoteStr:(NSString *)fromNote
                             toNoteStr:(NSString *)toNote;

/**
 Updates the datastore adding/removing the scale def as a favorite. Set to NO to remove .
 
 @throws MusicalLibException on JSON or write error. If there is an exception call `setup...` again to ensure the favs data is synchronised
 */
- (void)storeScaleDefinitionInFavorites:(MusicalScaleDefinition *)scaleDef isFavorite:(BOOL)isFavorite;

/** Delete the JSON file. Used for debugging primarily */
- (void)deleteAllFavorites;


//- factoryScaleDefExistsWithName:(NSString *)name;
//- userScaleDefExistsWithName:(NSString *)name;
//- scaleDefExistsWithName:(NSString *)name;
//- storeUserScaleDef:(MLScaleDefinition *)scaleDef;
//- deleteUserScaleDefWithName:(NSString *)name;


@end
