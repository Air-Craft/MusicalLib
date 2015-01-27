//
//  Note.m
//  SoundWand
//
//  Created by Hari Karam Singh on 07/08/2011.
//  Copyright (c) 2011-2015 Air Craft Media Ltd.  MIT License.
//

#import "MusicalNote.h"
#import <tgmath.h>

//---------------------------------------------------------------------
@interface MusicalNote()
@end

//---------------------------------------------------------------------

@implementation MusicalNote

@synthesize name=_name, octave=_octave;

/////////////////////////////////////////////////////////////////////////
#pragma mark - Class Methods
/////////////////////////////////////////////////////////////////////////

+ (MusicalKey)noteNameFromString:(NSString *)noteString
{
    if ([noteString isEqualToString:@"C"]) return kMusicalKeyC;
    if ([noteString isEqualToString:@"C#"]) return kMusicalKeyCs;
    if ([noteString isEqualToString:@"Db"]) return kMusicalKeyDb;
    if ([noteString isEqualToString:@"D"]) return kMusicalKeyD;
    if ([noteString isEqualToString:@"D#"]) return kMusicalKeyDs;
    if ([noteString isEqualToString:@"Eb"]) return kMusicalKeyEb;
    if ([noteString isEqualToString:@"E"]) return kMusicalKeyE;
    if ([noteString isEqualToString:@"F"]) return kMusicalKeyF;
    if ([noteString isEqualToString:@"F#"]) return kMusicalKeyFs;
    if ([noteString isEqualToString:@"Gb"]) return kMusicalKeyGb;
    if ([noteString isEqualToString:@"G"]) return kMusicalKeyG;
    if ([noteString isEqualToString:@"G#"]) return kMusicalKeyGs;
    if ([noteString isEqualToString:@"Ab"]) return kMusicalKeyAb;
    if ([noteString isEqualToString:@"A"]) return kMusicalKeyA;
    if ([noteString isEqualToString:@"A#"]) return kMusicalKeyAs;
    if ([noteString isEqualToString:@"Bb"]) return kMusicalKeyBb;
    if ([noteString isEqualToString:@"B"]) return kMusicalKeyB;

    [NSException raise:@"MLInvalidNoteNameString" format:@"MLInvalidNoteNameString: %@", noteString];
    return kMusicalKeyA;  // Satisfy the compiler
}

//---------------------------------------------------------------------

+ (NSString *)noteNameToString:(MusicalKey)noteName
{
    switch (noteName) {
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
            [NSException raise:@"MLInvalidMusicalKey" format:@"MLInvalidMusicalKey: %u", noteName];
            return nil;  // Satisfy the compiler
    }
}

//---------------------------------------------------------------------

+ (NSUInteger)halfStepsFromNoteName:(MusicalKey)noteA toNoteName:(MusicalKey)noteB
{
    // Relies on our enum's values
    NSInteger diff = round((float_t)(noteB - noteA) / 10.);
    
    // If negative then add 12 to get the forward direction
    if (diff < 0) diff += 12.;
    
    return diff;
}

//---------------------------------------------------------------------

+ (MusicalKey)noteNameFromNoteName:(MusicalKey)noteName shiftedByHalfSteps:(NSInteger)halfSteps
{
    // We want to keep sharps as sharps and flats as flats
    static MusicalKey sharpScale[12] = {kMusicalKeyC, kMusicalKeyCs, kMusicalKeyD, kMusicalKeyDs, kMusicalKeyE, kMusicalKeyF, kMusicalKeyFs, kMusicalKeyG, kMusicalKeyGs, kMusicalKeyA, kMusicalKeyAs, kMusicalKeyB};
    static MusicalKey flatScale[12] = {kMusicalKeyC, kMusicalKeyDb, kMusicalKeyD, kMusicalKeyEb, kMusicalKeyE, kMusicalKeyF, kMusicalKeyGb, kMusicalKeyG, kMusicalKeyAb, kMusicalKeyA, kMusicalKeyBb, kMusicalKeyB};
    
    // Loop through and find a match.  Try the sharps first...
    NSInteger matchedIdx = NSNotFound;
    MusicalKey *scale;
    for (int i=0; i<12; i++) {
        if (sharpScale[i] == noteName) {
            matchedIdx = i;
            scale = sharpScale;
            break;
        }
    }
    
    // If no match, then try the flats
    if (matchedIdx == NSNotFound) {
        for (int i=0; i<12; i++) {
            if (flatScale[i] == noteName) {
                matchedIdx = i;
                scale = flatScale;
            }
        }
    }
    
    NSAssert(matchedIdx != NSNotFound, @"No matching notename for %i!", noteName);
    
    // Now add halfsteps, wrap and return the new note name
    NSInteger newIdx = matchedIdx + halfSteps;
    newIdx %= 12;
    if (newIdx < 0) newIdx += 12;
    
    return scale[newIdx];
}

