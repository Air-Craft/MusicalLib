//
//  Note.h
//  MusicalLib
//
//  Created by Hari Karam Singh on 07/08/2011.
//  Copyright (c) 2011-2015 Air Craft Media Ltd.  MIT License.
//

#import <Foundation/Foundation.h>
#import "MusicalDefs.h"



/**
 Representation of a musical note, eg. C#-2, E3, Gb0
 
 Some notes...
 - Note names like C# do NOT equal their musical equiv, Db.  
   In otherwords its possible to distinguish the two.  To 
   compare them as equal, use toInteger.
 */
@interface MusicalNote : NSObject <NSCopying>

/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

/**
 Main initializer
 */
+ (instancetype)noteWithKey:(MusicalKey)key octave:(NSInteger)octave;
- (instancetype)initWithKey:(MusicalKey)key octave:(NSInteger)octave;

//---------------------------------------------------------------------

/**
 Initialise from a note string, eg. C#-2
 
 - The first char *must* be uppercase and from A-G
 - The next char is optional and can be a "#" or "b" modifier (anything else is natural)
 - The remainder (not optional) must be an integer value representing the octave
 - Nonexistants like Cb resolve to their existing equivlent, eg B.
 */
+ (instancetype)noteFromString:(NSString *)noteStr;
- (instancetype)initFromString:(NSString *)noteStr;

//---------------------------------------------------------------------

/** Converts the midiValue 0-127 to the corresponding note @{ */
+ (instancetype)noteFromMidiValue:(NSUInteger)midiValue;
- (instancetype)initFromMidiValue:(NSUInteger)midiValue;
/** @} */

//---------------------------------------------------------------------

/**
 Defaults to C4 (middle C)
 */
- (instancetype)init;

//---------------------------------------------------------------------

/**
 Generate a new MusicalNote by adding halfsteps (musical intervals)
 to theNote
 */
+ (MusicalNote *)noteFromAddingHalfsteps:(NSInteger)anInterval toNote:(MusicalNote *)theNote;

//---------------------------------------------------------------------

+ (MusicalNote *)noteWithInterval:(MusicalInterval)theHalfsteps fromNote:(MusicalNote *)theNote;


/////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
/////////////////////////////////////////////////////////////////////////


/**
 Enum constant for musical note name.  kMusicalKeyCs != kMusicalKeyDb, but
 round(kMusicalKeyCs/10) == round(kMusicalKeyDb/10).
 */
@property (nonatomic) MusicalKey key;


/**
 Any NSInteger value
 */
@property (nonatomic) NSInteger octave;



/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

/** Returns a new note with the interval specified interval to this one */
- (MusicalNote *)noteWithInterval:(MusicalInterval)anInterval;

/**
 Calculate a hash representing the distance in half steps from C0.  
 
 Note, C# == Db, etc... 
 */
- (NSInteger)toInteger; 

/**
 Convert to a string
 */
- (NSString *)toString;

/**
 Convert to a MIDI Note value 0-127
 */
- (NSUInteger)toMidiNoteValue;

/**
 Checks whether self is within the specified note range (inclusively)
 */
- (BOOL)isInRangeFrom:(MusicalNote *)fromNote to:(MusicalNote *)toNote;

/**
 Returns aNote - self. 0 = same note, musically (ie C# = Db). Negative means
 aNote is lower than self.
 */
- (NSInteger)halfstepsFromNote:(MusicalNote *)aNote;

/**
 NSObject override.  (C#2 != Db2).  Returns NO if object isnt a musical note.
 */
- (BOOL)isEqual:(id)object;

/**
 Returns YES if the notes are the same, musically, ie C#2 = Db2 
 */
- (BOOL)isSameNoteMusically:(MusicalNote *)aNote;

/**
 Return YES if the note has an equivalent note name, with C# = Db, etc.
 */
- (BOOL)isAnOctaveOf:(MusicalKey)aKey;

@end



