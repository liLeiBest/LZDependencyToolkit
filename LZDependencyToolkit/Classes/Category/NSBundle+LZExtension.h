//
//  NSBundle+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 2017/5/4.
//
//

#import <Foundation/Foundation.h>

@interface NSBundle (LZExtension)

/**
 @author Lilei
 
 @brief 参考类下的资源目录

 @param resource 资源名称
 @param className 参考类名
 @return NSBundle
 */
+ (NSBundle *)bundleForResource:(NSString *)resource
                 referenceClass:(NSString *)className;

/**
 @author Lilei
 
 @brief 加载资源目录下的图片
 
 @param imageName 图片名称
 @param bundleName 资源名称
 @param className 参考类名
 @return UIImage
 */
+ (UIImage *)image:(NSString *)imageName
            bundle:(NSString *)bundleName
    referenceClass:(NSString *)className;

/**
 @author Lilei
 
 @breif 加载资源目录下的 View XIB
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @param className 参考类名
 @return UIView
 */
+ (UIView *)viewFromXib:(NSString *)xibName
                 bundle:(NSString *)bundleName
         referenceClass:(NSString *)className;

/**
 @author Lilei
 
 @breif 加载资源目录下的 ViewController XIB
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @param className 参考类名
 @return UIViewController
 */
+ (UIViewController *)viewControllerFromXib:(NSString *)xibName
                                     bundle:(NSString *)bundleName
                             referenceClass:(NSString *)className;

/**
 @author Lilei
 
 @breif 加载资源目录下的 Storyboard
 
 @param storyboardName Storyboard 名称
 @param bundleName 资源名称
 @param className 参考类名
 @return UIStoryboard
 */
+ (UIStoryboard *)storyboard:(NSString *)storyboardName
                      bundle:(NSString *)bundleName
              referenceClass:(NSString *)className;

@end
