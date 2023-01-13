//
//  UIImage+LZEffect.h
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import <UIKit/UIKit.h>

// 图片灰色
typedef enum : NSUInteger {
    LZImageGrayLevelHalfGray    = 0,    // 半灰
    LZImageGrayLevelFullGray   = 1,     // 全灰
    LZImageGrayLevelDarkBrown   = 2,    // 深棕
    LZImageGrayLevelInverse     = 3,    // 反色
} LZImageGrayLevel;

// 水印位置
typedef NS_ENUM(NSUInteger, LZWatermarkPoint) {
	LZWatermarkPointCenter,     // 中心
	LZWatermarkPointLeftTop,    // 左上
	LZWatermarkPointLeftBottom, // 左下
	LZWatermarkPointRightTop,   // 右上
	LZWatermarkPointRightBottom,// 右下
};

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
- (UIImage *)grayToLevelType:(LZImageGrayLevel)type;

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
 
 @brief 中心位置添加文字水印
 
 @param content 文字
 
 @return UIImage
 */
- (UIImage *)watermark:(NSString *)content
			attributes:(NSDictionary *)attributes;

/**
 @author Lilei
 
 @brief 指定位置添加文字水印
 
 @param content 文字
 @param attributes 文字样式
 @param point LZWatermarkPoint
 
 @return UIImage
 */
- (UIImage *)watermark:(NSString *)content
			attributes:(NSDictionary *)attributes
				 point:(LZWatermarkPoint)point;

/**
 @author Lilei
 
 @brief 指定位置添加图片水印
 
 @param image 图片
 @param point LZWatermarkPoint
 
 @return UIImage
 */
- (UIImage *)watermark:(UIImage *)image
				 point:(LZWatermarkPoint)point;

/**
 @author Lilei
 
 @brief 指定位置添加文字和图片水印
 
 @param word 文字
 @param attributes 文字样式
 @param markImage 图片
 @param point LZWatermarkPoint
 
 @return UIImage
 */
- (UIImage *)watermarkWord:(NSString *)word
			wordAttributes:(NSDictionary *)attributes
				 markImage:(UIImage *)markImage
					 point:(LZWatermarkPoint)point;

@end
