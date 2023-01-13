//
//  UIView+LZBundle.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import "UIView+LZBundle.h"
#import "NSBundle+LZExtension.h"

@implementation UIView (LZBunble)

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

+ (instancetype)viewFromXib:(NSString *)xibName
                   inBundle:(NSString *)bundleName {
    return [NSBundle viewFromXib:xibName
                        inBundle:bundleName
                  referenceClass:NSStringFromClass([self class])];
}

- (instancetype)reuseViewFromXib:(NSString *)xibName
                        inBundle:(NSString *)bundleName {
    return [NSBundle reuseViewFromXib:xibName
                                owner:self
                             inBundle:bundleName
                       referenceClass:NSStringFromClass([self class])];
}

- (UINib *)nibFromXib:(NSString *)xibName
             inBundle:(NSString *)bundleName {
    return [NSBundle nib:xibName
                inBundle:bundleName
          referenceClass:NSStringFromClass([self class])];
}

@end
