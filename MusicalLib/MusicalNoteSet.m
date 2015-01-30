//
//  MusicalNoteSet.m
//  MusicalLib
//
//  Created by Hari Karam Singh on 20/11/2011.
//  Copyright (c) 2011-2015 Air Craft Media Ltd.  MIT License.
//

#import "MusicalNoteSet.h"

@implementation MusicalNoteSet
{
    NSArray *_notesCache;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

+ (instancetype)noteSetWithScale:(MusicalScale *)scale insideRangeFromNote:(MusicalNote *)fromNote toNote:(MusicalNote *)toNote
{
    return [[self alloc] initWithScale:scale insideRangeFromNote:fromNote toNote:toNote];
}

//---------------------------------------------------------------------

- (MusicalNoteSet *)initWithScale:(MusicalScale *)aScale
              insideRangeFromNote:(MusicalNote *)fromNote 
                           toNote:(MusicalNote *)toNote
{
    if (!(self = [super init])) return nil;
    
    _scale = aScale;
    _rangeMinNote = fromNote;
    _rangeMaxNote = toNote;
    _notesCache = nil;   // Nil until first call
    
    return self;
}


//---------------------------------------------------------------------

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, _scale=%@, %i notes in range %@..%@ => %@..%@ (%@)>", NSStringFromClass([self class]), &self, self.scale.name, (int)[self noteCount], self.rangeMinNote, self.rangeMaxNote, self.firstNote, self.lastNote, [self.notesArray componentsJoinedByString:@" "]];
}

//---------------------------------------------------------------------

- (MusicalNoteSet *)noteSetShiftedByHalfsteps:(NSInteger)halfsteps
{
    // Create a new noteset with the notes augmented shifted by the specified amount
    // Scale stays the same but the start/end and key change
    MusicalNote *newRangeMin = [MusicalNote noteFromAddingHalfsteps:halfsteps toNote:self.rangeMinNote];
    MusicalNote *newRangeMax = [MusicalNote noteFromAddingHalfsteps:halfsteps toNote:self.rangeMaxNote];
    
    // The key is just the
    MusicalKey newKey = MusicalKeyShiftedByHalfsteps(self.scale.key, halfsteps);
    MusicalScale *newScale = [self.scale scaleWithNewKey:newKey];
    
    
    // Now build the new set
    return [[MusicalNoteSet alloc] initWithScale:newScale insideRangeFromNote:newRangeMin toNote:newRangeMax];
}

//---------------------------------------------------------------------

- (MusicalNoteSet *)noteSetShiftedByNoteOffsetInScale:(NSInteger)noteOffset
{
    // Get our new min/max by shifting those...
    MusicalNote *newRangeMin = [self.scale noteWithScalePosition:noteOffset relativeToNote:self.actualStartNote];
    MusicalNote *newRangeMax = [self.scale noteWithScalePosition:noteOffset relativeToNote:self.actualEndNote];
    
    // The key and scale stay the same
    return [[MusicalNoteSet alloc] initWithScale:self.scale insideRangeFromNote:newRangeMin toNote:newRangeMax];
}



/////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
/////////////////////////////////////////////////////////////////////////


/** Clear notesArray when properties change */
- (void)setValue:(id)value forKey:(NSString *)key
{
    _notesCache = nil;
    [super setValue:value forKey:key];
}

/**
 Ensure that start/end notes snap to the _scale
 */
- (MusicalNote *)actualStartNote
{
    return [_scale nearestInKeyNoteGreaterThanOrEqualTo:_rangeMinNote];
}
- (MusicalNote *)actualEndNote
{
    return [_scale nearestInKeyNoteLessThanOrEqualTo:_rangeMaxNote];
}


- (NSArray *)notesArray
{
    if (!_notesCache) {
        _notesCache = [_scale arrayOfNotesInRangeFrom:_rangeMinNote
                                                      to:_rangeMaxNote];
    }
    return _notesCache;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Public API
/////////////////////////////////////////////////////////////////////////

/** Informal protocol to allow indexed subscript access [] */
- (MusicalNote *)objectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx >= [self.notesArray count]) {
        [NSException raise:NSRangeException format:@"Note idx %i out of range (max: %i)", (int)idx, (int)([self.notesArray count] - 1)];
    }
    
    return [self.notesArray objectAtIndex:idx];
}

//---------------------------------------------------------------------

- (MusicalNote *)noteAtIndex:(NSUInteger)idx
{
    return self[idx];
}


//---------------------------------------------------------------------

- (NSUInteger)indexOfNoteInSet:(MusicalNote *)aNote
{
    for (int i=0; i<self.noteCount; i++) {
        if ([(MusicalNote *)[self.notesArray objectAtIndex:i] isSameNoteMusically:aNote]) {
            return i;
        }
    }
    // Not found?
    return NSNotFound;
}

//---------------------------------------------------------------------

- (MusicalNote *)firstNote
{
    return [self.notesArray objectAtIndex:0u];
}

//---------------------------------------------------------------------

- (MusicalNote *)lastNote
{
    return [self.notesArray lastObject];
}

//---------------------------------------------------------------------

- (NSUInteger)noteCount
{
    return [self.notesArray count];
}

//---------------------------------------------------------------------

- (NSUInteger)firstNotesIndexInScale
{
    return [_scale indexOfKeyInScale:[self noteAtIndex:0].key];
}
@end
