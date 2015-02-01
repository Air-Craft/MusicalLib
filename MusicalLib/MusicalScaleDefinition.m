//
//  MusicalScaleDefinition.m
//  MusicalLib
//
//  Created by Hari Karam Singh on 26/01/2015.
//
//

#import "MusicalScaleDefinition.h"

@implementation MusicalScaleDefinition

+ (instancetype)scaleDefinitionWithID:(NSString *)ID name:(NSString *)name categories:(NSArray *)categories isUser:(BOOL)isUser halfstepsArray:(NSArray *)halfstepsArr
{
    return [[self alloc] initWithID:ID name:name categories:categories isUser:isUser halfstepsArray:halfstepsArr];
}

//---------------------------------------------------------------------

- (instancetype)initWithID:(NSString *)ID name:(NSString *)name categories:(NSArray *)categories isUser:(BOOL)isUser halfstepsArray:(NSArray *)halfstepsArr
{
    self = [super init];
    if (self) {
        _ID = ID;
        _name = name;
        _categories = categories;
        _isUser = isUser;
        _halfstepsArr = halfstepsArr;
    }
    return self;
}

//---------------------------------------------------------------------

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@ (%p): ID=%@, name=%@, categs=%@, halfsteps=[%@]", NSStringFromClass(self.class), self, _ID, _name, [_categories componentsJoinedByString:@", "], [_halfstepsArr componentsJoinedByString:@", "]];
}

//---------------------------------------------------------------------

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _name];
}

//---------------------------------------------------------------------

/**  */
- (BOOL)isEqual:(id)object
{
    return [[object ID] isEqualToString:self.ID] && [[object name] isEqualToString:self.name];
}


@end
