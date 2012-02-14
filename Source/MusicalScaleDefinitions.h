//
//  MusicalScaleMajor.h
//  SoundWand
//
//  Created by Hari Karam Singh on 07/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicalNote.h"
#import "MusicalScaleDefintionProtocol.h"

@interface MusicalScaleDefinitionMajor : NSObject <MusicalScaleDefinitionProtocol>
@end

@interface MusicalScaleDefinitionDorian: NSObject <MusicalScaleDefinitionProtocol>
@end


@interface MusicalScaleDefinitionPhyrgian: NSObject <MusicalScaleDefinitionProtocol>
@end


@interface MusicalScaleDefinitionRaag: NSObject <MusicalScaleDefinitionProtocol>
@end

@interface MusicalScaleDefinitionChinese: NSObject <MusicalScaleDefinitionProtocol>
@end