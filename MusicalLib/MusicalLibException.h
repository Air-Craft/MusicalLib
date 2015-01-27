//
//  MusicalLibExceptions.h
//  MusicalLib
//
//  Created by Hari Karam Singh on 26/01/2015.
//
//

#import <Foundation/Foundation.h>

/** Non-fatal exception class. Only one for now */
@interface MusicalLibException : NSException

+ (instancetype)exceptionWithReason:(NSString *)reason underlyingError:(NSError *)underlyingError;

@property (nonatomic, readonly) NSError *underlyingError;

@end
