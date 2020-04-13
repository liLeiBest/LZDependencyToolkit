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

@end
