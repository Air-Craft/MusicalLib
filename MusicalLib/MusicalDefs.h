/// \ingroup    MusicalLib
/// \file       MLTypes.h
/// \author     Created by  on 02/03/2012.
//  Copyright  (c) 2011-2015 Air Craft Media Ltd.  MIT License.

#ifndef MusicalDefs_h
#define MusicalDefs_h

/////////////////////////////////////////////////////////////////////////
#pragma mark - Types
/////////////////////////////////////////////////////////////////////////

/**
 Constants to identify note names, C, D#, etc.  Note C# != Db.  See
 name property for more info
 */
typedef enum {
    kMusicalKeyC   = 0,
    kMusicalKeyCs = 9,
    kMusicalKeyDb  = 11,
    kMusicalKeyD   = 20,
    kMusicalKeyDs = 29,
    kMusicalKeyEb  = 31,
    kMusicalKeyE  = 40,
    kMusicalKeyF  = 50,
    kMusicalKeyFs = 59,
    kMusicalKeyGb  = 61,
    kMusicalKeyG  = 70,
    kMusicalKeyGs = 79,
    kMusicalKeyAb  = 81,
    kMusicalKeyA  = 90,
    kMusicalKeyAs = 99,
    kMusicalKeyBb  = 101,
    kMusicalKeyB  = 110
} MusicalKey;



/** 
 Musical Interval Constants.  Comparable as ints: MinorSecondBelow < Unison < PerfectFifth ...
 
 DEV NOTE: Values are set to match halfstep intervals for ease of use in code
 */
typedef enum {
    
    kMusicalIntervalUnison = 0,  
    kMusicalIntervalMinorSecond = 1,
    kMusicalIntervalMajorSecond = 2,
    kMusicalIntervalMinorThird = 3,
    kMusicalIntervalMajorThird = 4,

    kMusicalIntervalDiminishedFourth = 4,
    kMusicalIntervalPerfectFourth = 5,
    kMusicalIntervalAugmentedFourth = 6,
    kMusicalIntervalDiminishedFifth = 6,    
    kMusicalIntervalPerfectFifth = 7,
    kMusicalIntervalAugmentedFifth = 8,
    
    kMusicalIntervalMinorSixth = 8,
    kMusicalIntervalMajorSixth = 9,
    kMusicalIntervalMinorSeventh = 10,
    kMusicalIntervalMajorSeventh = 11,
    
    kMusicalIntervalOctave = 12,
    
    // Below...
    
    kMusicalIntervalMinorSecondBelow = -1,
    kMusicalIntervalMajorSecondBelow = -2,
    kMusicalIntervalMinorThirdBelow = -3,
    kMusicalIntervalMajorThirdBelow = -4,
    
    kMusicalIntervalDiminishedFourthBelow = -4,
    kMusicalIntervalPerfectFourthBelow = -5,
    kMusicalIntervalAugmentedFourthBelow = -6,
    kMusicalIntervalDiminishedFifthBelow = -6,    
    kMusicalIntervalPerfectFifthBelow = -7,
    kMusicalIntervalAugmentedFifthBelow = -8,
    
    kMusicalIntervalMinorSixthBelow = -8,
    kMusicalIntervalMajorSixthBelow = -9,
    kMusicalIntervalMinorSeventhBelow = -10,
    kMusicalIntervalMajorSeventhBelow = -11,
    
    kMusicalIntervalOctaveBelow = -12,
    
} MusicalInterval;


/////////////////////////////////////////////////////////////////////////
#pragma mark - Functions
/////////////////////////////////////////////////////////////////////////

/**
 Convert NSStrings like C# and Bb to the MusicalKey enum type.  Proper case only!
 */
MusicalKey MusicalKeyFromString(NSString *keyStr);

/**
 Convert MusicalKey's to NSStrings
 */
NSString *MusicalKeyToString(MusicalKey key);

/** The number of halfsteps to go between the note names of a scale.  Always position forward: F -> E = 11, A => A = 0, B => C = 1 */
NSUInteger MusicalHalfstepsFromKeytoKey(MusicalKey keyA, MusicalKey keyB);

/** Returns the musical key that results from adding/subtracting the specified number of halfsteps and wrapping, Ie  C => -12 => C.  Flats always map to flats (or natural of course) and sharps to sharps */
MusicalKey MusicalKeyShiftedByHalfsteps(MusicalKey key, NSInteger halfsteps);

/** Returns Ab for G#. Ab for Ab and the same for natural notes */
MusicalKey MusicalFlatVersionOfKey(MusicalKey key);

/** Returns G# for Ab. G# for G# and the same for natural notes */
MusicalKey MusicalSharpVersionOfKey(MusicalKey key);

/** YES if note is not a sharp or flat note */
BOOL MusicalKeyIsNatural(MusicalKey key);


#endif
