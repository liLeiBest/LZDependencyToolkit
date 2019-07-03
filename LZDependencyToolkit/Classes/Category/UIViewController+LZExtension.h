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
- (nullable UIViewController *)currentActivityViewController;

/**
 @author Lilei
 
 @brief 关闭当前控制器
 */
- (void)dismiss;

@end

@interface UIViewController (LZBundle)

/**
 @author Lilei
 
 @brief UIViewController 的资源目录
 
 @param resource 资源名称
 @return NSBundle
 */
- (nonnull NSBundle *)bundleForResource:(nullable NSString *)resource;

/**
 @author Lilei
 
 @brief 加载资源目录下的图片
 
 @param imageName 图片名称
 @param bundleName 资源名称
 @return UIImage
 */
- (nullable UIImage *)image:(nonnull NSString *)imageName
				   inBundle:(nullable NSString *)bundleName;

/**
 @author Lilei
 
 @brief 加载资源目录下的 ViewController XIB
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @return 实例
 */
+ (nonnull instancetype)viewControllerFromXib:(nonnull NSString *)xibName
									 inBundle:(nullable NSString *)bundleName;

/**
 @author Lilei
 
 @brief 加载资源目录下的 Storyboard
 
 @param storyboardName Storyboard 名称
 @param bundleName 资源名称
 @return UIStoryboard
 */
+ (nonnull instancetype)viewControllerFromstoryboard:(nonnull NSString *)storyboardName
											inBundle:(nullable NSString *)bundleName;

@end
