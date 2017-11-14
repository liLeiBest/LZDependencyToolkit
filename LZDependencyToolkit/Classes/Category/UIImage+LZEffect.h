//
//  UIImage+LZEffect.h
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UIImageGrayLevelTypeHalfGray    = 0,
    UIImageGrayLevelTypeGrayLevel   = 1,
    UIImageGrayLevelTypeDarkBrown   = 2,
    UIImageGrayLevelTypeInverse     = 3
} UIImageGrayLevelType;

@interface UIImage (LZEffect)

/**
@author Lilei

@brief 根据色值改变图片的暗度

@param darkValue 色值 变暗多少 0.0 - 1.0

@return UIImage
*/
- (UIImage *)darkToValue:(float)darkValue;

/**
 @author Lilei
 
 @brief 根据灰度级别改变图片的灰度
 
 @param type 图片处理 0 半灰色  1 灰度   2 深棕色    3 反色
 
 @return UIImage
 */
- (UIImage *)grayToLevelType:(UIImageGrayLevelType)type;

/**
 @author Lilei
 
 @brief 加模糊效果
 
 @param blur 模糊度
 
 @return UIImage
 */
- (UIImage *)blurToLevel:(CGFloat)blur;

/**
 @author Lilei
 
 @brief 加高斯模糊
 
 @param blurLevel 模糊度
 
 @return UIImage
 */
- (UIImage *)gaussBlur:(CGFloat)blurLevel;

/**
 @author Lilei
 
 @brief 添加水印
 
 @param content 内容
 
 @return UIImage
 */
- (UIImage *)watermark:(NSString *)content
            attributes:(NSDictionary *)attributes;

@end
