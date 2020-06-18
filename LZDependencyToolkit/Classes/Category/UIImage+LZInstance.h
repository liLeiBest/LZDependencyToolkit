//
//  UIImage+LZInstance.h
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (LZInstance)

/**
 @author Lilei
 
 @brief 创建指定大小、指定颜色的纯色图片、是否为圆角
 
 @param color UIColor
 @param size  CGSize
 @param isRound BOOL
 @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color
					   size:(CGSize)size
					isRound:(BOOL)isRound;

/**
@author Lilei

@brief 创建指定大小、指定颜色的纯色图片

@param color UIColor
@param size  CGSize
@return UIImage
*/
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;

/**
 @author Lilei
 
 @brief 根据字符串内容、字体颜色、背景颜色及尺寸，创建图片
 
 @param string 字符串
 @param fgColor 字符颜色
 @param bgColor 背景颜色
 @param size   CGSize
 @return UIImage
 */
+ (UIImage *)imageWithString:(NSString *)string
             foregroundColor:(UIColor *)fgColor
             backgroundColor:(UIColor *)bgColor
                        size:(CGSize)size;

/**
 @author Lilei
 
 @brief 根据字符串内容、前背颜色及尺寸，创建图片
 
 @param string 字符串
 @param size   CGSize
 @return UIImage
 @discussion 字符颜色为 白色
 */
+ (UIImage *)imageWithString:(NSString *)string
             backgroundColor:(UIColor *)bgColor
                        size:(CGSize)size;

/**
 @author Lilei
 
 @brief 根据字符串内容，创建指定大小的图片
 
 @param string 字符串
 @param size   CGSize
 @return UIImage
 @discussion 可通过 LZImageRandomColorConfig.plist 文件，指定生成图片的颜色范围
 */
+ (UIImage *)imageWithString:(NSString *)string
                        size:(CGSize)size;

/**
@author Lilei

@brief 实例图片，类方法

@param name 图片名称/路径/NSData
@param allowNull 是否允许为空
@return UIImage
@attention 图片不存在，则返回随机背景的图片
*/
+ (UIImage *)imageNamed:(id)name
              allowNull:(BOOL)allowNull;

/**
 @author Lilei
 
 @brief 从图片中心拉伸图片，类方法
 
 @param imageName 图片名称
 @return UIImage
 @attention 从图片中心拉伸
 */
+ (UIImage *)middleStretchImage:(NSString *)imageName;

/**
 @author Lilei
 
 @brief 从图片中心拉伸图片，对象方法
 
 @return UIImage
 @attention 从图片中心拉伸
 */
- (UIImage *)middleStretch;

/**
 @author Lilei
 
 @brief 指定位置拉伸图片，类方法
 
 @param imageNmae 图片名称
 @param leftRatio 左边比率
 @param topRatio  上边比率
 @return UIImage
 */
+ (UIImage *)stretchImage:(NSString *)imageNmae
                leftRatio:(CGFloat)leftRatio
                 topRatio:(CGFloat)topRatio;

/**
 @author Lilei
 
 @brief 指定位置拉伸图片，对象方法
 
 @param leftRatio 左边比率
 @param topRatio  上边比率
 @return UIImage
 */
- (UIImage *)stretchLeftRatio:(CGFloat)leftRatio
                     topRatio:(CGFloat)topRatio;

/**
 @author Lilei
 
 @brief 获取当前视图截图
 
 @param theView 当前视图
 @return UIImage
 */
+ (UIImage *)imageFromView:(UIView *)theView;

/**
 @author Lilei
 
 @brief 获取启动图片
 
 @return UIImage
 */
+ (UIImage *)launchImage;

/**
 @author Lilei
 
 @brief 获取应用图标
 
 @return UIImage
 */
+ (UIImage *)iconImage;

/**
 @author Lilei
 
 @brief 获取视频预览图

 @param videoURL 视频 URL
 @return UIImage
 */
+ (UIImage *)previewImageWithVideoURL:(NSURL *)videoURL;

// MARK: - Deprecated
+ (UIImage *)imageWithColor:(UIColor *)color
                    andSize:(CGSize)size __deprecated_msg("请使用 [imageWithColor:size:]");
+ (UIImage *)imageWithString:(NSString *)string
                     andSize:(CGSize)size __deprecated_msg("请使用 [imageWithString:size:]");
+ (UIImage *)imageNameToMiddleStretch:(NSString *)imageName __deprecated_msg("请使用 [middleStretchImage:]");
+ (UIImage *)imageNameToStretch:(NSString *)imageNmae
                      leftRatio:(CGFloat)leftRatio
                       topRatio:(CGFloat)topRatio __deprecated_msg("请使用 [stretchImage:leftRatio:topRatio:]");

@end
