/// \ingroup    MusicalLib
/// \file       MLTypes.h
/// \author     Created by  on 02/03/2012.
//  Copyright  (c) 2011-2015 Air Craft Media Ltd.  MIT License.

#ifndef MusicalLib_MLTypes_h
#define MusicalLib_MLTypes_h


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

#endif
