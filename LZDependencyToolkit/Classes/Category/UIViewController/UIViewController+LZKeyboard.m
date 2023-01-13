//
//  UIViewController+LZKeyboard.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import "UIViewController+LZKeyboard.h"

@implementation UIViewController (LZKeyboard)

// MARK: - Public
/** 设置键盘的隐藏 */
- (void)setupForDismissKeyboard {
    // 实例通知中心
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    // 实例手势
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnyWhereToDismissKeyboard:)];
    __weak __typeof(self)weakSelf = self;
    // 创建主队列
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    // 监听键盘的即将弹出和隐藏
    [notificationCenter addObserverForName:UIKeyboardWillShowNotification
                                    object:nil
                                     queue:mainQueue
                                usingBlock:^(NSNotification *note) {
                                    [weakSelf.view addGestureRecognizer:singleTapGR];
                                }];
    [notificationCenter addObserverForName:UIKeyboardWillHideNotification
                                    object:nil
                                     queue:mainQueue
                                usingBlock:^(NSNotification *note) {
                                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                                }];
}

// MARK: - Observer
- (void)tapAnyWhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    // 此方法会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

@end
