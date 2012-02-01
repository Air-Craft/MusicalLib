//
//  MusicalNoteTests.m
//  AirPluckHarp
//
//  Created by Hari Karam Singh on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "TestsControl.h"
#if TEST_MUSICALNOTE == 1

#import "MusicalNoteTests.h"


@implementation MusicalNoteTests


- (void)testNoteToString 
{
    MusicalNote *note;
    
    note = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_G andOctave:0] autorelease];
    STAssertTrue([[note toString] isEqualToString:@"G0"], @"Incorrect note string: %@", note);
    
    note = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_Cs andOctave:-1] autorelease];
    STAssertTrue([[note toString] isEqualToString:@"C#-1"], @"Incorrect note string: %@", note);
    
    note = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_Eb andOctave:100] autorelease];
    STAssertTrue([[note toString] isEqualToString:@"Eb100"], @"Incorrect note string: %@", note);
}

/*********************************************************************/

- (void)testNoteAdd
{
    MusicalNote *noteA;
    MusicalNote *noteB;
    
    // c1 + 1 = c#1
    noteA = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:1] autorelease];
    noteB = [MusicalNote noteFromAddingHalfsteps:1 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"C#1"], @"Incorrect note: %@", noteB);

    // c0 - 1 = b-1
    noteA = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:0] autorelease];
    noteB = [MusicalNote noteFromAddingHalfsteps:-1 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"B-1"], @"Incorrect note: %@", noteB);

    // e-1 + 25 = f1
    noteA = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_E andOctave:-1] autorelease];
    noteB = [MusicalNote noteFromAddingHalfsteps:25 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"F1"], @"Incorrect note: %@", noteB);

    // f1 - 25 = e-1
    noteA = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_F andOctave:1] autorelease];
    noteB = [MusicalNote noteFromAddingHalfsteps:-25 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"E-1"], @"Incorrect note: %@", noteB);
    
    // c-1 - 13 = b-3
    noteA = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:-1] autorelease];
    noteB = [MusicalNote noteFromAddingHalfsteps:-13 toNote:noteA];
    STAssertTrue([[noteB toString] isEqualToString:@"B-3"], @"Incorrect note: %@", noteB);
    
    // A-1 + 2 - 2 = A-1
    noteA = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_A andOctave:-1] autorelease];
    noteB = [MusicalNote noteFromAddingHalfsteps:2 toNote:noteA];
    noteB = [MusicalNote noteFromAddingHalfsteps:-2 toNote:noteB];
    STAssertTrue([[noteB toString] isEqualToString:[noteA toString]], @"Incorrect note: %@", noteB);
    
}

/*********************************************************************/

- (void)testMusicalScaleMajor
{
    MusicalNote *startNote, *endNote;
    MusicalScale *scale;
    NSArray *notes;
    
    // C Major (C0 - C4)
    startNote   = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:0] autorelease];
    endNote     = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_C andOctave:4] autorelease];
    scale       = [[MusicalScale alloc] initWithScaleDefinition:[MusicalScaleDefinitionMajor class] 
                                                          inKey:MUSICAL_NOTE_C 
                                                      startNote:startNote 
                                                        endNote:endNote]; 
    notes = [scale getNotesArray];
    STAssertTrue([[[notes objectAtIndex:0] toString] isEqualToString: @"C0"], @"C Major: Incorrect note at index 0: %@", [notes objectAtIndex:0]);
    STAssertTrue([[[notes objectAtIndex:1] toString] isEqualToString: @"D0"], @"C Major: Incorrect note at index 1: %@", [notes objectAtIndex:1]);
    STAssertTrue([[[notes objectAtIndex:6] toString] isEqualToString: @"B0"], @"C Major: Incorrect note at index 6: %@", [notes objectAtIndex:6]);
    STAssertTrue([[[notes objectAtIndex:7] toString] isEqualToString: @"C1"], @"C Major: Incorrect note at index 7: %@", [notes objectAtIndex:7]);
    STAssertTrue([[[notes objectAtIndex:28] toString] isEqualToString: @"C4"], @"C Major: Incorrect note at index 28: %@", [notes objectAtIndex:28]);
    
    // C# Major (B-1 - B2, should snap nearest note in key)
    startNote   = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_B andOctave:-1] autorelease];
    endNote     = [[[MusicalNote alloc] initWithNoteName:MUSICAL_NOTE_B andOctave:2] autorelease];
    scale       = [[MusicalScale alloc] initWithScaleDefinition:[MusicalScaleDefinitionMajor class] 
                                                          inKey:MUSICAL_NOTE_Cs 
                                                      startNote:startNote 
                                                        endNote:endNote]; 
    notes = [scale getNotesArray];
    STAssertTrue([[[notes objectAtIndex:0] toString] isEqualToString: @"C0"],   @"C# Major: Incorrect note at index 0: %@", [notes objectAtIndex:0]);
    STAssertTrue([[[notes lastObject] toString] isEqualToString: @"A#2"],        @"C# Major: Incorrect note at last index: %@", [notes lastObject]);
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

#endif
