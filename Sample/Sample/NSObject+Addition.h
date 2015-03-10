//
//  NSObject+Addition.h
//  Sample
//
//  Created by Abhishek on 10/03/15.
//  Copyright (c) 2015 Abhishek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Addition)

+ (NSMutableDictionary *) propertiesForHierarchyOfClass:(Class)class onDictionary:(NSMutableDictionary *)properties;
+ (NSMutableDictionary *) propertiesForSubclass:(Class)class onDictionary:(NSMutableDictionary *)properties;

@end
