#import "MusicalScalesWorld.h"

@implementation MusicalScaleAlgerian
+ (NSString const *)name { static NSString const *name = @"Algerian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,6,7,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleArabianA
+ (NSString const *)name { static NSString const *name = @"Arabian (a)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,6,8,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleArabianB
+ (NSString const *)name { static NSString const *name = @"Arabian (b)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleAugmented
+ (NSString const *)name { static NSString const *name = @"Augmented"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,3,4,6,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 6; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleAuxiliaryDiminished
+ (NSString const *)name { static NSString const *name = @"Auxiliary Diminished"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,6,8,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleAuxiliaryAugmented
+ (NSString const *)name { static NSString const *name = @"Auxiliary Augmented"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 6; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleAuxiliaryDiminishedBlues
+ (NSString const *)name { static NSString const *name = @"Auxiliary Diminished Blues"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,4,6,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleBalinese
+ (NSString const *)name { static NSString const *name = @"Balinese"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,7,8}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleBlues
+ (NSString const *)name { static NSString const *name = @"Blues"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,3,5,6,7,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 6; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleByzantine
+ (NSString const *)name { static NSString const *name = @"Byzantine"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,7,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleChinese
+ (NSString const *)name { static NSString const *name = @"Chinese"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,4,6,7,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleChineseMongolian
+ (NSString const *)name { static NSString const *name = @"Chinese Mongolian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,7,9}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleEgyptian
+ (NSString const *)name { static NSString const *name = @"Egyptian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,5,7,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleEightToneSpanish
+ (NSString const *)name { static NSString const *name = @"Eight Tone Spanish"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,4,5,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleEthiopianARaray
+ (NSString const *)name { static NSString const *name = @"Ethiopian (A Raray)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,7,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleEthiopianGeezEzel
+ (NSString const *)name { static NSString const *name = @"Ethiopian (Geez & Ezel)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHawaiian
+ (NSString const *)name { static NSString const *name = @"Hawaiian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,7,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHindu
+ (NSString const *)name { static NSString const *name = @"Hindu"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHindustan
+ (NSString const *)name { static NSString const *name = @"Hindustan"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHirajoshi
+ (NSString const *)name { static NSString const *name = @"Hirajoshi"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,7,8}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHungarianMajor
+ (NSString const *)name { static NSString const *name = @"Hungarian Major"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,3,4,6,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHungarianGypsy
+ (NSString const *)name { static NSString const *name = @"Hungarian Gypsy"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,6,7,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHungarianGypsyPersian
+ (NSString const *)name { static NSString const *name = @"Hungarian Gypsy Persian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,7,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleHungarianMinor
+ (NSString const *)name { static NSString const *name = @"Hungarian Minor"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,6,7,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleJapaneseA
+ (NSString const *)name { static NSString const *name = @"Japanese (A)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,5,7,8}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleJapaneseB
+ (NSString const *)name { static NSString const *name = @"Japanese (B)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,5,7,8}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleJapaneseIchikosucho
+ (NSString const *)name { static NSString const *name = @"Japanese (Ichikosucho)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,6,7,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleJapaneseTaishikicho
+ (NSString const *)name { static NSString const *name = @"Japanese (Taishikicho)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,5,6,7,9,10,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 9; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleJavaneese
+ (NSString const *)name { static NSString const *name = @"Javaneese"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,5,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleJewishAdonaiMalakh
+ (NSString const *)name { static NSString const *name = @"Jewish (Adonai Malakh)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,2,3,5,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleJewishAhabaRabba
+ (NSString const *)name { static NSString const *name = @"Jewish (Ahaba Rabba)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleJewishMagenAbot
+ (NSString const *)name { static NSString const *name = @"Jewish (Magen Abot)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,4,6,8,10,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 8; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleKumoi
+ (NSString const *)name { static NSString const *name = @"Kumoi"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,7,9}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleMohammedan
+ (NSString const *)name { static NSString const *name = @"Mohammedan"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,5,7,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleNeopolitan
+ (NSString const *)name { static NSString const *name = @"Neopolitan"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,5,7,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleNeoploitanMajor
+ (NSString const *)name { static NSString const *name = @"Neoploitan Major"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,5,7,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleNeopolitanMinor
+ (NSString const *)name { static NSString const *name = @"Neopolitan Minor"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleNineToneScale
+ (NSString const *)name { static NSString const *name = @"Nine Tone Scale"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,4,6,7,8,9,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 9; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleOrientalA
+ (NSString const *)name { static NSString const *name = @"Oriental (a)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleOrientalB
+ (NSString const *)name { static NSString const *name = @"Oriental (b)"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,6,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePelog
+ (NSString const *)name { static NSString const *name = @"Pelog"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,7,8}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 5; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePersian
+ (NSString const *)name { static NSString const *name = @"Persian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,6,8,11}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePrometheus
+ (NSString const *)name { static NSString const *name = @"Prometheus"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,4,6,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 6; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScalePrometheusNeopolitan
+ (NSString const *)name { static NSString const *name = @"Prometheus Neopolitan"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,6,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 6; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleRoumanianMinor
+ (NSString const *)name { static NSString const *name = @"Roumanian Minor"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,2,3,6,7,9,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleSixToneSymmetrical
+ (NSString const *)name { static NSString const *name = @"Six Tone Symmetrical"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,8,9}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 6; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleSpanishGypsy
+ (NSString const *)name { static NSString const *name = @"Spanish Gypsy"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,4,5,7,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end

@implementation MusicalScaleSuperLocrian
+ (NSString const *)name { static NSString const *name = @"Super Locrian"; return name; }
+ (NSString const *)category { static NSString const *categ = @"World"; return categ; }
+ (NSInteger const * const)halfstepsArray { static const NSInteger halfsteps[] = {0,1,3,4,6,8,10}; return halfsteps; }
+ (NSUInteger const)halfstepsArrayCount { return 7; }
+ (NSUInteger const)octavesCovered { return 1; }
@end
