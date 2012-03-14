#import "MusicalScalesJazz.h"

@implementation MusicalScaleBebopDominant
+ (NSString const *)name { static NSString const *name = @"Bebop Dominant"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,7,9,10,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleDiatonic
+ (NSString const *)name { static NSString const *name = @"Diatonic"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,7,9}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleDiminished
+ (NSString const *)name { static NSString const *name = @"Diminished"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,6,8,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHalfDiminished
+ (NSString const *)name { static NSString const *name = @"Half Diminished"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,4,6,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleWholeDiminished
+ (NSString const *)name { static NSString const *name = @"Whole Diminished"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,6,8,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleWholeToneDiminished
+ (NSString const *)name { static NSString const *name = @"Whole Tone Diminished"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,4,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleDominant7th
+ (NSString const *)name { static NSString const *name = @"Dominant 7th"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleDoubleHarmonic
+ (NSString const *)name { static NSString const *name = @"Double Harmonic"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,7,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHalfDiminishedLocrian
+ (NSString const *)name { static NSString const *name = @"Half Diminished (Locrian)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,5,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHalfDiminishedLocrian2
+ (NSString const *)name { static NSString const *name = @"Half Diminished #2 (Locrian #2)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleLeadingWholeTone
+ (NSString const *)name { static NSString const *name = @"Leading Whole Tone"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,6,8,10,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePhrygianDominant
+ (NSString const *)name { static NSString const *name = @"Phrygian Dominant"; return name; } 
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end


@implementation MusicalScaleLydianAugmented
+ (NSString const *)name { static NSString const *name = @"Lydian Augmented"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,6,8,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleLydianMinor
+ (NSString const *)name { static NSString const *name = @"Lydian Minor"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,6,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleLydianDiminished
+ (NSString const *)name { static NSString const *name = @"Lydian Diminished"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,6,7,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleMajorLocrian
+ (NSString const *)name { static NSString const *name = @"Major Locrian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleMelodicMinorAscending
+ (NSString const *)name { static NSString const *name = @"Melodic Minor Ascending"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,7,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleMelodicMinorDescending
+ (NSString const *)name { static NSString const *name = @"Melodic Minor Descending"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleEnigmatic
+ (NSString const *)name { static NSString const *name = @"Enigmatic"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,6,8,10,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleOctatonicHW
+ (NSString const *)name { static NSString const *name = @"Octatonic (H-W)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,4,6,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleOctatonicWH
+ (NSString const *)name { static NSString const *name = @"Octatonic (W-H)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Normal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,6,8,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleOvertone
+ (NSString const *)name { static NSString const *name = @"Overtone"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,6,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleOvertoneDominant
+ (NSString const *)name { static NSString const *name = @"Overtone Dominant"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Jazz & Exotic"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,6,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end
