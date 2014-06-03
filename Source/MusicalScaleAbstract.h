//
//  MusicalScaleAbstract.h
//  SoundWand
//
/// \author  Created by Hari Karam Singh on 07/09/2011.
//  Copyright (c) 2011-2014 Amritvela / Club 15CC.  MIT License.
//

#import <Foundation/Foundation.h>
#import "MLConfig.h"
#import "MusicalNote.h"
#import "MLObjC.h"
#import "MLTypes.h"

/**
 \ingroup   MusicalLib
 \brief     Abstract base class for musical scale defintions
 \abstract
 */
@interface MusicalScaleAbstract : NSObject {
}

@property (nonatomic) MusicalNoteName key;

/**
 Number of notes in the scales note set (before repeating).  
 
 Note count per "octave" for normal scales.  Reference to internal class property halfstepsArrayCount.
 */
@property (nonatomic, readonly) NSUInteger noteCountForScale;

/////////////////////////////////////////////////////////////////////////
#pragma mark - Class Methods
/////////////////////////////////////////////////////////////////////////

+ (NSString const *)name;
+ (NSString const *)category;

+ (NSArray *)scaleNamesArray;

/////////////////////////////////////////////////////////////////////////

+ (MusicalScaleAbstract *)musicalScaleFromScaleName:(NSString *)scaleName andKey:(MusicalNoteName)theKey;

/////////////////////////////////////////////////////////////////////////

+ (MusicalScaleAbstract *)musicalScaleFromScaleName:(NSString *)scaleName andKeyName:(NSString *)theKeyName;


/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

/**
 Create a scale object which can be used to get notes and intervals for a given scale definition

 \param theKey              The musical key, eg MUSICAL_NOTE_Cs for C#
 */
- (id)initWithKey:(MusicalNoteName)theKey;

/**
 Defaults to key of C
 */
- (id)init;

- (MusicalScaleAbstract *)musicalScaleWithNewKey:(MusicalNoteName)newKey;


/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

/**
 Public convenience methods for getting a note in the current
 key/scale closest to a given note.  
 
 See protected getNearestInKeyNoteForNote:above for more.
 @{
 */
- (MusicalNote *)getNearestInKeyNoteGreaterThanOrEqualTo:(MusicalNote *)aNote;
- (MusicalNote *)getNearestInKeyNoteLessThanOrEqualTo:(MusicalNote *)aNote;
/// @}

/////////////////////////////////////////////////////////////////////////

/// Instance wrapper for class method 
- (NSString *)name;

/////////////////////////////////////////////////////////////////////////

- (MusicalNote *)getNearestInKeyNoteForInterval:(MLNoteInterval)anInterval note:(MusicalNote *)aStartNote;

/////////////////////////////////////////////////////////////////////////


/** Returns notes in scale/key in the given range */
- (NSArray *)getArrayOfNotesInRangeFrom:(MusicalNote *)fromNote to:(MusicalNote *)toNote;

/////////////////////////////////////////////////////////////////////////

/** Returns whether the given note name is in this scale/key
 */
- (BOOL)noteNameIsInKey:(MusicalNoteName)testNoteName;


/////////////////////////////////////////////////////////////////////////

/**
 Return the idx of the musical note in the scale definition.  C#=Db
 
 Wrapper for protected method @link getHalfstepDefinitionIndexForNoteName:
 
 @return 0 for first note.  NSNotFound
 */
- (NSUInteger)indexOfNoteInScale:(MusicalNoteName)musicalNoteName;

//---------------------------------------------------------------------

/** Get the note in this key/scale that is relPosition notes away from the reference. E.g. C1 => -3 in C Major = G0
 
 @param referenceNote   If not in the current scale it will first be snapped to scale in the direction opposite that implied by relPosition
 */
- (MusicalNote *)noteWithScalePosition:(NSInteger)relPosition relativeToNote:(MusicalNote *)referenceNote;


@end