//
//  MusicalScaleCategory.h
//  MusicalLib
//
//  Created by Hari Karam Singh on 26/01/2015.
//
//

#import <Foundation/Foundation.h>

/** Associated with ScaleDefinition */
@interface MusicalScaleCategory : NSObject

/** Assertion exception if either param is nil @{ */
+ (instancetype)scaleCategoryWithWithID:(NSString *)ID name:(NSString *)name;
- (instancetype)initWithID:(NSString *)ID name:(NSString *)name;
/** @} */

@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) NSString *name;

@end
