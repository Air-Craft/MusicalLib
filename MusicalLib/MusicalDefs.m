#import "MusicalDefs.h"


MusicalKey ML_KeyFromString(NSString *keyStr)
{
    if ([keyStr isEqualToString:@"C"]) return kMusicalKeyC;
    if ([keyStr isEqualToString:@"C#"]) return kMusicalKeyCs;
    if ([keyStr isEqualToString:@"Db"]) return kMusicalKeyDb;
    if ([keyStr isEqualToString:@"D"]) return kMusicalKeyD;
    if ([keyStr isEqualToString:@"D#"]) return kMusicalKeyDs;
    if ([keyStr isEqualToString:@"Eb"]) return kMusicalKeyEb;
    if ([keyStr isEqualToString:@"E"]) return kMusicalKeyE;
    if ([keyStr isEqualToString:@"F"]) return kMusicalKeyF;
    if ([keyStr isEqualToString:@"F#"]) return kMusicalKeyFs;
    if ([keyStr isEqualToString:@"Gb"]) return kMusicalKeyGb;
    if ([keyStr isEqualToString:@"G"]) return kMusicalKeyG;
    if ([keyStr isEqualToString:@"G#"]) return kMusicalKeyGs;
    if ([keyStr isEqualToString:@"Ab"]) return kMusicalKeyAb;
    if ([keyStr isEqualToString:@"A"]) return kMusicalKeyA;
    if ([keyStr isEqualToString:@"A#"]) return kMusicalKeyAs;
    if ([keyStr isEqualToString:@"Bb"]) return kMusicalKeyBb;
    if ([keyStr isEqualToString:@"B"]) return kMusicalKeyB;
    
    if ([keyStr isEqualToString:@"C"]) return kMusicalKeyC;
    if ([keyStr isEqualToString:@"C#"]) return kMusicalKeyCs;
    if ([keyStr isEqualToString:@"Db"]) return kMusicalKeyDb;
    if ([keyStr isEqualToString:@"D"]) return kMusicalKeyD;
    if ([keyStr isEqualToString:@"D#"]) return kMusicalKeyDs;
    if ([keyStr isEqualToString:@"Eb"]) return kMusicalKeyEb;
    if ([keyStr isEqualToString:@"E"]) return kMusicalKeyE;
    if ([keyStr isEqualToString:@"F"]) return kMusicalKeyF;
    if ([keyStr isEqualToString:@"F#"]) return kMusicalKeyFs;
    if ([keyStr isEqualToString:@"Gb"]) return kMusicalKeyGb;
    if ([keyStr isEqualToString:@"G"]) return kMusicalKeyG;
    if ([keyStr isEqualToString:@"G#"]) return kMusicalKeyGs;
    if ([keyStr isEqualToString:@"Ab"]) return kMusicalKeyAb;
    if ([keyStr isEqualToString:@"A"]) return kMusicalKeyA;
    if ([keyStr isEqualToString:@"A#"]) return kMusicalKeyAs;
    if ([keyStr isEqualToString:@"Bb"]) return kMusicalKeyBb;
    if ([keyStr isEqualToString:@"B"]) return kMusicalKeyB;
    
    [NSException raise:NSInvalidArgumentException format:@"Invalid key string: %@", keyStr];
    
    return kMusicalKeyA;  // Satisfy the compiler
}

//---------------------------------------------------------------------

NSString *ML_KeyToString(MusicalKey key)
{
    switch (key) {
        case kMusicalKeyC: return @"C";
        case kMusicalKeyCs: return @"C#";
        case kMusicalKeyDb: return @"Db";
        case kMusicalKeyD: return @"D";
        case kMusicalKeyDs: return @"D#";
        case kMusicalKeyEb: return @"Eb";
        case kMusicalKeyE: return @"E";
        case kMusicalKeyF: return @"F";
        case kMusicalKeyFs: return @"F#";
        case kMusicalKeyGb: return @"Gb";
        case kMusicalKeyG: return @"G";
        case kMusicalKeyGs: return @"G#";
        case kMusicalKeyAb: return @"Ab";
        case kMusicalKeyA: return @"A";
        case kMusicalKeyAs: return @"A#";
        case kMusicalKeyBb: return @"Bb";
        case kMusicalKeyB: return @"B";
        default:
            [NSException raise:NSInvalidArgumentException format:@"Invalid key constant: %i", (int)key];
            return nil;  // Satisfy the compiler
    }
}

