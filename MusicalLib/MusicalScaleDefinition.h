//
//  MusicalScaleDefinition.h
//  MusicalLib
//
//  Created by Hari Karam Singh on 26/01/2015.
//
//

#import <Foundation/Foundation.h>

/** Immutable definition of a scale. */
@interface MusicalScaleDefinition : NSObject

+ (instancetype)scaleDefinitionWithID:(NSString *)ID
                                 name:(NSString *)name
                             categories:(NSArray *)categories
                                 isUser:(BOOL)isUser
                         halfstepsArray:(NSArray *)halfstepsArr;

- (instancetype)initWithID:(NSString *)ID
                      name:(NSString *)name
                categories:(NSArray *)categories
                    isUser:(BOOL)isUser
            halfstepsArray:(NSArray *)halfstepsArr;

/** YES iff both the ID and the name match exactly. If we need to check whether they represent the same entry, then create a separatemethod checking IDs.  */
- (BOOL)isEqual:(id)object;


@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSArray *categories;

/** The array of integers which define the notes in the scale. 0 = root. 1 the first halfstep. 12 = the octave. It may cover more than one octave. */
@property (nonatomic, readonly) NSArray *halfstepsArr;

/** Placeholder for future user scales */
@property (nonatomic, readonly) BOOL isUser;


@end
