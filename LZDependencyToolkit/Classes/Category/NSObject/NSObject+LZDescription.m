//
//  NSObject+LZDescription.m
//  Pods
//
//  Created by Dear.Q on 16/8/9.
//
//

#import "NSObject+LZDescription.h"
#import <objc/runtime.h>

@implementation NSDictionary (LZDescription)

// MARK: - Public
- (NSString *)lz_parameterString {
    
    if (0 == self.count) {
        return @"";
    }
    
    NSMutableString *str = [NSMutableString string];
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"%@=%@&", key, obj];
    }];
    // 查出最后一个 & 的范围，并删掉
    NSRange range = [str rangeOfString:@"&" options:NSBackwardsSearch];
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }
    return [str copy];
}

// MARK: - Over
- (NSString *)description {
    
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"<%@: %p> {\n", NSStringFromClass([self class]), self];
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    // 查出最后一个 , 的范围，并删掉
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }
    [str appendString:@"}"];
    return [str copy];
}

@end

@implementation NSArray (LZDescription)

// MARK: - Public
- (NSString *)lz_parameterString {
    return [self componentsJoinedByString:@","];
}

// MARK: - Over
- (NSString *)description {
    
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"<%@: %p> [\n", NSStringFromClass([self class]), self];
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"\t%@,\n", obj];
    }];
    // 查出最后一个,的范围，并删掉
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }
    [str appendString:@"]"];
    return [str copy];
}

@end

@implementation NSObject (LZDescription)

// MARK: - Over
- (NSString *)lz_customDescription {
    
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"<%@: %p> {\n", NSStringFromClass([self class]), self];
    
    Class destClass = [self class];
    do {
        
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(destClass, &outCount);
        for (int i = 0; i < outCount; i ++) {
            
            objc_property_t objc_property = properties[i];
            const char *propertyChar = property_getName(objc_property);
            if (propertyChar) {
                
                NSString *property =
                [NSString stringWithCString:propertyChar encoding:[NSString defaultCStringEncoding]];
                id value = [self valueForKey:property];
                [str appendFormat:@"\t%@: %@ = %@,\n",
                 property,
                 NSStringFromClass([value class]),
                 value];
            }
        }
        free(properties);
        destClass = destClass.superclass;
    } while (![NSStringFromClass(destClass) isEqualToString:NSStringFromClass([NSObject class])]);
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }
    [str appendString:@"}"];
    return [str copy];
}
@end
