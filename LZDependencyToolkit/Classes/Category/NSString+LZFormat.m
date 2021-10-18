//
//  NSString+LZFormat.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2021/3/24.
//

#import "NSString+LZFormat.h"

@implementation NSString (LZFormat)

// MARK: - Public
- (NSString *)ciphertextPhone {
    // 13521452101--->135****2101
    NSUInteger minLength = 11;
    NSString *string = self;
    if (minLength > string.length) {
        return string;
    }
    NSUInteger len = 0, loc = 0;
    NSUInteger length = string.length;
    if (length == minLength) {
        
        len = 4;
        loc = 3;
    } else if (length > minLength) {
        
        len = 4;
        loc = length - 2 * len;
    }
    NSMutableString *stars = [NSMutableString stringWithString:@""];
    for (NSUInteger i = 0; i < len; i++) {
        [stars appendString:@"*"];
    }
    NSRange range = NSMakeRange(loc, len);
    string = [string stringByReplacingCharactersInRange:range withString:stars];
    return string;
}

- (NSString *)ciphertextFullName {
    // 李蕾--->李*；李明天--->李*天
    NSUInteger minLength = 2;
    NSString *string = self;
    if (minLength > string.length) {
        return string;
    }
    NSUInteger len = 0, loc = 0;
    NSUInteger length = string.length;
    if (length == minLength) {
        
        loc = 1;
        len = 1;
    } else if (length > minLength) {
        
        loc = 1;
        len = length - 2;
    }
    NSMutableString *stars = [NSMutableString stringWithString:@""];
    for (NSUInteger i = 0; i < len; i++) {
        [stars appendString:@"*"];
    }
    NSRange range = NSMakeRange(loc, len);
    string = [string stringByReplacingCharactersInRange:range withString:stars];
    return string;
}

@end
