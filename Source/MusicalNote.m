//
//  Note.m
//  SoundWand
//
//  Created by Hari Karam Singh on 07/08/2011.
//  Copyright (c) 2011-2014 Amritvela / Club 15CC.  MIT License.
//

#import "MusicalNote.h"
#import <tgmath.h>

//---------------------------------------------------------------------
@interface MusicalNote()
@end

//---------------------------------------------------------------------

@implementation MusicalNote

@synthesize name, octave;

/////////////////////////////////////////////////////////////////////////
#pragma mark - Class Methods
/////////////////////////////////////////////////////////////////////////

+ (MusicalNoteName)noteNameFromString:(NSString *)noteString
{
    if ([noteString isEqualToString:@"C"]) return MUSICAL_NOTE_C;
    if ([noteString isEqualToString:@"C#"]) return MUSICAL_NOTE_Cs;
    if ([noteString isEqualToString:@"Db"]) return MUSICAL_NOTE_Db;
    if ([noteString isEqualToString:@"D"]) return MUSICAL_NOTE_D;
    if ([noteString isEqualToString:@"D#"]) return MUSICAL_NOTE_Ds;
    if ([noteString isEqualToString:@"Eb"]) return MUSICAL_NOTE_Eb;
    if ([noteString isEqualToString:@"E"]) return MUSICAL_NOTE_E;
    if ([noteString isEqualToString:@"F"]) return MUSICAL_NOTE_F;
    if ([noteString isEqualToString:@"F#"]) return MUSICAL_NOTE_Fs;
    if ([noteString isEqualToString:@"Gb"]) return MUSICAL_NOTE_Gb;
    if ([noteString isEqualToString:@"G"]) return MUSICAL_NOTE_G;
    if ([noteString isEqualToString:@"G#"]) return MUSICAL_NOTE_Gs;
    if ([noteString isEqualToString:@"Ab"]) return MUSICAL_NOTE_Ab;
    if ([noteString isEqualToString:@"A"]) return MUSICAL_NOTE_A;
    if ([noteString isEqualToString:@"A#"]) return MUSICAL_NOTE_As;
    if ([noteString isEqualToString:@"Bb"]) return MUSICAL_NOTE_Bb;
    if ([noteString isEqualToString:@"B"]) return MUSICAL_NOTE_B;

    [NSException raise:@"MLInvalidNoteNameString" format:@"MLInvalidNoteNameString: %@", noteString];
    return MUSICAL_NOTE_A;  // Satisfy the compiler
}

//---------------------------------------------------------------------

+ (NSString *)noteNameToString:(MusicalNoteName)noteName
{
    switch (noteName) {
        case MUSICAL_NOTE_C: return @"C";
        case MUSICAL_NOTE_Cs: return @"C#";
        case MUSICAL_NOTE_Db: return @"Db";
        case MUSICAL_NOTE_D: return @"D";
        case MUSICAL_NOTE_Ds: return @"D#";
        case MUSICAL_NOTE_Eb: return @"Eb";
        case MUSICAL_NOTE_E: return @"E";
        case MUSICAL_NOTE_F: return @"F";
        case MUSICAL_NOTE_Fs: return @"F#";
        case MUSICAL_NOTE_Gb: return @"Gb";
        case MUSICAL_NOTE_G: return @"G";
        case MUSICAL_NOTE_Gs: return @"G#";
        case MUSICAL_NOTE_Ab: return @"Ab";
        case MUSICAL_NOTE_A: return @"A";
        case MUSICAL_NOTE_As: return @"A#";
        case MUSICAL_NOTE_Bb: return @"Bb";
        case MUSICAL_NOTE_B: return @"B";
        default:
            [NSException raise:@"MLInvalidMusicalNoteName" format:@"MLInvalidMusicalNoteName: %u", noteName];
            return nil;  // Satisfy the compiler
    }
}

//---------------------------------------------------------------------

+ (NSUInteger)halfStepsFromNoteName:(MusicalNoteName)noteA toNoteName:(MusicalNoteName)noteB
{
    // Relies on our enum's values
    NSInteger diff = round((float_t)(noteB - noteA) / 10.);
    
    // If negative then add 12 to get the forward direction
    if (diff < 0) diff += 12.;
    
    return diff;
}

