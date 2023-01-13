//
//  UIView+LZBundle.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LZBunble)

/**
 @author Lilei
 
 @brief View 的资源目录
 
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
 
 @brief 加载资源目录下的 View XIB
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @return instancetype
 */
+ (nullable instancetype)viewFromXib:(nonnull NSString *)xibName
                            inBundle:(nullable NSString *)bundleName;

/**
 @author Lilei
 
 @brief 复用资源目录下的 View XIB
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @return instancetype
 */
- (nullable instancetype)reuseViewFromXib:(nonnull NSString *)xibName
                                 inBundle:(nullable NSString *)bundleName;

/**
 @author Lilei
 
 @brief 加载资源目录下的 View Nib
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @return instancetype
 */
- (nullable UINib *)nibFromXib:(nullable NSString *)xibName
                      inBundle:(nullable NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
