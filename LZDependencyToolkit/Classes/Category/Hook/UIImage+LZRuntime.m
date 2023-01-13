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
        SEL swizzleSelector = @selector(lz_imageNamed:);
        LZ_exchangeClassMethod(self, originSelector, swizzleSelector);
    });
}

// MARK: - Private
+ (UIImage *)lz_imageNamed:(NSString *)name {
    
    UIImage *image = nil;
    if (@available(iOS 13.0, *)) {
        image = [UIImage imageNamed:name inBundle:[NSBundle mainBundle] withConfiguration:nil];
    } else if (@available(iOS 8.0, *)) {
        image = [UIImage imageNamed:name inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    }
    if (nil == image) {
        image = [self lz_imageNamed:name];
    }
    if (nil == image) {
        image = [self imageNamed:name allowNull:YES];
    }
    return image;
}

@end
