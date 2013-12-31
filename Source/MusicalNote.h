//
//  Note.h
//  SoundWand
//
//  Created by Hari Karam Singh on 07/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLTypes.h"

/**
 Constants to identify note names, C, D#, etc.  Note C# != Db.  See 
 name property for more info
 */
typedef enum {
    MUSICAL_NOTE_C   = 0,    
    MUSICAL_NOTE_Cs = 9,    
    MUSICAL_NOTE_Db  = 11,     
    MUSICAL_NOTE_D   = 20,    
    MUSICAL_NOTE_Ds = 29,    
    MUSICAL_NOTE_Eb  = 31,     
    MUSICAL_NOTE_E  = 40,      
    MUSICAL_NOTE_F  = 50,     
    MUSICAL_NOTE_Fs = 59,    
    MUSICAL_NOTE_Gb  = 61,     
    MUSICAL_NOTE_G  = 70,     
    MUSICAL_NOTE_Gs = 79,    
    MUSICAL_NOTE_Ab  = 81,     
    MUSICAL_NOTE_A  = 90,    
    MUSICAL_NOTE_As = 99,   
    MUSICAL_NOTE_Bb  = 101,    
    MUSICAL_NOTE_B  = 110
} MusicalNoteName;


/*************************************************************
 Representation of a musical note, eg. C#-2, E3, Gb0
 
 Some notes...
 - Note names like C# do NOT equal their musical equiv, Db.  
   In otherwords its possible to distinguish the two.  To 
   compare them as equal, use toInteger.
 *************************************************************/
@interface MusicalNote : NSObject <NSCopying> {}

/**
 Enum constant for musical note name.  MUSICAL_NOTE_Cs != MUSICAL_NOTE_Db, but
 round(MUSICAL_NOTE_Cs/10) == round(MUSICAL_NOTE_Db/10).
 */
@property (nonatomic) MusicalNoteName name;

/** The string representation of the MusicalNoteName */
@property (nonatomic, readonly) NSString *nameString;

/**
 Any NSInteger value
 */
@property (nonatomic) NSInteger octave;


/**
 Generate a new MusicalNote by adding halfsteps (musical intervals)
 to theNote
 */
+ (MusicalNote *)noteFromAddingHalfsteps:(NSInteger)anInterval toNote:(MusicalNote *)theNote;

/////////////////////////////////////////////////////////////////////////

+ (MusicalNote *)noteWithInterval:(MLNoteInterval)theHalfSteps fromNote:(MusicalNote *)theNote;


/////////////////////////////////////////////////////////////////////////

/**
 Convert NSStrings like C# and Bb to the MusicalNoteName enum type.  Proper case only!
 */
+ (MusicalNoteName)noteNameFromString:(NSString *)noteString;

/**
 Convert MusicalNoteName's to NSStrings
 */
+ (NSString *)noteNameToString:(MusicalNoteName)noteName;

/** The number of halfsteps to go between the note names of a scale.  Always position forward: F -> E = 11, A => A = 0, B => C = 1 */
+ (NSUInteger)halfStepsFromNoteName:(MusicalNoteName)noteA toNoteName:(MusicalNoteName)noteB;


/////////////////////////////////////////////////////////////////////////
#pragma mark - Init methods
/////////////////////////////////////////////////////////////////////////

/**
 Main initializer
 */
- (MusicalNote *)initWithNoteName:(MusicalNoteName)n andOctave:(int)o;

/**
 Initialise from a note string, eg. C#-2
 
 - The first char *must* be uppercase and from A-G
 - The next char is optional and can be a "#" or "b" modifier (anything else is natural)
 - The remainder (not optional) must be an integer value representing the octave
 - Nonexistants like Cb resolve to their existing equivlent, eg B.
 */
- (MusicalNote *)initFromNoteString:(NSString *)noteStr;

/**
 Defaults to C4 (middle C)
 */
- (MusicalNote *)init;



/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

/// Returns a new note with the interval specified interval to this one
- (MusicalNote *)noteWithInterval:(MLNoteInterval)anInterval;

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
- (BOOL)isAnOctaveOf:(MusicalNoteName)aNoteName;

@end



