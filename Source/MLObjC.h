//
//  CEObjectiveCRuntime.h
//  AirPluckHarp
//
//  Created by Hari Karam Singh on 16/12/2011.
//  Copyright (c) 2011 Amritvela / Club 15CC.  MIT License.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface MLObjC

/**
 Get a nice NSArray of NSStrings of class names filtered by predicate
 */
+ (NSArray *)arrayOfClassNamesFilteredByPredicate:(NSPredicate *)predicate;

/**
 Same as getArrayOfClassNamesFilteredByPredicate but returns NSArray of Class objects
 */
+ (NSArray *)arrayOfClassObjectsFilteredByPredicate:(NSPredicate *)predicate;

/**
 Thanks: http://cocoawithlove.com/2010/01/getting-subclasses-of-objective-c-class.html
 */
+ (NSArray *)subclassesOfClass:(Class)parentClass;

@end
