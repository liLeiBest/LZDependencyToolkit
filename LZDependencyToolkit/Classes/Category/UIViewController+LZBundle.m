//
//  UIViewController+LZBundle.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import "UIViewController+LZBundle.h"
#import "NSBundle+LZExtension.h"

@implementation UIViewController (LZBundle)

- (NSBundle *)bundleForResource:(NSString *)resource {
    return [NSBundle bundleForResource:resource
                        referenceClass:NSStringFromClass([self class])];
}

- (UIImage *)image:(NSString *)imageName
          inBundle:(NSString *)bundleName {
    return [NSBundle image:imageName
                  inBundle:bundleName
            referenceClass:NSStringFromClass([self class])];
}

+ (instancetype)viewControllerFromXib:(NSString *)xibName
                             inBundle:(NSString *)bundleName {
    return [NSBundle viewControllerFromXib:xibName
                                  inBundle:bundleName
                            referenceClass:NSStringFromClass(self)];
}

+ (instancetype)viewControllerFromstoryboard:(NSString *)storyboardName
                                    inBundle:(NSString *)bundleName {
    
    UIStoryboard *storyboard = [NSBundle storyboard:storyboardName
                                           inBundle:bundleName
                                     referenceClass:NSStringFromClass(self)];
    return storyboard.instantiateInitialViewController;
}

@end
