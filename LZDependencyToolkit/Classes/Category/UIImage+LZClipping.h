//
//  UIImage+LZClipping.h
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (LZClipping)

/**
@author Lilei

@brief 根据size缩放图片

@param newSize 缩放尺寸

@return UIImage
*/
- (instancetype)scaledToSize:(CGSize)newSize;

/**
 @author Lilei
 
 @brief 对UIImage进行指定倍数放大
 
 @param scale 放大倍数
 
 @return UIImage
 */
- (instancetype)scale:(CGFloat)scale;

/**
 @author Lilei
 
 @brief 根据rect剪切图片
 
 @param newRect rect
 
 @return UIImage
 */
- (instancetype)clipToRect:(CGRect)newRect;

/**
 @author Lilei
 
 @brief 等比例缩放图片
 
 @param newSize 缩放尺寸
 
 @return UIImage
 */
- (instancetype)ratioToSize:(CGSize)newSize;

/**
 @author Lilei
 
 @brief 按最短边 等比压缩
 
 @param newSize 缩放尺寸
 
 @return UIImage
 */
- (instancetype)ratioCompressToSize:(CGSize)newSize;

/**
 @author Lilei
 
 @brief 添加圆角
 
 @param size 圆角大小
 
 @return UIImage
 */
- (instancetype)roundToSize:(CGSize)size;

/**
 @author Lilei
 
 @brief 设置 Image 的尺寸
 
 @param size    CGSize
 @param quality CGInterpolationQuality
 
 @return UIImage
 */
- (UIImage *)resizeImageToSize:(CGSize)size
          interpolationQuality:(CGInterpolationQuality)quality;

/**
 @author Lilei
 
 @brief 设置图片的 UIViewContentMode、CGSize、CGInterpolationQuality
 
 @param contentMode UIViewContentMode
 @param bounds      CGSize
 @param quality     CGInterpolationQuality
 
 @return UIImage
 */
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

@end
