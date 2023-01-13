//
//  UIView+LZRoundCorner.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LZRoundCorner)

/**
 圆角任意角

 @param corners UIRectCorner
 @param radius CGFloat
 */
- (void)roundingCorners:(UIRectCorner)corners
                 radius:(CGFloat)radius;

/**
 圆角任意角，带边框

 @param corners UIRectCorner
 @param radius CGFloat
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 */
- (void)roundingCorners:(UIRectCorner)corners
                 radius:(CGFloat)radius
            borderColor:(UIColor *)borderColor
            borderWidth:(CGFloat)borderWidth;

/**
 圆角任意角
 
 @param rect View 精确区域
 @param corners UIRectCorner
 @param radius CGFloat
 */
- (void)roundedRect:(CGRect)rect
    roundingCorners:(UIRectCorner)corners
             radius:(CGFloat)radius;

/**
 圆角任意角，带边框

 @param rect View 精确区域
 @param corners UIRectCorner
 @param radius CGFloat
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 */
- (void)roundedRect:(CGRect)rect
    roundingCorners:(UIRectCorner)corners
             radius:(CGFloat)radius
        borderColor:(UIColor *)borderColor
        borderWidth:(CGFloat)borderWidth;

@end

NS_ASSUME_NONNULL_END
