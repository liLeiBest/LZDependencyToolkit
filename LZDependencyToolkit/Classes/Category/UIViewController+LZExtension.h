//
//  UIViewController+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (LZExtension)<UINavigationControllerDelegate>

/**
 @author Lilei
 
 @brief 设置键盘的隐藏
 */
- (void)setupForDismissKeyboard;

/**
 @author Lilei
 
 @brief 获取当前活动的视图控制器
 
 @return 活动控制器
 */
- (UIViewController *)currentActivityViewController;

@end
