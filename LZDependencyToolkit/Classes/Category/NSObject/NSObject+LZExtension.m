//
//  NSObject+LZExtension.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2020/4/13.
//

#import "NSObject+LZExtension.h"

@implementation NSObject (LZExtension)

// MARK: - Public
- (BOOL)isNullObj {
    return nil == self || [self isKindOfClass:[NSNull class]];
}

- (BOOL)isEmpty {
    if ([self isNullObj]) {
        return YES;
    } else if ([self isKindOfClass:[NSString class]]) {
        return 0 == [(NSString *)self length];
    } else if ([self isKindOfClass:[NSArray class]]) {
        return 0 == [(NSArray *)self count];
    } else if ([self isKindOfClass:[NSDictionary class]]) {
        return 0 == [(NSDictionary *)self count];
    } else if ([self isKindOfClass:[NSSet class]]) {
        return 0 == [(NSSet *)self count];
    }
    return NO;
}

@end
