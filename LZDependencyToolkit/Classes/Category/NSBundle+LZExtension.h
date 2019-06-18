//
//  NSBundle+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 2017/5/4.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSBundle (LZExtension)

/**
 @author Lilei
 
 @brief 参考类的资源目录
 
 @param resource 资源名称
 @param className 参考类名
 @return NSBundle
 */
+ (nullable NSBundle *)bundleForResource:(nullable NSString *)resource
						  referenceClass:(nullable NSString *)className;

/**
 @author Lilei
 
 @brief 加载资源目录下的图片
 
 @param imageName 图片名称
 @param bundleName 资源名称
 @param className 参考类名
 @return UIImage
 */
+ (nullable UIImage *)image:(nonnull NSString *)imageName
				   inBundle:(nullable NSString *)bundleName
			 referenceClass:(nullable NSString *)className;

/**
 @author Lilei
 
 @brief 加载资源目录下的 View XIB
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @param className 参考类名
 @return UIView
 */
+ (nullable UIView *)viewFromXib:(nonnull NSString *)xibName
						inBundle:(nullable NSString *)bundleName
				  referenceClass:(nullable NSString *)className;

/**
 @author Lilei
 
 @brief 复用资源目录下的 View XIB
 
 @param xibName xib 名称
 @param owner UIView
 @param bundleName 资源名称
 @param className 参考类名
 @return UIView
 */
+ (nullable UIView *)reuseViewFromXib:(nonnull NSString *)xibName
								owner:(nonnull UIView *)owner
							 inBundle:(nullable NSString *)bundleName
					   referenceClass:(nullable NSString *)className;

/**
 @author Lilei
 
 @brief 加载资源目录下的 ViewController XIB
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @param className 参考类名
 @return UIViewController
 */
+ (nonnull UIViewController *)viewControllerFromXib:(nonnull NSString *)xibName
										   inBundle:(nullable NSString *)bundleName
									 referenceClass:(nullable NSString *)className;

/**
 @author Lilei
 
 @brief 加载资源目录下的 Storyboard
 
 @param storyboardName Storyboard 名称
 @param bundleName 资源名称
 @param className 参考类名
 @return UIStoryboard
 */
+ (nonnull UIStoryboard *)storyboard:(nonnull NSString *)storyboardName
							inBundle:(nullable NSString *)bundleName
					  referenceClass:(nullable NSString *)className;

/**
 @author Lilei
 
 @brief 加载资源目录下的 ViewController Storyboard
 
 @param storyboardName Storyboard 名称
 @param bundleName 资源名称
 @param className 参考类名
 @return UIStoryboard
 */
+ (nonnull UIViewController *)viewControllerFromStoryboard:(nonnull NSString *)storyboardName
												  inBundle:(nullable NSString *)bundleName
											referenceClass:(nullable NSString *)className;

/**
 @author Lilei
 
 @brief 加载资源目录下的 Nib
 
 @param nibName Nib 名称
 @param bundleName 资源名称
 @param className 参数类名
 @return UINib
 */
+ (nullable UINib *)nib:(nonnull NSString *)nibName
			   inBundle:(nullable NSString *)bundleName
		 referenceClass:(nullable NSString *)className;

@end
