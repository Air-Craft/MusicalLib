//
//  MusicalNoteSet.h
//  SoundWand
//
//  Created by Hari Karam Singh on 20/11/2011.
//  Copyright (c) 2011-2015 Air Craft Media Ltd.  MIT License.
//

#import <Foundation/Foundation.h>
#import "MusicalScale.h"
#import "MusicalNote.h"

/**
 
 DEV NOTES: 
 - Should original requested start/endNote be saved so changing scale snaps to them rather
   than snapping to what they snapped on init or previous scale change ad infinitum?
 */
@interface MusicalNoteSet : NSObject 

@property (nonatomic, strong) MusicalScale *scale;

/**
 Note range within which the scale notes will be
 */
@property (nonatomic, strong) MusicalNote *rangeMinNote;
@property (nonatomic, strong) MusicalNote *rangeMaxNote;

/**
 Readonly prop representing start/end notes in the current key
 */
@property (nonatomic, strong, readonly) MusicalNote *actualStartNote;
@property (nonatomic, strong, readonly) MusicalNote *actualEndNote;

/**
 Return an array of MusicalNotes for the scale and bounds
 
 Internally cached for performance.
 */
@property (nonatomic, strong, readonly) NSArray *notesArray;

/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

/**
 Designated init. Returns object with start/endNote adjusted to fall within the requested range
 @{
 */
+ (instancetype)noteSetWithScale:(MusicalScale *)scale
             insideRangeFromNote:(MusicalNote *)fromNote
                          toNote:(MusicalNote *)toNote;
- (instancetype)initWithScale:(MusicalScale *)scale
              insideRangeFromNote:(MusicalNote *)fromNote 
                           toNote:(MusicalNote *)toNote;
/** @} */

/** Return a new noteset with the notes augmented shifted by the specified amount of halfsteps.  Changes the key of the underlying scale and the min/max ranges
 */
- (MusicalNoteSet *)noteSetShiftedByHalfSteps:(NSInteger)halfSteps;


- (MusicalNoteSet *)noteSetShiftedByNoteOffsetInScale:(NSInteger)noteOffset;



/////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods
/////////////////////////////////////////////////////////////////////////

/**
 Returns MusicalNote at given (0-based) index.  Exception thrown (NSAssert) if out of range.  Also supports indexed subscripting
 */
- (MusicalNote *)noteAtIndex:(NSUInteger)theIdx;
- (MusicalNote *)objectAtIndexedSubscript:(NSUInteger)idx;

/** Index of the given note in set or NSNotFound if not found.  Musical comparison rather than literal (ie Eb = D#)*/
- (NSUInteger)indexOfNoteInSet:(MusicalNote *)aNote;

- (MusicalNote *)firstNote;
- (MusicalNote *)lastNote;
- (NSUInteger)noteCount;

/** Convenience method for getting the idx of the first note wrt the scale.  Root note = 0 */
- (NSUInteger)firstNotesIndexInScale;




@end
