//
//  UIImage+LZRuntime.m
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import "UIImage+LZRuntime.h"
#import "UIImage+LZInstance.h"
#import "NSObject+LZRuntime.h"

@implementation UIImage (LZRuntime)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = @selector(imageNamed:);
        SEL swizzleSelector = @selector(LZ_imageNamed:);
        LZ_exchangeClassMethod(self, originSelector, swizzleSelector);
    });
}

+ (UIImage *)LZ_imageNamed:(NSString *)name {
    
    if (![name isKindOfClass:[NSString class]]) name = @"";
    UIImage *img = [UIImage LZ_imageNamed:name];
    if (nil == img) return [UIImage imageWithString:name size:CGSizeMake(100.0, 100.0)];
    
    return img;
}

@end
