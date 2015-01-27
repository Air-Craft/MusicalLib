//
//  Note.h
//  MusicalLib
//
//  Created by Hari Karam Singh on 07/08/2011.
//  Copyright (c) 2011-2015 Air Craft Media Ltd.  MIT License.
//

#import <Foundation/Foundation.h>
#import "MusicalTypes.h"



/*************************************************************
 Representation of a musical note, eg. C#-2, E3, Gb0
 
 Some notes...
 - Note names like C# do NOT equal their musical equiv, Db.  
   In otherwords its possible to distinguish the two.  To 
   compare them as equal, use toInteger.
 *************************************************************/
@interface MusicalNote : NSObject <NSCopying>

/////////////////////////////////////////////////////////////////////////
#pragma mark - Class Methods
/////////////////////////////////////////////////////////////////////////

/**
 Convert NSStrings like C# and Bb to the MusicalKey enum type.  Proper case only!
 */
+ (MusicalKey)noteNameFromString:(NSString *)noteString;

/**
 Convert MusicalKey's to NSStrings
 */
+ (NSString *)noteNameToString:(MusicalKey)noteName;

/** The number of halfsteps to go between the note names of a scale.  Always position forward: F -> E = 11, A => A = 0, B => C = 1 */
+ (NSUInteger)halfStepsFromNoteName:(MusicalKey)noteA toNoteName:(MusicalKey)noteB;

/** Returns the musical note name that results from adding/subtracting the specified number of halfsteps and wrapping, Ie  C => -12 => C.  Flats always map to flats (or natural of course) and sharps to sharps */
+ (MusicalKey)noteNameFromNoteName:(MusicalKey)noteName shiftedByHalfSteps:(NSInteger)halfSteps;

/** Returns Ab for G#. Ab for Ab and the same for natural notes */
+ (MusicalKey)flatVersionForNoteName:(MusicalKey)noteName;

/** Returns G# for Ab. G# for G# and the same for natural notes */
+ (MusicalKey)sharpVersionForNoteName:(MusicalKey)noteName;


+ (BOOL)noteNameIsNatural:(MusicalKey)noteName;


// plus class initialisers below...




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

+ (MusicalNote *)noteWithInterval:(MusicalInterval)theHalfSteps fromNote:(MusicalNote *)theNote;


/////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
/////////////////////////////////////////////////////////////////////////


/**
 Enum constant for musical note name.  kMusicalKeyCs != kMusicalKeyDb, but
 round(kMusicalKeyCs/10) == round(kMusicalKeyDb/10).
 */
@property (nonatomic) MusicalKey name;

/** The string representation of the MusicalKey */
@property (nonatomic, readonly) NSString *nameString;

/**
 Any NSInteger value
 */
@property (nonatomic) NSInteger octave;



/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

/// Returns a new note with the interval specified interval to this one
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
- (NSInteger)getDifferenceInHalfStepsFrom:(MusicalNote *)aNote;

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
- (BOOL)isAnOctaveOf:(MusicalKey)aNoteName;

@end



