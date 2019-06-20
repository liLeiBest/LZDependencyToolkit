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

+ (UIImage *)LZ_imageNamed:(id)name {
    
    if ([name isKindOfClass:[UIImage class]]) {
        return (UIImage *)name;
    }
    
    UIImage *image = nil;
    if ([name isKindOfClass:[NSURL class]]) {
        
        NSData *imgData = [NSData dataWithContentsOfURL:(NSURL *)name];
        image = [UIImage imageWithData:imgData];
        return image;
    } else if ([name isKindOfClass:[NSData class]]) {
        
        image = [UIImage imageWithData:(NSData *)name];
        return image;
    }
    
    if (![name isKindOfClass:[NSString class]]) {
        return image;
    }
    
    image = [UIImage LZ_imageNamed:name];
    if (nil == image) {
        
        image = [UIImage imageWithContentsOfFile:name];;
        if (nil == image) {
            
            NSURL *imgURL = [NSURL URLWithString:name];
            NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
            image = [UIImage imageWithData:imgData];
        }
    }
    return image;
}

@end
