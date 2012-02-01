#import "MusicalScalesNormal.h"

@implementation MusicalScaleMajor
+ (NSString const *)name { static NSString const *name = @"Major"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,7,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHarmonicMinor
+ (NSString const *)name { static NSString const *name = @"Harmonic Minor"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,7,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleNaturalMinor
+ (NSString const *)name { static NSString const *name = @"Natural Minor"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleChromatic
+ (NSString const *)name { static NSString const *name = @"Chromatic"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,2,3,4,5,6,7,8,9,10,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 12; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleWholeTone
+ (NSString const *)name { static NSString const *name = @"Whole Tone"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 6; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePentatonicMajor
+ (NSString const *)name { static NSString const *name = @"Pentatonic Major"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,7,9}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePentatonicMinor
+ (NSString const *)name { static NSString const *name = @"Pentatonic Minor"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,3,5,7,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePentatonicBlues
+ (NSString const *)name { static NSString const *name = @"Pentatonic Blues"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,3,5,6,7,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 6; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePentatonicNeutral
+ (NSString const *)name { static NSString const *name = @"Pentatonic Neutral"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,5,7,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end
