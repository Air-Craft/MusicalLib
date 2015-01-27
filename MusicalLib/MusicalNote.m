//
//  Note.m
//  MusicalLib
//
//  Created by Hari Karam Singh on 07/08/2011.
//  Copyright (c) 2011-2015 Air Craft Media Ltd.  MIT License.
//

#import "MusicalNote.h"
#import <tgmath.h>

/////////////////////////////////////////////////////////////////////////
#pragma mark - 
/////////////////////////////////////////////////////////////////////////

@interface MusicalNote()
@end

/////////////////////////////////////////////////////////////////////////
#pragma mark -
/////////////////////////////////////////////////////////////////////////

@implementation MusicalNote


/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

+ (instancetype)noteWithKey:(MusicalKey)key octave:(NSInteger)octave
{
    return [[self alloc] initWithKey:key octave:octave];
}

//---------------------------------------------------------------------

- (instancetype)initWithKey:(MusicalKey)key octave:(NSInteger)octave {
    if (!(self = [super init])) 
        return nil;

    _key = key;
    _octave = octave;
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
    MusicalKey key;
    
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
        case 'C':   key = (modifier == '#' ? kMusicalKeyCs : (modifier == 'b' ? kMusicalKeyB  : kMusicalKeyC)); break;
        case 'D':   key = (modifier == '#' ? kMusicalKeyDs : (modifier == 'b' ? kMusicalKeyDb : kMusicalKeyD)); break;
        case 'E':   key = (modifier == '#' ? kMusicalKeyF  : (modifier == 'b' ? kMusicalKeyEb : kMusicalKeyE)); break;
        case 'F':   key = (modifier == '#' ? kMusicalKeyFs : (modifier == 'b' ? kMusicalKeyE  : kMusicalKeyF)); break;
        case 'G':   key = (modifier == '#' ? kMusicalKeyGs : (modifier == 'b' ? kMusicalKeyGb : kMusicalKeyG)); break;
        case 'A':   key = (modifier == '#' ? kMusicalKeyAs : (modifier == 'b' ? kMusicalKeyAb : kMusicalKeyA)); break;
        case 'B':   key = (modifier == '#' ? kMusicalKeyC  : (modifier == 'b' ? kMusicalKeyBb : kMusicalKeyB)); break;
        default: return nil; // shouldn't ever be
    }
    
    return [self initWithKey:key octave:octv];
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
            case 0: _key = kMusicalKeyC; break;
            case 1: _key = kMusicalKeyCs; break;
            case 2: _key = kMusicalKeyD; break;
            case 3: _key = kMusicalKeyDs; break;
            case 4: _key = kMusicalKeyE; break;
            case 5: _key = kMusicalKeyF; break;
            case 6: _key = kMusicalKeyFs; break;
            case 7: _key = kMusicalKeyG; break;
            case 8: _key = kMusicalKeyGs; break;
            case 9: _key = kMusicalKeyA; break;
            case 10: _key = kMusicalKeyAs; break;
            case 11: _key = kMusicalKeyB; break;
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

+ (MusicalNote *)noteFromAddingHalfsteps:(NSInteger)theHalfsteps toNote:(MusicalNote *)theNote
{
    NSInteger newOctave = theNote.octave + theHalfsteps / 12;
    NSInteger newNoteVal = ( (NSInteger)roundf((float)theNote.key/10.0f) ) + (theHalfsteps % 12);
    
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
    copy->_key = _key;
    copy->_octave = _octave;
    return copy;
}

//---------------------------------------------------------------------

- (BOOL)isEqual:(id)object
{
    if (![object isMemberOfClass:[MusicalNote class]]) {
        return NO;
    }
    
    return ([(MusicalNote *)object key] == _key && [(MusicalNote *)object octave] == _octave);
}

//---------------------------------------------------------------------

- (NSUInteger)hash
{
    // We want Cs != Db here
    return ((NSUInteger)_octave * 120) + _key;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
/////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

- (MusicalNote *)noteWithInterval:(MusicalInterval)anInterval 
{
    return [[self class] noteWithInterval:anInterval fromNote:self];
}

//---------------------------------------------------------------------

- (MusicalNote *)noteWithNewOctave:(NSInteger)newOctave
{
    return [[self class] noteWithKey:self.key octave:newOctave];
}

//---------------------------------------------------------------------

- (NSInteger)toInteger 
{
    return (NSInteger)( (_octave * 12) + (NSUInteger)(roundf((float)_key / 10.0f)) );
}

//---------------------------------------------------------------------

- (NSString *)toString
{
    NSString *noteString;
    
    switch (_key) {
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

- (NSInteger)halfstepsFromNote:(MusicalNote *)aNote 
{
    return ([aNote toInteger] - [self toInteger]);
}

//---------------------------------------------------------------------

- (BOOL)isSameNoteMusically:(MusicalNote *)aNote
{
    return ([aNote toInteger] == [self toInteger]);
}

//---------------------------------------------------------------------

- (BOOL)isAnOctaveOf:(MusicalKey)aKey
{
    return (roundf(aKey/10.0) == roundf(self.key/10.0));
}

@end



