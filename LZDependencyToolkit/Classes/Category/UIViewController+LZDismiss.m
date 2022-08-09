//
//  UIViewController+LZDismiss.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import "UIViewController+LZDismiss.h"

@implementation UIViewController (LZDismiss)

- (void)dismissAnimated:(BOOL)animated {
    if (self.navigationController) {
        if ([self.navigationController.topViewController isEqual:self]
            && 1 < self.navigationController.viewControllers.count) {
            [self.navigationController popViewControllerAnimated:animated];
        } else {
            [self dismissViewControllerAnimated:animated completion:nil];
        }
    } else {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

- (void)dismiss {
    [self dismissAnimated:YES];
}

@end