//---------------------------------------------------------------------

+ (MusicalKey)flatVersionForNoteName:(MusicalKey)noteName
{
    switch (noteName) {
        case kMusicalKeyCs: return kMusicalKeyDb;
        case kMusicalKeyDs: return kMusicalKeyEb;
        case kMusicalKeyFs: return kMusicalKeyGb;
        case kMusicalKeyGs: return kMusicalKeyAb;
        case kMusicalKeyAs: return kMusicalKeyBb;
        default:
            return noteName;
    }
}

//---------------------------------------------------------------------

+ (MusicalKey)sharpVersionForNoteName:(MusicalKey)noteName
{
    switch (noteName) {
        case kMusicalKeyDb: return kMusicalKeyCs;
        case kMusicalKeyEb: return kMusicalKeyDs;
        case kMusicalKeyGb: return kMusicalKeyFs;
        case kMusicalKeyAb: return kMusicalKeyGs;
        case kMusicalKeyBb: return kMusicalKeyAs;
        default:
            return noteName;
    }
}

//---------------------------------------------------------------------

+ (BOOL)noteNameIsNatural:(MusicalKey)noteName
{
    switch (noteName) {
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


/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

+ (instancetype)noteWithKey:(MusicalKey)key octave:(NSInteger)octave
{
    return [[self alloc] initWithKey:key octave:octave];
}

//---------------------------------------------------------------------

- (instancetype)initWithKey:(MusicalKey)n octave:(NSInteger)o {
    if (!(self = [super init])) 
        return nil;

    _name = n;
    _octave = o;
    return self;
}

//---------------------------------------------------------------------

+ (instancetype)noteFromString:(NSString *)noteStr
{
    return [[self alloc] initFromString:noteStr];
}

//---------------------------------------------------------------------

- (instancetype)initFromString:(NSString *)noteStr
{
    NSUInteger len, i=0;
    NSInteger octv;
    unichar letter, modifier='\0', aChar;
    MusicalKey noteName;
    
    len = [noteStr length];
    if (len < 2)        // we need at least a letter and an octave
        return nil;
    
    // First letter between A and G?  Case sensitive!
    //noteStr = [noteStr capitalizedString]; 
    letter = [noteStr characterAtIndex:i++];
    if (!(letter >= 'A' && letter <= 'G'))
        return nil;
    
    // Next character...
    aChar = [noteStr characterAtIndex:i++];
    
    // is it a sharp/flat modifier? Set
    if (aChar == '#' || aChar == 'b') {
        // Still need an octave...
        if (i >= len)
            return nil;
        
        modifier = aChar;
        aChar = [noteStr characterAtIndex:i++];
    }
    
    // Check thats it's the start of the octave
    if ( !( (aChar >= '0' && aChar <= '9')         // between 0 - 9 as chars
            || (len > i && (aChar == '-' || aChar == '+')) ) )   // ensure there is one more char
        return nil;
    
    // Back up one and get this char along with the  rest of the string 
    octv = [[noteStr substringFromIndex:(i-1)] integerValue];
    
    // Now convert it to our properties' types
    // Resolve nonexistent notes like Cb to their equivalents, eg B, for now...
    switch (letter) {
        case 'C':   noteName = (modifier == '#' ? kMusicalKeyCs : (modifier == 'b' ? kMusicalKeyB  : kMusicalKeyC)); break;
        case 'D':   noteName = (modifier == '#' ? kMusicalKeyDs : (modifier == 'b' ? kMusicalKeyDb : kMusicalKeyD)); break;
        case 'E':   noteName = (modifier == '#' ? kMusicalKeyF  : (modifier == 'b' ? kMusicalKeyEb : kMusicalKeyE)); break;
        case 'F':   noteName = (modifier == '#' ? kMusicalKeyFs : (modifier == 'b' ? kMusicalKeyE  : kMusicalKeyF)); break;
        case 'G':   noteName = (modifier == '#' ? kMusicalKeyGs : (modifier == 'b' ? kMusicalKeyGb : kMusicalKeyG)); break;
        case 'A':   noteName = (modifier == '#' ? kMusicalKeyAs : (modifier == 'b' ? kMusicalKeyAb : kMusicalKeyA)); break;
        case 'B':   noteName = (modifier == '#' ? kMusicalKeyC  : (modifier == 'b' ? kMusicalKeyBb : kMusicalKeyB)); break;
        default: return nil; // shouldn't ever be
    }
    
    return [self initWithKey:noteName octave:octv];
}

//---------------------------------------------------------------------

+ (instancetype)noteFromMidiValue:(NSUInteger)midiValue
{
    return [[self alloc] initFromMidiValue:midiValue];
}

//---------------------------------------------------------------------

- (instancetype)initFromMidiValue:(NSUInteger)midiValue
{
    // Should we check bounds here? Nah...
    self = [super init];
    if (self) {
        _octave = floor(midiValue / 12) - 1;    // we're C-1 based
        switch (midiValue % 12) {
            case 0: _name = kMusicalKeyC; break;
            case 1: _name = kMusicalKeyCs; break;
            case 2: _name = kMusicalKeyD; break;
            case 3: _name = kMusicalKeyDs; break;
            case 4: _name = kMusicalKeyE; break;
            case 5: _name = kMusicalKeyF; break;
            case 6: _name = kMusicalKeyFs; break;
            case 7: _name = kMusicalKeyG; break;
            case 8: _name = kMusicalKeyGs; break;
            case 9: _name = kMusicalKeyA; break;
            case 10: _name = kMusicalKeyAs; break;
            case 11: _name = kMusicalKeyB; break;
            default:
                [NSException raise:NSInternalInconsistencyException format:@"Midi note name out of range. Shouldnt be!"];
        }
    }
    return self;
}

//---------------------------------------------------------------------

- (instancetype)init
{
    return [self initWithKey:kMusicalKeyC octave:4];  // middle C
}

//---------------------------------------------------------------------

+ (MusicalNote *)noteFromAddingHalfsteps:(NSInteger)theHalfSteps toNote:(MusicalNote *)theNote
{
    NSInteger newOctave = theNote.octave + theHalfSteps / 12;
    NSInteger newNoteVal = ( (NSInteger)roundf((float)theNote.name/10.0f) ) + (theHalfSteps % 12);
    
    // Convert negative note vals to positive with octave shift
    if (newNoteVal < 0) {
        newOctave -= 1;
        newNoteVal += 12;
    }
    
    // Wrap and add an octave if we're at 12 (or over though this should never be)
    // C# + 11 = 1 + 11 = 12!
    if (newNoteVal >= 12) {
        newOctave += newNoteVal / 12;
        newNoteVal %= 12;
    }
    
    
    // Convert the noteval to our enum
    MusicalKey nameArr[] = {kMusicalKeyC, kMusicalKeyCs, kMusicalKeyDb, kMusicalKeyD,
        kMusicalKeyDs, kMusicalKeyEb, kMusicalKeyE, kMusicalKeyF, kMusicalKeyFs, kMusicalKeyGb, kMusicalKeyG, kMusicalKeyGs, kMusicalKeyAb, kMusicalKeyA, kMusicalKeyAs, kMusicalKeyBb, kMusicalKeyB};
    
    // @TODO This will ALWAYS pull the first value above for equivalent notes (C#/Db).  Perhaps don't round  above and adjust conditionals below to let Db -> Eb and C# -> D#...
    // Lock it to one of our enums (because we have a somewhat cryptic enum vales to designate Db from C#)
    int i;
    newNoteVal *= 10;   // to match our enums
    for (i = 0; i<sizeof(nameArr); i++) {
        if (newNoteVal == nameArr[i] || (newNoteVal+1) == nameArr[i] || (newNoteVal-1) == nameArr[i]) {
            break;
        }
    }
    
    // Now construct the note
    return [[MusicalNote alloc] initWithKey:nameArr[i] octave:newOctave];
}

//---------------------------------------------------------------------

+ (MusicalNote *)noteWithInterval:(MusicalInterval)anInterval fromNote:(MusicalNote *)theNote
{
    // Easy for now
    return [self noteFromAddingHalfsteps:anInterval toNote:theNote];
}



/////////////////////////////////////////////////////////////////////////
#pragma mark - NSDictionary Key Requirements
/////////////////////////////////////////////////////////////////////////

- (id)copyWithZone:(NSZone *)zone
{
    MusicalNote *copy = [[[self class] allocWithZone:zone] init];
    copy.name = self.name;
    copy.octave = self.octave;
    return copy;
}

//---------------------------------------------------------------------

- (BOOL)isEqual:(id)object
{
    if (![object isMemberOfClass:[MusicalNote class]]) {
        return NO;
    }
    //    if ([(MusicalNote *)object octave] == 2) {
    //        NSLog(@"sds");
    //    }
    return ([(MusicalNote *)object name] == _name && [(MusicalNote *)object octave] == _octave);
}

//---------------------------------------------------------------------

- (NSUInteger)hash
{
    // We want Cs != Db here
    return ((NSUInteger)_octave * 120) + _name;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
/////////////////////////////////////////////////////////////////////////

- (NSString *)nameString
{
    return [MusicalNote noteNameToString:self.name];
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

- (MusicalNote *)noteWithInterval:(MusicalInterval)anInterval 
{
    return [[self class] noteWithInterval:anInterval fromNote:self];
}

//---------------------------------------------------------------------

- (NSInteger)toInteger 
{
    return (NSInteger)( (_octave * 12) + (NSUInteger)(roundf((float)_name / 10.0f)) );
}

//---------------------------------------------------------------------

- (NSString *)toString
{
    NSString *noteString;
    
    switch (_name) {
        case kMusicalKeyC:    noteString = [NSString stringWithFormat:@"C%i", (int)_octave];    break;
        case kMusicalKeyCs:   noteString = [NSString stringWithFormat:@"C#%i", (int)_octave];    break;    
        case kMusicalKeyDb:   noteString = [NSString stringWithFormat:@"Db%i", (int)_octave];    break;     
        case kMusicalKeyD:    noteString = [NSString stringWithFormat:@"D%i",  (int)_octave];    break;    
        case kMusicalKeyDs:   noteString = [NSString stringWithFormat:@"D#%i", (int)_octave];    break;    
        case kMusicalKeyEb:   noteString = [NSString stringWithFormat:@"Eb%i", (int)_octave];    break;     
        case kMusicalKeyE:    noteString = [NSString stringWithFormat:@"E%i",  (int)_octave];    break;      
        case kMusicalKeyF:    noteString = [NSString stringWithFormat:@"F%i",  (int)_octave];    break;     
        case kMusicalKeyFs:   noteString = [NSString stringWithFormat:@"F#%i", (int)_octave];    break;    
        case kMusicalKeyGb:   noteString = [NSString stringWithFormat:@"Gb%i", (int)_octave];    break;     
        case kMusicalKeyG:    noteString = [NSString stringWithFormat:@"G%i",  (int)_octave];    break;     
        case kMusicalKeyGs:   noteString = [NSString stringWithFormat:@"G#%i", (int)_octave];    break;    
        case kMusicalKeyAb:   noteString = [NSString stringWithFormat:@"Ab%i", (int)_octave];    break;     
        case kMusicalKeyA:    noteString = [NSString stringWithFormat:@"A%i",  (int)_octave];    break;    
        case kMusicalKeyAs:   noteString = [NSString stringWithFormat:@"A#%i", (int)_octave];    break;   
        case kMusicalKeyBb:   noteString = [NSString stringWithFormat:@"Bb%i", (int)_octave];    break;    
        case kMusicalKeyB:    noteString = [NSString stringWithFormat:@"B%i",  (int)_octave];    break;
        default:   
            noteString = @"Invalid MusicalNote";
    }
    
    return noteString;
}

//---------------------------------------------------------------------

- (NSUInteger)toMidiNoteValue
{
        
    NSInteger midiValue = [self toInteger] + 12;
    
    // don't know about this...
    midiValue = midiValue < 0 
                    ? 0 
                    : (midiValue > 127
                            ? 127
                            : midiValue);
    return midiValue;
}


//---------------------------------------------------------------------

- (NSString *)description 
{
    return [self toString];
}

//---------------------------------------------------------------------

- (BOOL)isInRangeFrom:(MusicalNote *)fromNote to:(MusicalNote *)toNote
{
    NSInteger selfVal = [self toInteger];
    return ([fromNote toInteger] <= selfVal && [toNote toInteger] >= selfVal);
}

//---------------------------------------------------------------------

- (NSInteger)getDifferenceInHalfStepsFrom:(MusicalNote *)aNote 
{
    return ([aNote toInteger] - [self toInteger]);
}

//---------------------------------------------------------------------

- (BOOL)isSameNoteMusically:(MusicalNote *)aNote
{
    return ([aNote toInteger] == [self toInteger]);
}

//---------------------------------------------------------------------

- (BOOL)isAnOctaveOf:(MusicalKey)aNoteName
{
    return (roundf(aNoteName/10.0) == roundf(self.name/10.0));
}

@end



