//
//  UIView+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LZExtension)

/**
 @author Lilei
 
 @brief 获取当前视图所在的控制器
 
 @return UIViewController
 */
- (nullable UIViewController *)viewController;

/**
 视图截图
 
 @return UIImage
 */
- (nullable UIImage *)onScreenShort;

@end

NS_ASSUME_NONNULL_END
