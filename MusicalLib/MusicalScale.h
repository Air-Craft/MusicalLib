//
//  MusicalScaleAbstract.h
//  MusicalLib
//
/// \author  Created by Hari Karam Singh on 07/09/2011.
//  Copyright (c) 2011-2015 Air Craft Media Ltd.  MIT License.
//

#import <Foundation/Foundation.h>
#import "MusicalNote.h"
#import "MusicalDefs.h"
#import "MusicalScaleDefinition.h"

/**
 Immutable scale object. Scale = definition + musical key. Also contains methods for scale maths.
 */
@interface MusicalScale : NSObject

/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

/** Should generally only be called internally by ScaleFactory */
+ (instancetype)scaleWithDefinition:(MusicalScaleDefinition *)scaleDef key:(MusicalKey)key;
- (instancetype)initWithScaleDefinition:(MusicalScaleDefinition *)scaleDef key:(MusicalKey)key;


/** Make a copy of the scale with a new key */
- (instancetype)scaleWithNewKey:(MusicalKey)newKey;

/** Make a copy of the scale with a new definition (e.g Minor) and the same key */
- (instancetype)scaleWithNewDefinition:(MusicalScaleDefinition *)newScaleDefinition;


/////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
/////////////////////////////////////////////////////////////////////////

/** The underlying key-agnostic, scale definition. */
@property (nonatomic, readonly) MusicalScaleDefinition *scaleDefinition;

@property (nonatomic, readonly) MusicalKey key;

/** Convenience method for the property on the underlying scale definition */
@property (nonatomic, readonly) NSString *name;



/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

/**
 Methods for getting a note in the current key/scale closest to a given note.
 @{
 */
- (MusicalNote *)nearestInKeyNoteGreaterThanOrEqualTo:(MusicalNote *)aNote;
- (MusicalNote *)nearestInKeyNoteLessThanOrEqualTo:(MusicalNote *)aNote;
- (MusicalNote *)nearestInKeyNoteForNote:(MusicalNote *)theNote above:(BOOL)above;
/// @}

/** Checks up and down and returns the closer or the higher if tie  */
//- (MusicalNote *)nearestInKeyNote;

- (MusicalNote *)nearestInKeyNoteForInterval:(MusicalInterval)anInterval note:(MusicalNote *)aStartNote;

/** Returns notes in scale/key in the given range */
- (NSArray *)arrayOfNotesInRangeFrom:(MusicalNote *)fromNote to:(MusicalNote *)toNote;

/** Returns whether the given note name is in this scale/key
 */
- (BOOL)keyIsInScale:(MusicalKey)key;


/**
 Return the idx of the musical note in the scale definition.  C#=Db
 
 Wrapper for protected method @link getHalfstepDefinitionIndexForKey:
 
 @return 0 for first note.  NSNotFound
 */
- (NSUInteger)indexOfKeyInScale:(MusicalKey)MusicalKey;


/** Get the note in this key/scale that is relPosition notes away from the reference. E.g. C1 => -3 in C Major = G0
 
 @param referenceNote   If not in the current scale it will first be snapped to scale in the direction opposite that implied by relPosition
 */
- (MusicalNote *)noteWithScalePosition:(NSInteger)relPosition relativeToNote:(MusicalNote *)referenceNote;


@end