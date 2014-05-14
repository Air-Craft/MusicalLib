/// \ingroup    MusicalLib
/// \file       MLTypes.h
/// \author     Created by  on 02/03/2012.
//  Copyright  (c) 2011-2014 Amritvela / Club 15CC.  MIT License.

#ifndef MusicalLib_MLTypes_h
#define MusicalLib_MLTypes_h

/** 
 Musical Interval Constants.  Comparable as ints: MinorSecondBelow < Unison < PerfectFifth ...
 
 DEV NOTE: Values are set to match halfstep intervals for ease of use in code
 */
typedef enum {
    
    MLNoteIntervalUnison = 0,  
    MLNoteIntervalMinorSecond = 1,
    MLNoteIntervalMajorSecond = 2,
    MLNoteIntervalMinorThird = 3,
    MLNoteIntervalMajorThird = 4,

    MLNoteIntervalDiminishedFourth = 4,
    MLNoteIntervalPerfectFourth = 5,
    MLNoteIntervalAugmentedFourth = 6,
    MLNoteIntervalDiminishedFifth = 6,    
    MLNoteIntervalPerfectFifth = 7,
    MLNoteIntervalAugmentedFifth = 8,
    
    MLNoteIntervalMinorSixth = 8,
    MLNoteIntervalMajorSixth = 9,
    MLNoteIntervalMinorSeventh = 10,
    MLNoteIntervalMajorSeventh = 11,
    
    MLNoteIntervalOctave = 12,
    
    // Below...
    
    MLNoteIntervalMinorSecondBelow = -1,
    MLNoteIntervalMajorSecondBelow = -2,
    MLNoteIntervalMinorThirdBelow = -3,
    MLNoteIntervalMajorThirdBelow = -4,
    
    MLNoteIntervalDiminishedFourthBelow = -4,
    MLNoteIntervalPerfectFourthBelow = -5,
    MLNoteIntervalAugmentedFourthBelow = -6,
    MLNoteIntervalDiminishedFifthBelow = -6,    
    MLNoteIntervalPerfectFifthBelow = -7,
    MLNoteIntervalAugmentedFifthBelow = -8,
    
    MLNoteIntervalMinorSixthBelow = -8,
    MLNoteIntervalMajorSixthBelow = -9,
    MLNoteIntervalMinorSeventhBelow = -10,
    MLNoteIntervalMajorSeventhBelow = -11,
    
    MLNoteIntervalOctaveBelow = -12,
    
} MLNoteInterval;

/////////////////////////////////////////////////////////////////////////

#endif
