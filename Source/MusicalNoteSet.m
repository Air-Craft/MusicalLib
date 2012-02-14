//
//  MusicalNoteSet.m
//  SoundWand
//
//  Created by Hari Karam Singh on 20/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicalNoteSet.h"

@implementation MusicalNoteSet

@synthesize scale, rangeMinNote, rangeMaxNote, actualStartNote, actualEndNote, notesArray;

/**********************************************************************************************************************/
#pragma mark -
#pragma mark Init's

- (MusicalNoteSet *)initWithScale:(MusicalScaleAbstract *)aScale
              insideRangeFromNote:(MusicalNote *)fromNote 
                           toNote:(MusicalNote *)toNote
{
    if (!(self = [super init])) return nil;
    
    scale = aScale;
    rangeMinNote = fromNote;
    rangeMaxNote = toNote;
    notesArray = nil;   // Nil until first call
    
    return self;
}

/**********************************************************************/

- (MusicalNoteSet *)initWithScaleName:(NSString *)aScaleName 
                         scaleKeyString:(NSString *)aKeyName
                  insideRangeFromNoteString:(NSString *)fromNote 
                               toNoteString:(NSString *)toNote
{
    // Convert the key string to the reqd enum and init the class
    MusicalNoteName key = [MusicalNote noteNameFromString:aKeyName];
    MusicalScaleAbstract *aScale = [MusicalScaleAbstract musicalScaleFromScaleName:aScaleName andKey:key];
    
    if (!aScale) {
        [NSException raise:@"MusicalLibScaleNotFound" 
                    format:@"The scale %@ could not be found.", aScaleName];
    }

    // And init with our method
    return [self initWithScale:aScale 
           insideRangeFromNote:[[MusicalNote alloc] initFromNoteString:fromNote] 
                        toNote:[[MusicalNote alloc] initFromNoteString:toNote]];   
}


/** ********************************************************************************************************************/
#pragma mark -
#pragma mark Overrides

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, scale=%@, %i notes in range %@..%@ => %@..%@ (%@)>", NSStringFromClass([self class]), &self, [[self.scale class] name], [self noteCount], self.rangeMinNote, self.rangeMaxNote, self.firstNote, self.lastNote, [self.notesArray componentsJoinedByString:@" "]];
}



/** ********************************************************************************************************************/
#pragma mark -
#pragma mark Property overrides

/** Clear notesArray when properties change */
- (void)setValue:(id)value forKey:(NSString *)key
{
    notesArray = nil;
    [super setValue:value forKey:key];
}

/**
 Ensure that start/end notes snap to the scale
 */
- (MusicalNote *)actualStartNote
{
    return [scale getNearestInKeyNoteGreaterThanOrEqualTo:rangeMinNote];
}
- (MusicalNote *)actualEndNote
{
    return [scale getNearestInKeyNoteLessThanOrEqualTo:rangeMaxNote];
}


- (NSArray *)notesArray
{
    if (!notesArray) {
        notesArray = [self.scale getArrayOfNotesInRangeFrom:rangeMinNote 
                                                         to:rangeMaxNote];
    }
    return notesArray;
}

/**********************************************************************************************************************/
#pragma mark -
#pragma mark Publics

- (MusicalNote *)noteAtIndex:(NSUInteger)theIdx
{
    if (theIdx >= [self.notesArray count])
        return nil;
            
    return [self.notesArray objectAtIndex:theIdx];
}

/**********************************************************************/

- (MusicalNote *)firstNote
{
    return [self.notesArray objectAtIndex:0u];
}

/**********************************************************************/

- (MusicalNote *)lastNote
{
    return [self.notesArray lastObject];
}

/**********************************************************************/

- (NSUInteger)noteCount
{
    return [self.notesArray count];
}

/** ********************************************************************/

- (NSUInteger)firstNotesIndexInScale
{
    return [[self scale] indexOfNoteInScale:[self noteAtIndex:0].name];
}
@end
