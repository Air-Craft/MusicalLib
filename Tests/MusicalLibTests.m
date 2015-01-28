//
//  MusicalNoteTests.m
//  AirPluckHarp
//
//  Created by Hari Karam Singh on 08/09/2011.
//  Copyright (c) 2011-2015 Air Craft Media Ltd.  MIT License.
//
#import "MusicalLibTests.h"

#if defined(DEBUG) && (!defined(LOG_MUSICALLIB_TESTS) || LOG_MUSICALLIB_TESTS)
#   undef echo
#	define echo(fmt, ...) NSLog((@"[MUSICALLIB_TESTS] " fmt), ##__VA_ARGS__);
#else
#   undef echo
#   define echo(...)
#endif

/////////////////////////////////////////////////////////////////////////
#pragma mark -
/////////////////////////////////////////////////////////////////////////

@interface MusicalScaleFactory ()

/** Allow forcing a refresh from disk to validate persistence tests */
- (void)_setupAndLoadData;

@end

/////////////////////////////////////////////////////////////////////////
#pragma mark -
/////////////////////////////////////////////////////////////////////////

@implementation MusicalLibTests
{
    MusicalScaleFactory *_factory;
}

- (void)setUp
{
    [super setUp];
    _factory = [MusicalScaleFactory sharedInstance];
    [_factory _setupAndLoadData];
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - MusicalNote Creation & Maths
/////////////////////////////////////////////////////////////////////////

- (void)testNoteToString 
{
    MusicalNote *note;
    
    note = [MusicalNote noteWithKey:kMusicalKeyG octave:0];
    XCTAssertTrue([[note toString] isEqualToString:@"G0"], @"Incorrect note string: %@", note);
    
    note = [MusicalNote noteWithKey:kMusicalKeyCs octave:-1];
    XCTAssertTrue([[note toString] isEqualToString:@"C#-1"], @"Incorrect note string: %@", note);
    
    note = [MusicalNote noteWithKey:kMusicalKeyEb octave:100];
    XCTAssertTrue([[note toString] isEqualToString:@"Eb100"], @"Incorrect note string: %@", note);
}

//---------------------------------------------------------------------

- (void)testNoteAdd
{
    MusicalNote *noteA;
    MusicalNote *noteB;
    
    // c1 + 1 = c#1
    noteA = [MusicalNote noteWithKey:kMusicalKeyC octave:1];
    noteB = [MusicalNote noteFromAddingHalfsteps:1 toNote:noteA];
    XCTAssertTrue([[noteB toString] isEqualToString:@"C#1"], @"Incorrect note: %@", noteB);

    // c0 - 1 = b-1
    noteA = [MusicalNote noteWithKey:kMusicalKeyC octave:0];
    noteB = [MusicalNote noteFromAddingHalfsteps:-1 toNote:noteA];
    XCTAssertTrue([[noteB toString] isEqualToString:@"B-1"], @"Incorrect note: %@", noteB);

    // e-1 + 25 = f1
    noteA = [MusicalNote noteWithKey:kMusicalKeyE octave:-1];
    noteB = [MusicalNote noteFromAddingHalfsteps:25 toNote:noteA];
    XCTAssertTrue([[noteB toString] isEqualToString:@"F1"], @"Incorrect note: %@", noteB);

    // f1 - 25 = e-1
    noteA = [MusicalNote noteWithKey:kMusicalKeyF octave:1];
    noteB = [MusicalNote noteFromAddingHalfsteps:-25 toNote:noteA];
    XCTAssertTrue([[noteB toString] isEqualToString:@"E-1"], @"Incorrect note: %@", noteB);
    
    // c-1 - 13 = b-3
    noteA = [MusicalNote noteWithKey:kMusicalKeyC octave:-1];
    noteB = [MusicalNote noteFromAddingHalfsteps:-13 toNote:noteA];
    XCTAssertTrue([[noteB toString] isEqualToString:@"B-3"], @"Incorrect note: %@", noteB);
    
    // A-1 + 2 - 2 = A-1
    noteA = [MusicalNote noteWithKey:kMusicalKeyA octave:-1];
    noteB = [MusicalNote noteFromAddingHalfsteps:2 toNote:noteA];
    noteB = [MusicalNote noteFromAddingHalfsteps:-2 toNote:noteB];
    XCTAssertTrue([[noteB toString] isEqualToString:[noteA toString]], @"Incorrect note: %@", noteB);
    
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Factory Setup & Persistence
/////////////////////////////////////////////////////////////////////////

- (void)testFactorySetupAndLoad
{
    XCTAssertGreaterThan(_factory.allCategories.count, 2, @"Factory failed to load categories: %@", _factory.allCategories);
    
    XCTAssertGreaterThan([_factory scaleDefinitionsForCategory:_factory.allCategories[0]].count, 1, @"Factory failed to load scales");
}

//---------------------------------------------------------------------

- (void)testScaleFavorites
{
    [_factory deleteAllFavorites];
    XCTAssertTrue(_factory.favoriteScaleDefinitions.count == 0, "Favorites should be empty!");
    
    NSArray *scaleDefs = [_factory scaleDefinitionsForCategory:_factory.allCategories[0]];
    XCTAssertTrue(scaleDefs.count >= 2, @"Need 2 or more scales in first category for this test to run!");
    MusicalScaleDefinition *scaleDef1 = scaleDefs[0];
    MusicalScaleDefinition *scaleDef2 = scaleDefs[1];
    
    // Add two and reload...
    [_factory storeScaleDefinitionInFavorites:scaleDef1 isFavorite:YES];
    [_factory storeScaleDefinitionInFavorites:scaleDef2 isFavorite:YES];
    XCTAssertTrue(_factory.favoriteScaleDefinitions.count == 2, @"Adding favorites failed");
    [_factory _setupAndLoadData];
    
    // Check they are correct
    XCTAssertTrue([_factory.favoriteScaleDefinitions[0] isEqual:scaleDef1], @"Favorites idx=0 is the wrong one");
    XCTAssertTrue([_factory.favoriteScaleDefinitions[1] isEqual:scaleDef2], @"Favorites idx=1 is the wrong one");
    
    // Remove one...
    [_factory storeScaleDefinitionInFavorites:scaleDef1 isFavorite:NO];
    XCTAssertTrue(_factory.favoriteScaleDefinitions.count == 1, @"Removing favorite failed");
    [_factory _setupAndLoadData];
    
    // Test the correct tone was removed
    XCTAssertTrue([_factory.favoriteScaleDefinitions[0] isEqual:scaleDef2], @"Removing favorite left the wrong one remaining");
    
    // Remove final...
    [_factory storeScaleDefinitionInFavorites:scaleDef2 isFavorite:NO];
    [_factory _setupAndLoadData];
    XCTAssertTrue(_factory.favoriteScaleDefinitions.count == 0, @"Removing last favorite failed");
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Factory Constructions
/////////////////////////////////////////////////////////////////////////

- (void)testMusicalNoteSets
{
    MusicalNoteSet *notes;
    
    // C Major (C0 - C4)
    notes = [_factory noteSetWithScaleID:@"major" keyStr:@"C" insideRangeFromNoteStr:@"C0" toNoteStr:@"C4"];
    XCTAssertTrue([[[notes noteAtIndex:0] toString] isEqualToString: @"C0"], @"C Major: Incorrect note at index 0: %@", [notes noteAtIndex:0]);
    XCTAssertTrue([[[notes noteAtIndex:1] toString] isEqualToString: @"D0"], @"C Major: Incorrect note at index 1: %@", [notes noteAtIndex:1]);
    XCTAssertTrue([[[notes noteAtIndex:6] toString] isEqualToString: @"B0"], @"C Major: Incorrect note at index 6: %@", [notes noteAtIndex:6]);
    XCTAssertTrue([[[notes noteAtIndex:7] toString] isEqualToString: @"C1"], @"C Major: Incorrect note at index 7: %@", [notes noteAtIndex:7]);
    XCTAssertTrue([[[notes noteAtIndex:28] toString] isEqualToString: @"C4"], @"C Major: Incorrect note at index 28: %@", [notes noteAtIndex:28]);
    
    // C# Major (B-1 - B2, should snap nearest note in key)
    notes = [_factory noteSetWithScaleID:@"major" keyStr:@"C#" insideRangeFromNoteStr:@"B-1" toNoteStr:@"B2"];
    XCTAssertTrue([[[notes noteAtIndex:0] toString] isEqualToString: @"C0"],   @"C# Major: Incorrect note at index 0: %@", [notes noteAtIndex:0]);
    XCTAssertTrue([[[notes lastNote] toString] isEqualToString: @"A#2"],        @"C# Major: Incorrect note at last index: %@", [notes lastNote]);
    
    // Test init from strings
//    startNote   = [[MusicalNote alloc] initWithKey:kMusicalKeyDb andOctave:-1];  // should snap to D
//    endNote     = [[MusicalNote alloc] initWithKey:kMusicalKeyF andOctave:2];    // Minor 3rd is in key
    notes = [_factory noteSetWithScaleID:@"dorian" keyStr:@"C" insideRangeFromNoteStr:@"Db-1" toNoteStr:@"F2"];
    XCTAssertTrue([notes.scale.name isEqualToString:@"Dorian"], @"Scale name \"%@\" != \"Dorian\"", notes.scale.name);
    XCTAssertTrue([[[notes noteAtIndex:0] toString] isEqualToString: @"D-1"], @"First note %@ should be D-1", notes.firstNote.toString);
    XCTAssertTrue([[[notes lastNote] toString] isEqualToString: @"F2"], @"Last note %@ should be F2", notes.lastNote.toString);

}

//---------------------------------------------------------------------

/**
 Edge cases
 
 \p CONDITION 1
 When the first note snapped to the scale has a higher octave number than the fromNote (eg. fromNote=Bb2 scale = A minor pentatonic) a bug existed that caused the second note to begin at an octave higher than expected.
 
 \p CONDITION 2
 A similar hypothetical edge case to test when the fromNote == the first note, 
 */
- (void)testNoteSetEdgeCases
{
    /////////////////////////////////////////
    // CONDITION 1:
    /////////////////////////////////////////
    {
        MusicalNoteSet *noteSet = [_factory noteSetWithScaleID:@"pentatonic-minor" keyStr:@"A" insideRangeFromNoteStr:@"Bb2" toNoteStr:@"D5"];
        
        MusicalNote *n0 = [noteSet.notesArray objectAtIndex:0];
        MusicalNote *n1 = [noteSet.notesArray objectAtIndex:1];
        MusicalNote *nN = [noteSet.notesArray lastObject];
        
        XCTAssertTrue([noteSet noteCount] == 12, @"Should be 12 notes (%i found)", (int)[noteSet noteCount]);
        XCTAssertTrue([[n0 toString] isEqualToString:@"C3"], @"Fail!");
        XCTAssertTrue([[n1 toString] isEqualToString:@"D3"], @"Fail!");
        XCTAssertTrue([[nN toString] isEqualToString:@"D5"], @"Fail!");
    }
    
    /////////////////////////////////////////
    // CONDITION 2:
    /////////////////////////////////////////
    {
        MusicalNoteSet *noteSet = [_factory noteSetWithScaleID:@"pentatonic-minor" keyStr:@"A" insideRangeFromNoteStr:@"C2" toNoteStr:@"C3"];

        MusicalNote *n0 = [noteSet.notesArray objectAtIndex:0];
        MusicalNote *n1 = [noteSet.notesArray objectAtIndex:1];
        MusicalNote *nN = [noteSet.notesArray lastObject];
        
        XCTAssertTrue([noteSet noteCount] == 6, @"Should be 6 notes (%i found)", (int)[noteSet noteCount]);
        XCTAssertTrue([[n0 toString] isEqualToString:@"C2"], @"Fail!");
        XCTAssertTrue([[n1 toString] isEqualToString:@"D2"], @"Fail!");
        XCTAssertTrue([[nN toString] isEqualToString:@"C3"], @"Fail!");
    }
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Key/Interval Functions
/////////////////////////////////////////////////////////////////////////

- (void)testMusicalKeyFunctions
{
    XCTAssertEqual(MusicalFlatVersionOfKey(kMusicalKeyAb), kMusicalKeyAb);
    XCTAssertEqual(MusicalFlatVersionOfKey(kMusicalKeyAs), kMusicalKeyBb);
    XCTAssertEqual(MusicalFlatVersionOfKey(kMusicalKeyD), kMusicalKeyD);
    
    XCTAssertEqual(MusicalSharpVersionOfKey(kMusicalKeyAs), kMusicalKeyAs);
    XCTAssertEqual(MusicalSharpVersionOfKey(kMusicalKeyAb), kMusicalKeyGs);
    XCTAssertEqual(MusicalSharpVersionOfKey(kMusicalKeyF), kMusicalKeyF);
    
    XCTAssertTrue(MusicalKeyIsNatural(kMusicalKeyF));
    XCTAssertFalse(MusicalKeyIsNatural(kMusicalKeyFs));
    XCTAssertFalse(MusicalKeyIsNatural(kMusicalKeyAb));
}



@end

