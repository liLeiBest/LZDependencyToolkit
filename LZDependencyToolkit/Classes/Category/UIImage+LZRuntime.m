//
//  UIImage+LZRuntime.m
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import "UIImage+LZRuntime.h"
#import "UIImage+LZInstance.h"
#import <objc/runtime.h>

@implementation UIImage (LZRuntime)

+ (void)load
{
    Method exchangeMethod = class_getClassMethod(self, @selector(imageWithName:));
    Method originMethod = class_getClassMethod(self, @selector(imageNamed:));
    method_exchangeImplementations(exchangeMethod, originMethod);
}

+ (UIImage *)imageWithName:(NSString *)name
{
    if (![name isKindOfClass:[NSString class]]) name = @"";
    UIImage *img = [UIImage imageWithName:name];
    if (nil == img) return [UIImage imageWithString:name size:CGSizeMake(100.0, 100.0)];
    
    return img;
}

@end
