//
//  MusicalLibExceptions.m
//  MusicalLib
//
//  Created by Hari Karam Singh on 26/01/2015.
//
//

#import "MusicalLibException.h"


@implementation MusicalLibException

+ (NSException *)exceptionWithName:(NSString *)name reason:(NSString *)reason userInfo:(NSDictionary *)userInfo
{
    [NSException raise:NSGenericException format:@"Not allowed. Use designated init"];
    return nil;
}

//---------------------------------------------------------------------

+ (instancetype)exceptionWithReason:(NSString *)reason underlyingError:(NSError *)underlyingError
{
    // Create the userinfo from the error.  Nil for userinfo if no error.
    NSDictionary *userInfo;
    if (underlyingError) userInfo = @{ NSUnderlyingErrorKey: underlyingError };
    
    return [[self.class alloc] initWithName:NSStringFromClass(self.class) reason:reason userInfo:userInfo];
}

//---------------------------------------------------------------------

- (NSError *)underlyingError
{
    if (!self.userInfo) return nil;
    return self.userInfo[NSUnderlyingErrorKey];
}


@end