//---------------------------------------------------------------------

+ (MusicalNoteName)noteNameFromNoteName:(MusicalNoteName)noteName ShiftedByHalfSteps:(NSInteger)halfSteps
{
    // We want to keep sharps as sharps and flats as flats
    static MusicalNoteName sharpScale[12] = {MUSICAL_NOTE_C, MUSICAL_NOTE_Cs, MUSICAL_NOTE_D, MUSICAL_NOTE_Ds, MUSICAL_NOTE_E, MUSICAL_NOTE_F, MUSICAL_NOTE_Fs, MUSICAL_NOTE_G, MUSICAL_NOTE_Gs, MUSICAL_NOTE_A, MUSICAL_NOTE_As, MUSICAL_NOTE_B};
    static MusicalNoteName flatScale[12] = {MUSICAL_NOTE_C, MUSICAL_NOTE_Db, MUSICAL_NOTE_D, MUSICAL_NOTE_Eb, MUSICAL_NOTE_E, MUSICAL_NOTE_F, MUSICAL_NOTE_Gb, MUSICAL_NOTE_G, MUSICAL_NOTE_Ab, MUSICAL_NOTE_A, MUSICAL_NOTE_Bb, MUSICAL_NOTE_B};
    
    // Loop through and find a match.  Try the sharps first...
    NSInteger matchedIdx = NSNotFound;
    MusicalNoteName *scale;
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



/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

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
    MusicalNoteName nameArr[] = {MUSICAL_NOTE_C, MUSICAL_NOTE_Cs, MUSICAL_NOTE_Db, MUSICAL_NOTE_D,    
        MUSICAL_NOTE_Ds, MUSICAL_NOTE_Eb, MUSICAL_NOTE_E, MUSICAL_NOTE_F, MUSICAL_NOTE_Fs, MUSICAL_NOTE_Gb, MUSICAL_NOTE_G, MUSICAL_NOTE_Gs, MUSICAL_NOTE_Ab, MUSICAL_NOTE_A, MUSICAL_NOTE_As, MUSICAL_NOTE_Bb, MUSICAL_NOTE_B};
    
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
    return [[MusicalNote alloc] initWithNoteName:nameArr[i] andOctave:newOctave];
}

//---------------------------------------------------------------------

+ (MusicalNote *)noteWithInterval:(MLNoteInterval)anInterval fromNote:(MusicalNote *)theNote
{
    // Easy for now
    return [self noteFromAddingHalfsteps:anInterval toNote:theNote];
}

//---------------------------------------------------------------------

- (MusicalNote *)initWithNoteName:(MusicalNoteName)n andOctave:(int)o {
    if (!(self = [super init])) 
        return nil;

    name = n;
    octave = o;
    return self;
}

//---------------------------------------------------------------------

- (MusicalNote *)initFromNoteString:(NSString *)noteStr
{
    NSUInteger len, i=0;
    NSInteger octv;
    unichar letter, modifier='\0', aChar;
    MusicalNoteName noteName;
    
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
        case 'C':   noteName = (modifier == '#' ? MUSICAL_NOTE_Cs : (modifier == 'b' ? MUSICAL_NOTE_B  : MUSICAL_NOTE_C)); break;
        case 'D':   noteName = (modifier == '#' ? MUSICAL_NOTE_Ds : (modifier == 'b' ? MUSICAL_NOTE_Db : MUSICAL_NOTE_D)); break;
        case 'E':   noteName = (modifier == '#' ? MUSICAL_NOTE_F  : (modifier == 'b' ? MUSICAL_NOTE_Eb : MUSICAL_NOTE_E)); break;
        case 'F':   noteName = (modifier == '#' ? MUSICAL_NOTE_Fs : (modifier == 'b' ? MUSICAL_NOTE_E  : MUSICAL_NOTE_F)); break;
        case 'G':   noteName = (modifier == '#' ? MUSICAL_NOTE_Gs : (modifier == 'b' ? MUSICAL_NOTE_Gb : MUSICAL_NOTE_G)); break;
        case 'A':   noteName = (modifier == '#' ? MUSICAL_NOTE_As : (modifier == 'b' ? MUSICAL_NOTE_Ab : MUSICAL_NOTE_A)); break;
        case 'B':   noteName = (modifier == '#' ? MUSICAL_NOTE_C  : (modifier == 'b' ? MUSICAL_NOTE_Bb : MUSICAL_NOTE_B)); break;
        default: return nil; // shouldn't ever be
    }
    
    return [self initWithNoteName:noteName andOctave:octv];
}

