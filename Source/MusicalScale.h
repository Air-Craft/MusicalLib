//
//  MusicalScaleAbstract.h
//  AirPluckHarp
//
//  Created by Hari Karam Singh on 07/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicalNote.h"
#import "MusicalScaleDefintionProtocol.h"
#import "MusicalScaleDefinitions.h"  // for default init

@interface MusicalScale : NSObject {
}

@property (nonatomic, strong) Class<MusicalScaleDefinitionProtocol>scaleDefClass;
@property (nonatomic) MusicalNoteName key;
@property (nonatomic, strong) MusicalNote *startNote;
@property (nonatomic, strong) MusicalNote *endNote;

/**
 Create a scale object which can be used to get notes and intervals for a given scale definition

 \param theScaleDefClass    The scale definition to use.  Defines the notes in the scale 
 \param theKey              The musical key, eg MUSICAL_NOTE_Cs for C#
 \param theStartNote        Defines the boundaries for the scale.  If not in the actual scale then it will store be
                            stored internally as-is but will not be included in any returned notes
 \param theEndNote
 */
- (id)initWithScaleDefinition:(Class<MusicalScaleDefinitionProtocol>)theScaleDefClass  inKey:(MusicalNoteName)theKey startNote:(MusicalNote *)theStartNote endNote:(MusicalNote *)theEndNote;

/**
 Safety to default to CMajor C0-C1
 */
- (id)init;

/**
 Return an array of MusicalNotes for the scale def, key and bounds
 
 \return NSArray of MusicalNote objects
 */
- (NSArray *)getNotesArray;

//- (MusicalNote *)getNoteForInterval:(id)theInterval aboveStartNote:(MusicalNote *)theStartNote;
//- (MusicalNote *)getNoteForInterval:(id)theInterval belowStartNote:(MusicalNote *)theStartNote;


@end
