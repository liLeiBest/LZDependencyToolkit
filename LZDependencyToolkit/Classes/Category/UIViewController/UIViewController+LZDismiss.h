//
//  UIViewController+LZDismiss.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LZDismiss)

/**
 @author Lilei
 
 @brief 关闭当前控制器，指定是否动画
 
 @param animated 是否动画
 */
- (void)dismissAnimated:(BOOL)animated;

/**
 @author Lilei
 
 @brief 关闭当前控制器
 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
