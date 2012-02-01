//
//  CEObjectiveCRuntime.m
//  AirPluckHarp
//
//  Created by Hari Karam Singh on 16/12/2011.
//  Copyright (c) 2011 Amritvela / Club 15CC.  MIT License.
//

#import "MLObjC.h"
#include <string.h>

@implementation MLObjC

+ (NSArray *)arrayOfClassNamesFilteredByPredicate:(NSPredicate *)predicate
{
    int numClasses;
    Class *classes = NULL;
    
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses < 1 ) return nil;
    
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);

    // Convert to NSArray of NSStrings
    NSMutableArray *rtn = [[NSMutableArray alloc] init];
    const char *cname;
    for (int i=0; i<numClasses; i++) {
        cname = class_getName(classes[i]);
  //      if (NULL == strstr(cname, "MusicalScale"))
  //          continue;
        [rtn addObject:[NSString stringWithCString:cname
                                          encoding:NSStringEncodingConversionAllowLossy]];
    }
    free(classes);
    
//    return rtn;
    return [rtn filteredArrayUsingPredicate:predicate];
}

/**********************************************************************/

+ (NSArray *)arrayOfClassObjectsFilteredByPredicate:(NSPredicate *)predicate
{
    int numClasses;
    Class *classes = NULL;
    
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses < 1 ) return nil;
    
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    
    // Convert to NSArray of NSStrings
    NSMutableArray *rtn = [[NSMutableArray alloc] init];
    const char *cname;
    for (int i=0; i<numClasses; i++) {
        cname = class_getName(classes[i]);
        if ([predicate evaluateWithObject:[NSString stringWithCString:cname encoding:NSStringEncodingConversionAllowLossy]]) {
            [rtn addObject:classes[i]];            
        }
    }
    free(classes);
    
    return rtn;
}

/**********************************************************************/

+ (NSArray *)subclassesOfClass:(Class)parentClass
{
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++)
    {
        Class superClass = classes[i];
        do
        {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != parentClass);
        
        if (superClass == nil)
        {
            continue;
        }
        
        [result addObject:classes[i]];
    }
    
    free(classes);
    
    return [NSArray arrayWithArray:result];
}

@end
