//
//  MusicalNoteSet.h
//  SoundWand
//
//  Created by Hari Karam Singh on 20/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicalScaleAbstract.h"
#import "MusicalNote.h"

/**
 
 DEV NOTES: 
 - Should original requested start/endNote be saved so changing scale snaps to them rather
   than snapping to what they snapped on init or previous scale change ad infinitum?
 */
@interface MusicalNoteSet : NSObject {
    NSArray *musicalNotesArrayCache;
}

@property (nonatomic, strong) MusicalScaleAbstract *scale;

/**
 Note range within which the scale notes will be
 */
@property (nonatomic, strong) MusicalNote *rangeMinNote;
@property (nonatomic, strong) MusicalNote *rangeMaxNote;

/**
 Readonly prop representing start/end notes in the current key
 */
@property (nonatomic, weak, readonly) MusicalNote *actualStartNote;
@property (nonatomic, weak, readonly) MusicalNote *actualEndNote;

/**
 Return an array of MusicalNotes for the scale and bounds
 
 Internally cached for performance.
 */
@property (nonatomic, weak, readonly) NSArray *notesArray;

/** ********************************************************************************************************************/
#pragma mark -
#pragma mark Inits

/** 
 Designated init.  
 Returns object with start/endNote adjusted to 
 fall within the requested range 
 
 \param scale   Note, MusicalScaleAbstract classes include the scale's key
 */
- (MusicalNoteSet *)initWithScale:(MusicalScaleAbstract *)scale
              insideRangeFromNote:(MusicalNote *)fromNote 
                           toNote:(MusicalNote *)toNote;

/**
 Alternative init for convenience
 @param aScaleName  Name of scale eg "Dorian"
 @param aKey        String name of key "G#"
 @param fromNote    Min starting note eg "Ab-2".  If note in key then first in-key note AFTER this note will be used
 @param toNote      Max ending note.
 */
- (MusicalNoteSet *)initWithScaleName:(NSString *)aScaleName
                         scaleKeyString:(NSString *)aKey
                  insideRangeFromNoteString:(NSString *)fromNote 
                               toNoteString:(NSString *)toNote;


/** ********************************************************************************************************************/
#pragma mark -
#pragma mark Public

/**
 Returns MusicalNote at given (0-based) index.  Exception thrown (NSAssert) if out of range.
 */
- (MusicalNote *)noteAtIndex:(NSUInteger)theIdx;

- (MusicalNote *)firstNote;
- (MusicalNote *)lastNote;
- (NSUInteger)noteCount;

/**
 Convenience method for getting the idx of the first note wrt the scale.  Root note = 0
 */
- (NSUInteger)firstNotesIndexInScale;


@end
