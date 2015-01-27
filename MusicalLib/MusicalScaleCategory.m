//
//  MusicalScaleCategory.m
//  MusicalLib
//
//  Created by Hari Karam Singh on 26/01/2015.
//
//

#import "MusicalScaleCategory.h"

@implementation MusicalScaleCategory

+ (instancetype)scaleCategoryWithWithID:(NSString *)ID name:(NSString *)name
{
    return [[self alloc] initWithID:ID name:name];
}

//---------------------------------------------------------------------

- (instancetype)initWithID:(NSString *)ID name:(NSString *)name
{
    self = [super init];
    if (self) {
        NSParameterAssert(ID);
        NSParameterAssert(name);
        _ID = ID;
        _name = name;
    }
    return self;
}

//---------------------------------------------------------------------

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ (%@)>", _name, _ID];
}


@end
