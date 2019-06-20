//
//  NSObject+LZDescription.m
//  Pods
//
//  Created by Dear.Q on 16/8/9.
//
//

#import "NSObject+LZDescription.h"

@implementation NSDictionary (LZDescription)

- (NSString *)description {
    
    NSMutableString *str = [NSMutableString string];
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"%@=%@&", key, obj];
    }];
	
    // 删掉最后一个 &
    NSRange range = [str rangeOfString:@"&" options:NSBackwardsSearch];
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

@end

@implementation NSArray (LZDescription)

- (NSString *)description {
    
    NSMutableString *str = [NSMutableString string];
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,", obj];
    }];
	
    // 删掉最后一个 ,
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

@end

@implementation NSObject (LZDescription)

@end
