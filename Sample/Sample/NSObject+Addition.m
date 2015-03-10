//
//  NSObject+Addition.m
//  Sample
//
//  Created by Abhishek on 10/03/15.
//  Copyright (c) 2015 Abhishek. All rights reserved.
//

#import <objc/objc-runtime.h>

#import "NSObject+Addition.h"

@implementation NSObject (Addition)

static const char * getPropertyType(objc_property_t property)
{
    const char *attributes = property_getAttributes(property);
    printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}

+ (NSDictionary *) propertiesOfObject:(id)object
{
    Class class = [object class];
    return [self propertiesOfClass:class];
}

+ (NSDictionary *) propertiesOfClass:(Class)class
{
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    [self propertiesForHierarchyOfClass:class onDictionary:properties];
    return [NSDictionary dictionaryWithDictionary:properties];
}

+ (NSDictionary *) propertiesOfSubclass:(Class)class
{
    if (class == NULL)
    {
        return nil;
    }
    
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    return [self propertiesForSubclass:class onDictionary:properties];
}

+ (NSMutableDictionary *)propertiesForHierarchyOfClass:(Class)class onDictionary:(NSMutableDictionary *)properties
{
    if (class == NULL)
    {
        return nil;
    }
    
    if (class == [NSObject class])
    {
        // On reaching the NSObject base class, return all properties collected.
        return properties;
    }
    
    // Collect properties from the current class.
    [self propertiesForSubclass:class onDictionary:properties];
    
    // Collect properties from the superclass.
    return [self propertiesForHierarchyOfClass:[class superclass] onDictionary:properties];
}

+ (NSMutableDictionary *) propertiesForSubclass:(Class)class onDictionary:(NSMutableDictionary *)properties
{
    unsigned int outCount, i;
   
    objc_property_t *objcProperties = class_copyPropertyList(class, &outCount);
   
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = objcProperties[i];
        
        const char *propName = property_getName(property);
        if(propName)
        {
            const char *propType = getPropertyType(property);
            
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            
            [properties setObject:propertyType forKey:propertyName];
        }
    }
    free(objcProperties);
    
    return properties;
}

@end
