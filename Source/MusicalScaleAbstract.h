//
//  MusicalScaleAbstract.h
//  AirPluckHarp
//
//  Created by Hari Karam Singh on 07/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLConfig.h"
#import "MusicalNote.h"
#import "MLObjC.h"


@interface MusicalScaleAbstract : NSObject {
}

@property (nonatomic) MusicalNoteName key;

/**
 Number of notes in the scales note set (before repeating).  
 
 Note count per "octave" for normal scales.  Reference to internal class property halfstepsArrayCount.
 */
@property (nonatomic, readonly) NSUInteger noteCountForScale;

/** ********************************************************************************************************************/
#pragma mark -
#pragma mark Class methods
+ (NSString const *)name;
+ (NSString const *)category;

+ (NSArray *)scaleNamesArray;
+ (MusicalScaleAbstract *)musicalScaleFromScaleName:(NSString *)scaleName andKey:(MusicalNoteName)theKey ;

/** ********************************************************************************************************************/
#pragma mark -
#pragma mark Publics
/**
 Create a scale object which can be used to get notes and intervals for a given scale definition

 \param theKey              The musical key, eg MUSICAL_NOTE_Cs for C#
 */
- (id)initWithKey:(MusicalNoteName)theKey;

/**
 Defaults to key of C
 */
- (id)init;

/**
 Public convenience methods for getting a note in the current
 key/scale closest to a given note.  
 
 See protected getNearestInKeyNoteForNote:above for more.
 */
- (MusicalNote *)getNearestInKeyNoteGreaterThanOrEqualTo:(MusicalNote *)aNote;
- (MusicalNote *)getNearestInKeyNoteLessThanOrEqualTo:(MusicalNote *)aNote;

- (NSArray *)getArrayOfNotesInRangeFrom:(MusicalNote *)fromNote to:(MusicalNote *)toNote;

/**
 Return the idx of the musical note in the scale definition.  C#=Db
 
 Wrapper for protected method @link getHalfstepDefinitionIndexForNoteName:
 
 @return 0 for first note.  NSUIntegerMax
 */
- (NSUInteger)indexOfNoteInScale:(MusicalNoteName)musicalNoteName;

@end