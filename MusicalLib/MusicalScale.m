//
//  MusicalScaleAbstract.m
//  MusicalLib
//
//  Created by Hari Karam Singh on 07/09/2011.
//  Copyright (c) 2011-2015 Air Craft Media Ltd.  MIT License.
//

#import <tgmath.h>
#import "MusicalScale.h"

@implementation MusicalScale

/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////
+ (instancetype)scaleWithDefinition:(MusicalScaleDefinition *)scaleDef key:(MusicalKey)key
{
    return [[self alloc] initWithScaleDefinition:scaleDef key:key];
}

//---------------------------------------------------------------------

- (instancetype)initWithScaleDefinition:(MusicalScaleDefinition *)scaleDef key:(MusicalKey)key
{
    self = [super init];
    if (self) {
        _scaleDefinition = scaleDef;
        _key = key;
    }
    return self;
}

//---------------------------------------------------------------------

- (id)init { [NSException raise:NSGenericException format:@"Use ScaleFactory!"]; return nil; }

//---------------------------------------------------------------------

- (instancetype)copyWithNewKey:(MusicalKey)newKey
{
    return [self.class scaleWithDefinition:self.scaleDefinition key:newKey];
}

//---------------------------------------------------------------------

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ (%p): scaleDef=%@, key=%@", NSStringFromClass(self.class), &self, _scaleDefinition.ID, ML_KeyToString(_key)];
}



/////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
/////////////////////////////////////////////////////////////////////////

- (NSString *)name { return _scaleDefinition.name; }


/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

- (MusicalNote *)nearestInKeyNoteGreaterThanOrEqualTo:(MusicalNote *)aNote
{
    return [self _nearestInKeyNoteForNote:aNote above:YES];
}

//---------------------------------------------------------------------


- (MusicalNote *)nearestInKeyNoteLessThanOrEqualTo:(MusicalNote *)aNote
{
    return [self _nearestInKeyNoteForNote:aNote above:NO];
}

//---------------------------------------------------------------------

- (MusicalNote *)nearestInKeyNoteForInterval:(MusicalInterval)anInterval note:(MusicalNote *)aStartNote
{
    // Get the greater and less than notes and choose the one with the lesser interval
    MusicalNote *lowerBound, *upperBound, *notePlusInterval;
    
    notePlusInterval = [aStartNote noteWithInterval:anInterval];

    // Get the note snapped to scale above and below.  See which is closer to the original
    lowerBound = [self nearestInKeyNoteLessThanOrEqualTo:notePlusInterval];
    upperBound = [self nearestInKeyNoteGreaterThanOrEqualTo:notePlusInterval];
    
    NSInteger lowerDiff, upperDiff;
    lowerDiff = abs((int)[aStartNote halfstepsFromNote:lowerBound]);
    upperDiff = abs((int)[aStartNote halfstepsFromNote:upperBound]);
    
    // If the diffs are equal then choose the note further away for musical considerations
    // Note, this is different for intervals below
    if (anInterval >= kMusicalIntervalUnison) {
        return upperDiff >= lowerDiff ? upperBound : lowerBound;
    } else {
        return upperDiff > lowerDiff ? upperBound : lowerBound;        
    }
}

//---------------------------------------------------------------------

- (NSArray *)arrayOfNotesInRangeFrom:(MusicalNote *)fromNote to:(MusicalNote *)toNote
{
    NSMutableArray *noteSet;
    MusicalNote *note, *rootNote;
    NSUInteger halfstepsArrCnt = _scaleDefinition.halfstepsArr.count;
    NSUInteger const octavesCoveredByDef = floor([_scaleDefinition.halfstepsArr.lastObject integerValue] / 12) + 1;
    
    // Get the start note snapped to this key/scale
    note = [self nearestInKeyNoteGreaterThanOrEqualTo:fromNote]; 
    
    // Get the index in the scale definition that represents this note, (wrt the key)
    NSUInteger i = [self _halfstepDefinitionIndexForKey:note.key];
    
    // And get the scale's root note which "note" is relative to, ie note = root + [_scaleDef.halfstepsArr[i] integerValue]
    rootNote = [[MusicalNote alloc] initWithKey:_key octave:note.octave];
    
    // Now get the nearest octave thats below our test Note
    // Even if they are equal, go one octave lower so we can grab the note *below* if
    // requested
    while ([rootNote toInteger] > [note toInteger]) {
        rootNote = [rootNote noteWithNewOctave:rootNote.octave - octavesCoveredByDef];
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
        note = [MusicalNote noteFromAddingHalfsteps:[_scaleDefinition.halfstepsArr[i] integerValue]+octaveAdd toNote:rootNote];    // we've already done index 0 implicitly above
        
        
    } while ([note toInteger] <= [toNote toInteger]);  // no need to snap the end note to the scale. it will be included if relavant 

    return [NSArray arrayWithArray:noteSet];        // convert to immutable type
}

//---------------------------------------------------------------------

- (BOOL)keyIsInScale:(MusicalKey)key
{
    return ([self _halfstepDefinitionIndexForKey:key] != NSNotFound);
}

//---------------------------------------------------------------------

- (NSUInteger)indexOfKeyInScale:(MusicalKey)MusicalKey
{
    return [self _halfstepDefinitionIndexForKey:MusicalKey];
}

