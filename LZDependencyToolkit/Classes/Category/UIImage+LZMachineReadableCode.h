//
//  UIImage+LZMachineReadableCode.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2020/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LZMachineReadableCode)

// MARK: - 二维码
// MARK: <生成二维码>
/**
@author Lilei

@brief 生成二维码

@param string 视频 URL
@return UIImage
*/
+ (UIImage *)QRCodeImageWithString:(NSString *)string;

/**
@author Lilei

@brief 生成二维码，指定大小

@param string 视频 URL
@param size   CGFloat
@return UIImage
*/
+ (UIImage *)QRCodeImageWithString:(NSString *)string
                              size:(CGFloat)size;

/**
@author Lilei

@brief 生成二维码，指定大小，并将图片插到二维码中心

@param string 视频 URL
@param size   CGFloat
@return UIImage
*/
- (UIImage *)QRCodeImageWithString:(NSString *)string
                              size:(CGFloat)size;

/**
@author Lilei

@brief 生成二维码，指定大小，并将图片插到二维码中心

@param string 视频 URL
@param size   CGFloat
@param color  UIColor
@return UIImage
*/
- (UIImage *)QRCodeImageWithString:(NSString *)string
                              size:(CGFloat)size
                         fillColor:(UIColor * _Nullable)color;

// MARK: <识别二维码>
- (NSString * _Nullable)QRCodeString;

// MARK: - 条形码
// MARK: <生成条形码>
/**
@author Lilei

@brief 生成条形码

@param string 视频 URL
@return UIImage
*/
+ (UIImage *)barCodeImageWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
