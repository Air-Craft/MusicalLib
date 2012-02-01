//
//  MusicalScaleAbstract.m
//  AirPluckHarp
//
//  Created by Hari Karam Singh on 07/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicalScale.h"

@interface MusicalScale()

/**
 If the note is not in the key/scale, returns the nearest note in the key/scale above or below as specified
 */
- (MusicalNote *)getNearestNoteInKeyForNote:(MusicalNote *)theNote above:(BOOL)above;
/**
 Utility to return the index of the halfstep array which generates the given note name for the scale 
 */
- (NSUInteger)getHalfstepDefinitionIndexForNoteName:(MusicalNoteName)theNoteName;

@end


@implementation MusicalScale

@synthesize scaleDefClass;
@synthesize key, startNote, endNote;

/*********************************************************************/
#pragma mark -
#pragma mark Init/Dealloc Methods


/*********************************************************************/

- (id)initWithScaleDefinition:(Class<MusicalScaleDefinitionProtocol>)theScaleDefClass 
                        inKey:(MusicalNoteName)theKey 
                    startNote:(MusicalNote *)theStartNote 
                      endNote:(MusicalNote *)theEndNote
{
    if (!(self = [super init])) return nil;
    
    scaleDefClass = theScaleDefClass;
    key = theKey;
    startNote   = theStartNote;
    endNote     = theEndNote;
    
    return self;
}


/*********************************************************************/
- (id)init
{
    MusicalNote *start = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:0];
    MusicalNote *end = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:1];

    return [self initWithScaleDefinition:[MusicalScaleDefinitionMajor class] 
                                   inKey:MUSICAL_NOTE_C 
                               startNote:start 
                                 endNote:end];
}

/*********************************************************************/
#pragma mark -
#pragma mark Public Methods


- (NSArray *)getNotesArray
{
    NSMutableArray *noteSet;
    MusicalNote *note, *rootNote;
    NSInteger const *halfstepsArr = [scaleDefClass halfstepsArray];
    NSUInteger const halfstepsArrCnt = [scaleDefClass halfstepsArrayCount];
    NSUInteger const octavesCoveredByDef = [scaleDefClass octavesCovered];
    
    // Get the start note snapped to this key/scale
    note = [self getNearestNoteInKeyForNote:startNote above:YES]; 
    
    // Get the index in the scale definition that represents this note, (wrt the key)
    NSUInteger i = [self getHalfstepDefinitionIndexForNoteName:note.name];
    
    // And get the scale's root note which "note" is relative to, ie note = root + halfstepsArr[i]
    rootNote = [[MusicalNote alloc] initWithNoteName:key andOctave:note.octave];
    
    if (i == NSUIntegerMax) {
        DLOG(@"This shouldn't be given the previous ops...");
        return nil;
    }
    
    NSInteger octaveAdd = 0;
    noteSet = [[NSMutableArray alloc] init];
    do {
        // Add this note to our set
        [noteSet addObject:note];
        
        // Inc and wrap if we've reached the end
        // and add the octave offset
        if (++i >= halfstepsArrCnt) {
            i = 0;
            octaveAdd += (12 * (NSInteger)octavesCoveredByDef);    // it could be a multi-octave scale
        }
        
        // And get the next note for the scale
        note = [MusicalNote noteFromAddingHalfsteps:halfstepsArr[i]+octaveAdd toNote:rootNote];    // we've already done index 0 implicitly above
        
        
    } while ([note toInteger] <= [endNote toInteger]);  // no need to snap the end note to the scale. it will be included if relavant 

    return [NSArray arrayWithArray:noteSet];        // convert to immutable type
}
/*********************************************************************/


/*********************************************************************/
#pragma mark -
#pragma mark Protected Method

- (MusicalNote *)getNearestNoteInKeyForNote:(MusicalNote *)theNote above:(BOOL)above
{
    MusicalNote *note, *loopStartNote, *prevNote;
    
    //    NSArray *scaleDefArr = [[self class] getScaleDefArray];
    NSInteger const *halfstepsArr = [scaleDefClass halfstepsArray];
    NSUInteger const halfstepsArrCnt = [scaleDefClass halfstepsArrayCount];
    NSUInteger const octavesCoveredByDef = [scaleDefClass octavesCovered];
    
    // Get the starting note for our hunt:  the root note for the key we're in nearest but below theNote
    loopStartNote = [[MusicalNote alloc] initWithNoteName:key andOctave:theNote.octave];
    
    // Scale the startNote to the first interval value (as it may not be 0 for scales that dont start on the root note)
    loopStartNote = [MusicalNote noteFromAddingHalfsteps:halfstepsArr[0] toNote:loopStartNote];
    
    // Now get the nearest octave thats below our test Note
    while ([loopStartNote toInteger] > [theNote toInteger]) {
        loopStartNote.octave -= octavesCoveredByDef;
    }
    
    // Loop through and find point at which we find or cross over the test note
    NSUInteger i = 1;
    NSInteger theNoteVal = [theNote toInteger];    // save some calculations
    NSInteger octaveAdd = 0;
    note = loopStartNote;
    while ([note toInteger] < theNoteVal) {
        prevNote = note;
        note = [MusicalNote noteFromAddingHalfsteps:halfstepsArr[i]+octaveAdd toNote:loopStartNote];
        
        // loop around our scale definition array
        if (++i >= halfstepsArrCnt) {
            i = 0;
            octaveAdd += (12 * octavesCoveredByDef);    // it could be a multi-octave scale 
        }
    }    

    // Check for an exact match first
    if ([note toInteger] == theNoteVal) {
        return note;
    }
    
    // Otherwise prev < theNote < note.  Return the one appropriate for our request...
    return above ? note : prevNote;
}

/*********************************************************************/

- (NSUInteger)getHalfstepDefinitionIndexForNoteName:(MusicalNoteName)theNoteName
{
    NSInteger const *halfstepsArr = [scaleDefClass halfstepsArray];
    NSUInteger const halfstepsArrCnt = [scaleDefClass halfstepsArrayCount];
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
    return NSUIntegerMax;
}
/*********************************************************************/
/*********************************************************************/


@end
