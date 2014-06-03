//
//  MusicalScaleAbstract.m
//  SoundWand
//
//  Created by Hari Karam Singh on 07/09/2011.
//  Copyright (c) 2011-2014 Amritvela / Club 15CC.  MIT License.
//

#import "MusicalScaleAbstract.h"
#import "MusicalScaleAbstract+.h"

@implementation MusicalScaleAbstract

@synthesize key;

/////////////////////////////////////////////////////////////////////////
#pragma mark - Abstract
/////////////////////////////////////////////////////////////////////////

+ (NSInteger const *)halfstepsArray 
{
    [NSException raise:@"MLIncompleteImplementation" format:@"Subclass must override this method"];
    return 0;
}

+ (NSUInteger const)halfstepsArrayCount 
{
    [NSException raise:@"MLIncompleteImplementation" format:@"Subclass must override this method"]; 
    return 0u;
}

+ (NSUInteger const)octavesCovered 
{
    [NSException raise:@"MLIncompleteImplementation" format:@"Subclass must override this method"]; 
    return 0u;
}

+ (const NSString *)name 
{
    [NSException raise:@"MLIncompleteImplementation" format:@"Subclass must override this method"]; 
    return nil;
}

+ (const NSString *)category
{
    [NSException raise:@"MLIncompleteImplementation" format:@"Subclass must override this method"]; 
    return nil;
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Class Methods
/////////////////////////////////////////////////////////////////////////


+ (NSArray *)scaleNamesArray 
{
    static NSArray *scaleNames;

    if (nil == scaleNames) {
        NSArray *clsArr = [MLObjC subclassesOfClass:[MusicalScaleAbstract class]];
        NSMutableArray *tmpArr = [NSMutableArray array];
        
        // Get the name 
        for (Class cls in clsArr) {
            [tmpArr addObject: [cls name]];
        }
        
        scaleNames = [tmpArr sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];   // de-mutable it
    }
    return scaleNames;
}

/** ********************************************************************/

+ (MusicalScaleAbstract *)musicalScaleFromScaleName:(NSString *)scaleName andKey:(MusicalNoteName)theKey 
{
    static NSMutableDictionary *scaleClassLookup;

    // Init the lookup if needed
    if (nil == scaleClassLookup) {
        NSArray *clsArr = [MLObjC subclassesOfClass:[MusicalScaleAbstract class]];
        scaleClassLookup = [NSMutableDictionary dictionary];
        for (Class cls in clsArr) {
            [scaleClassLookup setObject:cls forKey:[cls name]];
        }
    }
    
    Class scaleClass = [scaleClassLookup objectForKey:scaleName];
    
    if (NULL == scaleClass) {
        [NSException raise:NSInvalidArgumentException format:@"Scale with name '%@' note found", scaleName];
    }
    
    return [[scaleClass alloc] initWithKey:theKey];
}

/////////////////////////////////////////////////////////////////////////

+ (MusicalScaleAbstract *)musicalScaleFromScaleName:(NSString *)scaleName andKeyName:(NSString *)theKeyName
{
    MusicalNoteName key = [MusicalNote noteNameFromString:theKeyName];
    return [self musicalScaleFromScaleName:scaleName andKey:key];
}



/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////


- (id)initWithKey:(MusicalNoteName)theKey 
{
    if (!(self = [super init])) return nil;

    key = theKey;
    
    return self;
}

- (id)init
{
    return [self initWithKey:MUSICAL_NOTE_C];
}

//---------------------------------------------------------------------

- (MusicalScaleAbstract *)musicalScaleWithNewKey:(MusicalNoteName)newKey
{
    MusicalScaleAbstract *newScale = [[self class] new];
    newScale->key = newKey;
    return newScale;
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
/////////////////////////////////////////////////////////////////////////


- (NSUInteger)noteCountForScale 
{
    return [[self class] halfstepsArrayCount];
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

- (NSString *)name 
{
    return (NSString *)[[self class] name];
}

/////////////////////////////////////////////////////////////////////////

- (MusicalNote *)getNearestInKeyNoteGreaterThanOrEqualTo:(MusicalNote *)aNote
{
    return [self getNearestInKeyNoteForNote:aNote above:YES];
}

/////////////////////////////////////////////////////////////////////////

- (MusicalNote *)getNearestInKeyNoteLessThanOrEqualTo:(MusicalNote *)aNote
{
    return [self getNearestInKeyNoteForNote:aNote above:NO];
}

/////////////////////////////////////////////////////////////////////////

- (MusicalNote *)getNearestInKeyNoteForInterval:(MLNoteInterval)anInterval note:(MusicalNote *)aStartNote
{
    // Get the greater and less than notes and choose the one with the lesser interval
    MusicalNote *lowerBound, *upperBound, *notePlusInterval;
    
    notePlusInterval = [aStartNote noteWithInterval:anInterval];

    // Get the note snapped to scale above and below.  See which is closer to the original
    lowerBound = [self getNearestInKeyNoteLessThanOrEqualTo:notePlusInterval];
    upperBound = [self getNearestInKeyNoteGreaterThanOrEqualTo:notePlusInterval];
    
    NSInteger lowerDiff, upperDiff;
    lowerDiff = abs([aStartNote getDifferenceInHalfStepsFrom:lowerBound]);
    upperDiff = abs([aStartNote getDifferenceInHalfStepsFrom:upperBound]);
    
    // If the diffs are equal then choose the note further away for musical considerations
    // Note, this is different for intervals below
    if (anInterval >= MLNoteIntervalUnison) {
        return upperDiff >= lowerDiff ? upperBound : lowerBound;
    } else {
        return upperDiff > lowerDiff ? upperBound : lowerBound;        
    }
}

/////////////////////////////////////////////////////////////////////////

- (NSArray *)getArrayOfNotesInRangeFrom:(MusicalNote *)fromNote to:(MusicalNote *)toNote
{
    NSMutableArray *noteSet;
    MusicalNote *note, *rootNote;
    NSInteger const *halfstepsArr = [[self class] halfstepsArray];
    NSUInteger const halfstepsArrCnt = [[self class] halfstepsArrayCount];
    NSUInteger const octavesCoveredByDef = [[self class] octavesCovered];
    
    // Get the start note snapped to this key/scale
    note = [self getNearestInKeyNoteGreaterThanOrEqualTo:fromNote]; 
    
    // Get the index in the scale definition that represents this note, (wrt the key)
    NSUInteger i = [self getHalfstepDefinitionIndexForNoteName:note.name];
    
    // And get the scale's root note which "note" is relative to, ie note = root + halfstepsArr[i]
    rootNote = [[MusicalNote alloc] initWithNoteName:key andOctave:note.octave];
    // Now get the nearest octave thats below our test Note
    // Even if they are equal, go one octave lower so we can grab the note *below* if
    // requested
    while ([rootNote toInteger] > [note toInteger]) {
        rootNote.octave -= octavesCoveredByDef;
    }
    
    NSAssert(i != NSNotFound, @"This shouldn't be given the previous ops...");
    
    NSInteger octaveAdd = 0;
    noteSet = [[NSMutableArray alloc] init];
    do {
        // Add this note to our set
        [noteSet addObject:note];
        
        // Inc and wrap if we've reached the end
        // and add the octave offset
        if (++i >= halfstepsArrCnt) {
            i = 0;
            octaveAdd += (12 * (NSInteger)octavesCoveredByDef);    // it could be a multi-octave scale!
        }
        
        // And get the next note for the scale
        note = [MusicalNote noteFromAddingHalfsteps:halfstepsArr[i]+octaveAdd toNote:rootNote];    // we've already done index 0 implicitly above
        
        
    } while ([note toInteger] <= [toNote toInteger]);  // no need to snap the end note to the scale. it will be included if relavant 

    return [NSArray arrayWithArray:noteSet];        // convert to immutable type
}

/////////////////////////////////////////////////////////////////////////

- (BOOL)noteNameIsInKey:(MusicalNoteName)testNoteName
{
    return ([self getHalfstepDefinitionIndexForNoteName:testNoteName] != NSNotFound);
}

//---------------------------------------------------------------------

- (NSUInteger)indexOfNoteInScale:(MusicalNoteName)musicalNoteName
{
    return [self getHalfstepDefinitionIndexForNoteName:musicalNoteName];
}

//---------------------------------------------------------------------

- (MusicalNote *)noteWithScalePosition:(NSInteger)relPosition relativeToNote:(MusicalNote *)referenceNote
{
    // We want the number of halfsteps transvered when we move forward (or backward for negative) by `relPosition` notes in the scale starting from the reference note.
    
    // Start by getting the index of the source note's name in the scale definition so we know where we are starting from
    NSInteger idx = [self getHalfstepDefinitionIndexForNoteName:referenceNote.name];
    
    // If the reference is not in the scale then snap to the previous scale note (or next note note if relPos is negative)
    if (idx == NSNotFound) {
        referenceNote = [self getNearestInKeyNoteForNote:referenceNote above:(relPosition > 0)];
        idx = [self getHalfstepDefinitionIndexForNoteName:referenceNote.name];
        NSAssert(idx != NSNotFound, @"Shouldn't be (MSA:nwsp)");
    }
    
    // Now tally up the halfsteps
    NSInteger halfsteps = 0;
    const NSInteger *halfstepsDefArr = [[self class] halfstepsArray];
    NSInteger sign = (relPosition < 0) ? -1 : 1;
    NSInteger iters = abs(relPosition);
    NSUInteger scaleNotes = [[self class] halfstepsArrayCount];
    while (iters-- > 0) {

        // Halfsteps are all relative to root so we need to subtract the next from the current
        // Inc/Dec the idx and wrap for the length of the scale definition array
        NSInteger nextIdx = idx + sign;
        if (nextIdx < 0) idx = scaleNotes - 1;
        else nextIdx %= scaleNotes;
        
        // Get the distance wrt 12 note scale
        NSInteger deltaHalfSteps = halfstepsDefArr[nextIdx] - halfstepsDefArr[idx];
        deltaHalfSteps %= 12;
        if (deltaHalfSteps < 0) deltaHalfSteps += 12;
        
        // Add the halfsteps entry to our tally.  Be sure to account for going backwards
        halfsteps += deltaHalfSteps;
        
    }
    
    // Now shift the reference note by the halfsteps
    MusicalNote *newNote = [MusicalNote noteFromAddingHalfsteps:halfsteps toNote:referenceNote];
    
    return newNote;
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Protected Methods
/////////////////////////////////////////////////////////////////////////

- (MusicalNote *)getNearestInKeyNoteForNote:(MusicalNote *)theNote above:(BOOL)above
{
    MusicalNote *note, *baseNote, *loopStartNote, *prevNote;
    
    //    NSArray *scaleDefArr = [[self class] getScaleDefArray];
    NSInteger const *halfstepsArr = [[self class] halfstepsArray];
    NSUInteger const halfstepsArrCnt = [[self class] halfstepsArrayCount];
    NSUInteger const octavesCoveredByDef = [[self class] octavesCovered];
    
    // Get the basis to which we add halfsteps to get the scale notes
    baseNote = [[MusicalNote alloc] initWithNoteName:key andOctave:theNote.octave];
    
    // Scale the loop start note to the first interval value (as it may not be 0 for scales that dont start on the root note)
    loopStartNote = [MusicalNote noteFromAddingHalfsteps:halfstepsArr[0] toNote:baseNote];
    
    // Now get the nearest octave thats below our test Note
    // Even if they are equal, go one octave lower so we can grab the note *below* if
    // requested
    while ([loopStartNote toInteger] >= [theNote toInteger]) {
        loopStartNote.octave -= octavesCoveredByDef;
    }
    
    // Loop through and find point at which we find or cross over (or match) the test note
    NSUInteger i = 1;
    NSInteger theNoteVal = [theNote toInteger];    // save some calculations
    NSInteger octaveAdd = 0;
    note = [loopStartNote copy];
    do {
        prevNote = note;
        note = [MusicalNote noteFromAddingHalfsteps:halfstepsArr[i]+octaveAdd toNote:loopStartNote];
        
        // loop around our scale definition array
        if (++i >= halfstepsArrCnt) {
            i = 0;
            octaveAdd += (12 * octavesCoveredByDef);    // it could be a multi-octave scale 
        }
    } while ([note toInteger] < theNoteVal);   

    // Check for an exact match first
    if ([note toInteger] == theNoteVal) {
        return note;
    }
    
    // Otherwise prev < theNote < note.  Return the one appropriate for our request...
    return above ? note : prevNote;
}

//---------------------------------------------------------------------

- (NSUInteger)getHalfstepDefinitionIndexForNoteName:(MusicalNoteName)theNoteName
{
    NSInteger const *halfstepsArr = [[self class] halfstepsArray];
    NSUInteger const halfstepsArrCnt = [[self class] halfstepsArrayCount];
    MusicalNote *aStartNote, *note;
    
    // Make a note with our key as the name in any octave and one for the note name to test too
    note = aStartNote = [[MusicalNote alloc] initWithNoteName:key andOctave:0];
    MusicalNote *testNote = [[MusicalNote alloc]  initWithNoteName:theNoteName andOctave:0];
    
    // Loop through the definition until we get a match
    NSUInteger i = 0;

    do {
        // Add first as the first note in our scale might not be the root note!
        note = [MusicalNote noteFromAddingHalfsteps:halfstepsArr[i] toNote:aStartNote];
        
        // Set the octave of our test note to match
        testNote.octave = note.octave;
        
        // return the index on match
        if ([testNote toInteger] == [note toInteger]) {
            return i;
        }
        
    } while (++i < halfstepsArrCnt);
    
    // Otherwise indicate error
    return NSNotFound;
}

@end
