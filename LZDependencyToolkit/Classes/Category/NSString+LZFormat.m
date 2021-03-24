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
    NSString *string = self;
    NSUInteger len = 0, loc = 0;
    NSUInteger length = string.length;
    if (length == 11) {
        
        len = 4;
        loc = 3;
    } else if (length > 11) {
        
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

@end