//---------------------------------------------------------------------

- (MusicalNote *)init 
{
    return [self initWithNoteName:MUSICAL_NOTE_C andOctave:4];  // middle C
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
    return ([(MusicalNote *)object name] == name && [(MusicalNote *)object octave] == octave);
}

//---------------------------------------------------------------------

- (NSUInteger)hash
{
    // We want Cs != Db here
    return ((NSUInteger)octave * 120) + name;
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

- (MusicalNote *)noteWithInterval:(MLNoteInterval)anInterval 
{
    return [[self class] noteWithInterval:anInterval fromNote:self];
}

//---------------------------------------------------------------------

- (NSInteger)toInteger 
{
    return (NSInteger)( (octave * 12) + (NSUInteger)(roundf((float)name / 10.0f)) );
}

//---------------------------------------------------------------------

- (NSString *)toString
{
    NSString *noteString;
    
    switch (name) {
        case MUSICAL_NOTE_C:    noteString = [NSString stringWithFormat:@"C%i",  octave];    break;    
        case MUSICAL_NOTE_Cs:   noteString = [NSString stringWithFormat:@"C#%i", octave];    break;    
        case MUSICAL_NOTE_Db:   noteString = [NSString stringWithFormat:@"Db%i", octave];    break;     
        case MUSICAL_NOTE_D:    noteString = [NSString stringWithFormat:@"D%i",  octave];    break;    
        case MUSICAL_NOTE_Ds:   noteString = [NSString stringWithFormat:@"D#%i", octave];    break;    
        case MUSICAL_NOTE_Eb:   noteString = [NSString stringWithFormat:@"Eb%i", octave];    break;     
        case MUSICAL_NOTE_E:    noteString = [NSString stringWithFormat:@"E%i",  octave];    break;      
        case MUSICAL_NOTE_F:    noteString = [NSString stringWithFormat:@"F%i",  octave];    break;     
        case MUSICAL_NOTE_Fs:   noteString = [NSString stringWithFormat:@"F#%i", octave];    break;    
        case MUSICAL_NOTE_Gb:   noteString = [NSString stringWithFormat:@"Gb%i", octave];    break;     
        case MUSICAL_NOTE_G:    noteString = [NSString stringWithFormat:@"G%i",  octave];    break;     
        case MUSICAL_NOTE_Gs:   noteString = [NSString stringWithFormat:@"G#%i", octave];    break;    
        case MUSICAL_NOTE_Ab:   noteString = [NSString stringWithFormat:@"Ab%i", octave];    break;     
        case MUSICAL_NOTE_A:    noteString = [NSString stringWithFormat:@"A%i",  octave];    break;    
        case MUSICAL_NOTE_As:   noteString = [NSString stringWithFormat:@"A#%i", octave];    break;   
        case MUSICAL_NOTE_Bb:   noteString = [NSString stringWithFormat:@"Bb%i", octave];    break;    
        case MUSICAL_NOTE_B:    noteString = [NSString stringWithFormat:@"B%i",  octave];    break;
        default:   
            noteString = @"Invalid MusicalNote";
    }
    
    return noteString;
}

//---------------------------------------------------------------------

- (NSUInteger)toMidiNoteValue
{
        
    NSInteger midiValue = [self toInteger] + 12;
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

- (BOOL)isAnOctaveOf:(MusicalNoteName)aNoteName
{
    return (roundf(aNoteName/10.0) == roundf(self.name/10.0));
}

@end



