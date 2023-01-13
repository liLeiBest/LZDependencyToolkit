//
//  UINavigationBar+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 16/9/8.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LZExtension)

/**
 @author Lilei
 
 @brief 设置 NavigationBar 背景色
 
 @param color UIColor
 */
- (void)setNavBarBackgroundColor:(UIColor *)color;

/**
 @author Lilei
 
 @brief 设置导航栏左右按钮及标题的透明度

 @param alpha CGFloat
 */
- (void)setNavBarElementsAlpha:(CGFloat)alpha;

/**
 @author Lilei
 
 @brief 设置导航栏 Y 轴偏移量

 @param translationY CGFloat
 */
- (void)setNavBarTranslationY:(CGFloat)translationY;

/**
 @author Lilei
 
 @brief 重置 NavigationBar
 */
- (void)resetNavBar;

@end