//---------------------------------------------------------------------

NSUInteger ML_HalfstepsFromKeytoKey(MusicalKey keyA, MusicalKey keyB)
{
    // Relies on our enum's values
    NSInteger diff = round((float_t)(keyB - keyA) / 10.);
    
    // If negative then add 12 to get the forward direction
    if (diff < 0) diff += 12.;
    
    return diff;
}

//---------------------------------------------------------------------

MusicalKey ML_KeyShiftedByHalfsteps(MusicalKey key, NSInteger halfsteps)
{
    // We want to keep sharps as sharps and flats as flats
    static MusicalKey sharpScale[12] = {kMusicalKeyC, kMusicalKeyCs, kMusicalKeyD, kMusicalKeyDs, kMusicalKeyE, kMusicalKeyF, kMusicalKeyFs, kMusicalKeyG, kMusicalKeyGs, kMusicalKeyA, kMusicalKeyAs, kMusicalKeyB};
    static MusicalKey flatScale[12] = {kMusicalKeyC, kMusicalKeyDb, kMusicalKeyD, kMusicalKeyEb, kMusicalKeyE, kMusicalKeyF, kMusicalKeyGb, kMusicalKeyG, kMusicalKeyAb, kMusicalKeyA, kMusicalKeyBb, kMusicalKeyB};
    
    // Loop through and find a match.  Try the sharps first...
    NSInteger matchedIdx = NSNotFound;
    MusicalKey *scale;
    for (int i=0; i<12; i++) {
        if (sharpScale[i] == key) {
            matchedIdx = i;
            scale = sharpScale;
            break;
        }
    }
    
    // If no match, then try the flats
    if (matchedIdx == NSNotFound) {
        for (int i=0; i<12; i++) {
            if (flatScale[i] == key) {
                matchedIdx = i;
                scale = flatScale;
            }
        }
    }
    
    if (matchedIdx == NSNotFound) {
        [NSException raise:NSInvalidArgumentException format:@"No matching key for enum %i!", (int)key];
    }
    
    // Now add halfsteps, wrap and return the new note name
    NSInteger newIdx = matchedIdx + halfsteps;
    newIdx %= 12;
    if (newIdx < 0) newIdx += 12;
    
    return scale[newIdx];
}

//---------------------------------------------------------------------

MusicalKey ML_FlatVersionOfKey(MusicalKey key)
{
    switch (key) {
        case kMusicalKeyCs: return kMusicalKeyDb;
        case kMusicalKeyDs: return kMusicalKeyEb;
        case kMusicalKeyFs: return kMusicalKeyGb;
        case kMusicalKeyGs: return kMusicalKeyAb;
        case kMusicalKeyAs: return kMusicalKeyBb;
        default:
            return key;
    }
}

//---------------------------------------------------------------------

MusicalKey ML_SharpVersionOfKey(MusicalKey key)
{
    switch (key) {
        case kMusicalKeyDb: return kMusicalKeyCs;
        case kMusicalKeyEb: return kMusicalKeyDs;
        case kMusicalKeyGb: return kMusicalKeyFs;
        case kMusicalKeyAb: return kMusicalKeyGs;
        case kMusicalKeyBb: return kMusicalKeyAs;
        default:
            return key;
    }
}

//---------------------------------------------------------------------

BOOL ML_KeyIsNatural(MusicalKey key)
{
    switch (key) {
        case kMusicalKeyC:
        case kMusicalKeyD:
        case kMusicalKeyE:
        case kMusicalKeyF:
        case kMusicalKeyG:
        case kMusicalKeyA:
        case kMusicalKeyB:
            return YES;
        default:
            return NO;
    }
}