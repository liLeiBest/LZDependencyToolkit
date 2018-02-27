//
//  NSBundle+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 2017/5/4.
//
//

#import "NSBundle+LZExtension.h"

@implementation NSBundle (LZExtension)

/** 资源目录 */
+ (NSBundle *)bundleForResource:(NSString *)resource
                 referenceClass:(NSString *)className
{
    NSBundle *resourceBundle = nil;
    if (nil == className || 0 == className.length)
    {
        resourceBundle = [NSBundle mainBundle];
    }
    else
    {
        resourceBundle = [NSBundle bundleForClass:NSClassFromString(className)];
    }
    
    if (nil != resource && 0 < resource.length)
    {
        NSString *resoucePath = [resourceBundle pathForResource:resource
                                                         ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:resoucePath];
    }
    
    if (nil == resourceBundle) resourceBundle = [NSBundle mainBundle];
    
    return resourceBundle;
}

/** 加载资源目录下的图片 */
+ (UIImage *)image:(NSString *)imageName
            bundle:(NSString *)bundleName
    referenceClass:(NSString *)className
{
    NSBundle *resourceBundle = [self bundleForResource:bundleName referenceClass:className];
    NSString *name = [NSString stringWithFormat:@"%@.png", imageName];
    NSString *path =[resourceBundle pathForResource:name ofType:nil];
    
    UIDevice *device = [UIDevice currentDevice];
    if (device.systemVersion.integerValue >= 8.0)
    {
        UIImage *img = [UIImage imageNamed:name
                                  inBundle:resourceBundle
             compatibleWithTraitCollection:nil];
        
        return img;
    }
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    if (img) return img;
    
    name = [NSString stringWithFormat:@"%@@%.0fx.png", imageName, [[UIScreen mainScreen] scale]];
    path = [resourceBundle pathForResource:name ofType:nil];
    if (device.systemVersion.integerValue >= 8.0)
    {
        UIImage *img = [UIImage imageNamed:name
                                  inBundle:resourceBundle
             compatibleWithTraitCollection:nil];
        
        return img;
    }
    
    return [UIImage imageWithContentsOfFile:path];
}

/** 加载资源目录下的 View XIB */
+ (UIView *)viewFromXib:(NSString *)xibName
                 bundle:(NSString *)bundleName
         referenceClass:(NSString *)className
{
    NSBundle *resourceBundle = [self bundleForResource:bundleName referenceClass:className];
    NSArray *nibs = [resourceBundle loadNibNamed:xibName owner:nil options:nil];
    UIView *xibView = nil;
    if (nibs.count > 1) {
        xibView = [nibs firstObject];
    } else {
        xibView = [nibs lastObject];
    }
    
    return xibView;
}

/** 加载资源目录下的 ViewController XIB */
+ (UIViewController *)viewControllerFromXib:(NSString *)xibName
                                     bundle:(NSString *)bundleName
                             referenceClass:(NSString *)className
{
    NSBundle *resourceBundle = [self bundleForResource:bundleName referenceClass:className];
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:xibName bundle:resourceBundle];
    
    return viewController;
}

/** 加载资源目录下的 Storyboard */
+ (UIStoryboard *)storyboard:(NSString *)storyboardName
                      bundle:(NSString *)bundleName
              referenceClass:(NSString *)className
{
    NSBundle *resourceBundle = [self bundleForResource:bundleName referenceClass:className];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName
                                                         bundle:resourceBundle];
    
    return storyboard;
}

@end
