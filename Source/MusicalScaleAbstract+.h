//
//  MusicalScaleAbstract+.h
//  SoundWand
//
//  Created by Hari Karam Singh on 20/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicalNote.h"

@interface MusicalScaleAbstract()

/**
 Const array of numbers representing the # of halfsteps of each note from root. 
 \abstract
 */
+ (NSInteger const * const)halfstepsArray;

/**
 Number of notes in the array returned by halfstepsArray. Ie, # of notes in the scale
 \abstract
 */
+ (NSUInteger const)halfstepsArrayCount;

/**
 # of octaves covered by the scale.  Supports multioctave scales
 \abstract
 */
+ (NSUInteger const)octavesCovered;


/**
 If the note is not in the key/scale, returns the nearest note in the key/scale above or below as specified
 */
- (MusicalNote *)getNearestInKeyNoteForNote:(MusicalNote *)theNote above:(BOOL)above;
/**
 Utility to return the index of the halfstep array which generates the given note name for the scale 
 */
- (NSUInteger)getHalfstepDefinitionIndexForNoteName:(MusicalNoteName)theNoteName;

@end