//---------------------------------------------------------------------

- (MusicalNote *)noteWithScalePosition:(NSInteger)relPosition relativeToNote:(MusicalNote *)referenceNote
{
    // We want the number of halfsteps transvered when we move forward (or backward for negative) by `relPosition` notes in the scale starting from the reference note.
    
    // Start by getting the index of the source note's name in the scale definition so we know where we are starting from
    NSInteger idx = [self _halfstepDefinitionIndexForKey:referenceNote.key];
    
    // If the reference is not in the scale then snap to the previous scale note (or next note note if relPos is negative)
    if (idx == NSNotFound) {
        referenceNote = [self _nearestInKeyNoteForNote:referenceNote above:(relPosition > 0)];
        idx = [self _halfstepDefinitionIndexForKey:referenceNote.key];
        NSAssert(idx != NSNotFound, @"Shouldn't be (MSA:nwsp)");
    }
    
    // Now tally up the halfsteps
    NSInteger halfsteps = 0;
    NSInteger sign = (relPosition < 0) ? -1 : 1;
    NSInteger iters = abs((int)relPosition);
    NSUInteger scaleNotes = _scaleDefinition.halfstepsArr.count;
    while (iters-- > 0) {

        // Halfsteps are all relative to root so we need to subtract the next from the current
        // Inc/Dec the idx and wrap for the length of the scale definition array
        NSInteger nextIdx = idx + sign;
        if (nextIdx < 0) nextIdx = scaleNotes - 1;
        else nextIdx %= scaleNotes;
        
        // Get the distance wrt 12 note scale
        NSInteger deltaHalfsteps = [_scaleDefinition.halfstepsArr[nextIdx] integerValue] - [_scaleDefinition.halfstepsArr[idx] integerValue];
        deltaHalfsteps %= 12;
        if (relPosition >= 0 && deltaHalfsteps < 0) deltaHalfsteps += 12;
        else if (relPosition < 0 && deltaHalfsteps >= 0) deltaHalfsteps -= 12;
        
        // Add the halfsteps entry to our tally.  Be sure to account for going backwards
        halfsteps += deltaHalfsteps;
        
    }
    
    // Now shift the reference note by the halfsteps
    MusicalNote *newNote = [MusicalNote noteFromAddingHalfsteps:halfsteps toNote:referenceNote];
    
    return newNote;
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - Additional Privates
/////////////////////////////////////////////////////////////////////////

- (MusicalNote *)_nearestInKeyNoteForNote:(MusicalNote *)theNote above:(BOOL)above
{
    MusicalNote *note, *baseNote, *loopStartNote, *prevNote;
    
    //    NSArray *scaleDefArr = [[self class] getScaleDefArray];
    NSUInteger const halfstepsArrCnt = _scaleDefinition.halfstepsArr.count;
    NSUInteger const octavesCoveredByDef = floor([_scaleDefinition.halfstepsArr.lastObject integerValue] / 12) + 1;
    
    // Get the basis to which we add halfsteps to get the scale notes
    baseNote = [[MusicalNote alloc] initWithKey:_key octave:theNote.octave];
    
    // Scale the loop start note to the first interval value (as it may not be 0 for scales that dont start on the root note)
    loopStartNote = [MusicalNote noteFromAddingHalfsteps:[_scaleDefinition.halfstepsArr[0] integerValue] toNote:baseNote];
    
    // Now get the nearest octave thats below our test Note
    // Even if they are equal, go one octave lower so we can grab the note *below* if
    // requested
    while ([loopStartNote toInteger] >= [theNote toInteger]) {
        loopStartNote = [loopStartNote noteWithNewOctave:loopStartNote.octave - octavesCoveredByDef];
    }
    
    // Loop through and find point at which we find or cross over (or match) the test note
    NSUInteger i = 1;
    NSInteger theNoteVal = [theNote toInteger];    // save some calculations
    NSInteger octaveAdd = 0;
    note = [loopStartNote copy];
    do {
        prevNote = note;
        note = [MusicalNote noteFromAddingHalfsteps:[_scaleDefinition.halfstepsArr[i] integerValue]+octaveAdd toNote:loopStartNote];
        
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

- (NSUInteger)_halfstepDefinitionIndexForKey:(MusicalKey)theKey
{
    NSUInteger const halfstepsArrCnt = _scaleDefinition.halfstepsArr.count;
    MusicalNote *aStartNote, *note;
    
    // Make a note with our key as the name in any octave and one for the note name to test too
    note = aStartNote = [[MusicalNote alloc] initWithKey:_key octave:0];
    MusicalNote *testNote = [[MusicalNote alloc]  initWithKey:theKey octave:0];
    
    // Loop through the definition until we get a match
    NSUInteger i = 0;

    do {
        // Add first as the first note in our scale might not be the root note!
        note = [MusicalNote noteFromAddingHalfsteps:[_scaleDefinition.halfstepsArr[i] integerValue] toNote:aStartNote];
        
        // Set the octave of our test note to match
        testNote = [MusicalNote noteWithKey:testNote.key octave:note.octave];
        
        // return the index on match
        if ([testNote toInteger] == [note toInteger]) {
            return i;
        }
        
    } while (++i < halfstepsArrCnt);
    
    // Otherwise indicate error
    return NSNotFound;
}

@end
