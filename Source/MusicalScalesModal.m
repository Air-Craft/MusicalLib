#import "MusicalScalesModal.h"

@implementation MusicalScaleIonian
+ (NSString const *)name { static NSString const *name = @"Ionian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Modal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,7,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleDorian
+ (NSString const *)name { static NSString const *name = @"Dorian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Modal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePhrygian
+ (NSString const *)name { static NSString const *name = @"Phrygian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Modal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleLydian
+ (NSString const *)name { static NSString const *name = @"Lydian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Modal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,6,7,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleMixolydian
+ (NSString const *)name { static NSString const *name = @"Mixolydian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Modal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleAeolian
+ (NSString const *)name { static NSString const *name = @"Aeolian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Modal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleLocrian
+ (NSString const *)name { static NSString const *name = @"Locrian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"Modal"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,5,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end
