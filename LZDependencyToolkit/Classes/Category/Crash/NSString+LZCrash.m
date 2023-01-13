//
//  NSString+LZCrash.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2023/1/10.
//

#import "NSString+LZCrash.h"
#import "NSObject+LZRuntime.h"

@implementation NSString (LZCrash)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = @selector(rangeOfString:);
        SEL swizzleSelector = @selector(lz_rangeOfString:);
        LZ_exchangeInstanceMethod(self, originSelector, swizzleSelector);
    });
}

- (NSRange)lz_rangeOfString:(NSString *)searchString {
    if (nil == searchString) {
        searchString = @"";
    }
    return [self lz_rangeOfString:searchString];
}

@end
