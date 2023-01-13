//
//  UIViewController+LZForceRotation.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LZForceRotation)

/// 判断是否是竖屏
- (BOOL)isPortraitOrientation;

/// 设置是否允许旋转
/// @param needRotation BOOL
- (void)setupNeedRotation:(BOOL)needRotation;

/// 强制改变旋转方向
/// @param orientation UIInterfaceOrientation
- (void)forceChangeOrientation:(UIInterfaceOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
