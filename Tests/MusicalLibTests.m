//
//  MusicalNoteTests.m
//  AirPluckHarp
//
//  Created by Hari Karam Singh on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "MusicalLibTests.h"


@implementation MusicalLibTests


- (void)testNoteToString 
{
    MusicalNote *note;
    
    note = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_G andOctave:0];
    STAssertTrue([[note toString] isEqualToString:@"G0"], @"Incorrect note string: %@", note);
    
    note = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_Cs andOctave:-1];
    STAssertTrue([[note toString] isEqualToString:@"C#-1"], @"Incorrect note string: %@", note);
    
    note = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_Eb andOctave:100];
    STAssertTrue([[note toString] isEqualToString:@"Eb100"], @"Incorrect note string: %@", note);
}

/*********************************************************************/

- (void)testNoteAdd
{
    MusicalNote *noteA;
    MusicalNote *noteB;
    
    // c1 + 1 = c#1
    noteA = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:1];
    noteB = [MusicalNote noteFromAddingHalfsteps:1 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"C#1"], @"Incorrect note: %@", noteB);

    // c0 - 1 = b-1
    noteA = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:0];
    noteB = [MusicalNote noteFromAddingHalfsteps:-1 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"B-1"], @"Incorrect note: %@", noteB);

    // e-1 + 25 = f1
    noteA = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_E andOctave:-1];
    noteB = [MusicalNote noteFromAddingHalfsteps:25 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"F1"], @"Incorrect note: %@", noteB);

    // f1 - 25 = e-1
    noteA = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_F andOctave:1];
    noteB = [MusicalNote noteFromAddingHalfsteps:-25 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"E-1"], @"Incorrect note: %@", noteB);
    
    // c-1 - 13 = b-3
    noteA = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:-1];
    noteB = [MusicalNote noteFromAddingHalfsteps:-13 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"B-3"], @"Incorrect note: %@", noteB);
    
    // A-1 + 2 - 2 = A-1
    noteA = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_A andOctave:-1];
    noteB = [MusicalNote noteFromAddingHalfsteps:2 toNote:noteA];
    noteB = [MusicalNote noteFromAddingHalfsteps:-2 toNote:noteB];
    STAssertTrue([[noteB toString] isEqualToString:[noteA toString]], @"Incorrect note: %@", noteB);
    
}

/*********************************************************************/

- (void)testMusicalNoteSets
{
    MusicalNote *startNote, *endNote;
    MusicalScaleAbstract *scale;
    MusicalNoteSet *notes;
    
    // C Major (C0 - C4)
    startNote   = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:0];
    endNote     = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:4];
    scale       = [[MusicalScaleMajor alloc] initWithKey:MUSICAL_NOTE_C];
    notes       = [[MusicalNoteSet alloc] initWithScale:scale insideRangeFromNote:startNote toNote:endNote];
    STAssertTrue([[[notes noteAtIndex:0] toString] isEqualToString: @"C0"], @"C Major: Incorrect note at index 0: %@", [notes noteAtIndex:0]);
    STAssertTrue([[[notes noteAtIndex:1] toString] isEqualToString: @"D0"], @"C Major: Incorrect note at index 1: %@", [notes noteAtIndex:1]);
    STAssertTrue([[[notes noteAtIndex:6] toString] isEqualToString: @"B0"], @"C Major: Incorrect note at index 6: %@", [notes noteAtIndex:6]);
    STAssertTrue([[[notes noteAtIndex:7] toString] isEqualToString: @"C1"], @"C Major: Incorrect note at index 7: %@", [notes noteAtIndex:7]);
    STAssertTrue([[[notes noteAtIndex:28] toString] isEqualToString: @"C4"], @"C Major: Incorrect note at index 28: %@", [notes noteAtIndex:28]);
    
    // C# Major (B-1 - B2, should snap nearest note in key)
    startNote   = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_B andOctave:-1];
    endNote     = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_B andOctave:2];
    scale       = [[MusicalScaleMajor alloc] initWithKey:MUSICAL_NOTE_Cs];
    notes       = [[MusicalNoteSet alloc] initWithScale:scale insideRangeFromNote:startNote toNote:endNote];
    STAssertTrue([[[notes noteAtIndex:0] toString] isEqualToString: @"C0"],   @"C# Major: Incorrect note at index 0: %@", [notes noteAtIndex:0]);
    STAssertTrue([[[notes lastNote] toString] isEqualToString: @"A#2"],        @"C# Major: Incorrect note at last index: %@", [notes lastNote]);
    
    // Test init from strings
//    startNote   = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_Db andOctave:-1];  // should snap to D
//    endNote     = [[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_F andOctave:2];    // Minor 3rd is in key
    notes = [[MusicalNoteSet alloc] initWithScaleName:@"Dorian" 
                                       scaleKeyString:@"D" 
                            insideRangeFromNoteString:@"Db-1" 
                                         toNoteString:@"F2"];
    NSLog(@"%@", [notes.scale isKindOfClass:[MusicalScaleDorian class]]);
    STAssertTrue([notes.scale isMemberOfClass:[MusicalScaleDorian class]],   @"Init from string test failed!");
    STAssertTrue([[[notes noteAtIndex:0] toString] isEqualToString: @"D-1"],   @"Init from string test failed!");
    STAssertTrue([[[notes lastNote] toString] isEqualToString: @"F2"],   @"Init from string test failed!");    

}

/*********************************************************************/


/*********************************************************************/
/*********************************************************************/
/*********************************************************************/
/*********************************************************************/
/*********************************************************************/
/*********************************************************************/
/*********************************************************************/


@end

