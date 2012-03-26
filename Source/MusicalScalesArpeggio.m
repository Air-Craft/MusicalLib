//
//  MusicalScalesArpeggio.m
//  SoundWand
//
//  Created by  on 13/03/2012.
//  Copyright (c) 2012 Club 15CC. All rights reserved.
//

#import "MusicalScalesArpeggio.h"

@implementation MusicalScaleArpeggioMajorSixth
+ (NSString const *)name { static NSString const *name = @"Major 6th Arpeggio"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Arpeggios"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,4,7,9}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 4; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleArpeggioMinorSeventh
+ (NSString const *)name { static NSString const *name = @"Minor 7th Arpeggio"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Arpeggios"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,3,7,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 4; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleArpeggioMajorSeventh
+ (NSString const *)name { static NSString const *name = @"Major 7th Arpeggio"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Arpeggios"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,4,7,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 4; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleArpeggioDominantThirteenth
+ (NSString const *)name { static NSString const *name = @"Dominant 13th Arpeggio"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Arpeggios"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,4,7,10,14,17,21}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 2; }
@end
