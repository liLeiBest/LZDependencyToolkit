//
//  UIViewController+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import "UIViewController+LZExtension.h"

@implementation UIViewController (LZExtension)

/** 隐藏导航栏 */
- (void)hideNavigationBar {
    self.navigationController.delegate = self;
}

// MARK: - UINavigationController
// MAKR: <UINavigationControllerDelegate>
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果是当前控制器，则隐藏背景；如果不是当前控制器，则显示背景
    if (viewController == self) {
        for (UIView *view in [self.navigationController.navigationBar subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                // 最好使用隐藏，指不定什么时候你又想让他出现
                view.hidden = YES;
                // 如果不想让它一直出现，那么可以移除
                // [view removeFromSuperview];
            }
        }
    } else {
        for (UIView *view in [self.navigationController.navigationBar subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                view.hidden = NO;
            }
        }
    }
}

@end
