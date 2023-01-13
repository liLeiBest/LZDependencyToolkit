//
//  UIColor+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import <UIKit/UIKit.h>

/** rgb颜色转换（16进制->10进制） */
#define LZColorWithHexValue(hexValue) \
[UIColor colorWithHexValue:hexValue]

/** 十六进制颜色字符串转为UIColor */
#define LZColorWithHexString(hexString) \
[UIColor colorWithHexString:hexString]

/** 带有RGBA的颜色设置 */
#define LZColorWithRGBA(red, green, blue, alpha) \
[UIColor colorWithR:red/255.0 G:green/255.0 B:blue/255.0 A:alpha]

/** 带有RGB的颜色设置 */
#define LZColorWithRGB(red, green, blue) \
[UIColor colorWithR:red/255.0 G:green/255.0 B:blue/255.0]

/** 随机颜色 */
#define LZRandomColor \
[UIColor randomColor]

/** 纯色 */
#define LZBlackColor [UIColor blackColor]           // 黑色
#define LZDarkGrayColor [UIColor darkGrayColor]     // 暗灰
#define LZLightGrayColor [UIColor lightGrayColor]   // 亮灰
#define LZWhiteColor [UIColor whiteColor]           // 白色
#define LZGrayColor [UIColor grayColor]             // 灰色
#define LZRedColor [UIColor redColor]               // 红色
#define LZGreenColor [UIColor greenColor]           // 绿色
#define LZBlueColor [UIColor blueColor]             // 蓝色
#define LZCyanColor [UIColor cyanColor]             // 蓝绿
#define LZYellowColor [UIColor yellowColor]         // 黄色
#define LZMagentaColor [UIColor magentaColor]       // 洋红
#define LZOrangeColor [UIColor orangeColor]         // 橙色
#define LZPurpleColor [UIColor purpleColor]         // 紫色
#define LZBrownColor [UIColor brownColor]           // 棕色
#define LZClearColor [UIColor clearColor]           // 透明色

UIKIT_EXTERN NSString * const LZHexDefaulColorKey;

@interface UIColor (LZExtension)

#pragma mark - 类方法
/**
 @author Lilei
 
 @brief RGBA的颜色设置
 
 @param red   red
 @param green green
 @param blue  blue
 @param alpha alpha
 
 @return UIColor
 */
+ (instancetype)colorWithR:(CGFloat)red
                         G:(CGFloat)green
                         B:(CGFloat)blue
                         A:(CGFloat)alpha;

/**
 @author Lilei
 
 @brief RGB的颜色设置
 
 @param red   red
 @param green green
 @param blue  blue
 
 @return UIColor
 */
+ (instancetype)colorWithR:(CGFloat)red
                         G:(CGFloat)green
                         B:(CGFloat)blue;
/**
 @author Lilei
 
 @brief 十六进制字符串转为颜色，可以设置透明度
 
 @param hexString 十六进制字符串
 @param alphaValue 透明度
 
 @return UIColor
 */
+ (instancetype)colorWithHexString:(NSString *)hexString
                             alpha:(CGFloat)alphaValue;

/**
 @author Lilei
 
 @brief 十六进制字符串转为颜色
 
 @param hexString 十六进制字符串
 
 @return UIColor
 */
+ (instancetype)colorWithHexString:(NSString *)hexString;

/**
 @author Lilei
 
 @brief 十六进制数值转为颜色，可以设置透明度
 
 @param hexValue   十六进制数值
 @param alphaValue 透明度
 
 @return UIColor
 */
+ (instancetype)colorWithHexValue:(NSInteger)hexValue
                            alpha:(CGFloat)alphaValue;

/**
 @author Lilei
 
 @brief 十六进制数值转为颜色
 
 @param hexValue   十六进制数值
 
 @return UIColor
 */
+ (instancetype)colorWithHexValue:(NSInteger)hexValue;

/**
 @author Lilei
 
 @brief 随机颜色
 
 @return UIColor
 */
+ (instancetype)randomColor;

#pragma mark - 对象方法
/**
 @author Lilei
 
 @brief 获取颜色的十六进制字符串
 
 @return 十六进制字符串
 */
- (NSString *)hexString;

/**
 @author Lilei
 
 @brief 设置颜色的透明度
 
 @param alpha 透明度(0.0~1.0)
 
 @return UIColor
 */
- (UIColor *)colorWithAlpha:(CGFloat)alpha;

/**
 @author Lilei
 
 @brief 获取UIColor中红色的取值
 
 @return NSInteger
 */
- (NSInteger)red;

/**
 @author Lilei
 
 @brief 获取UIColor中绿色的取值
 
 @return NSInteger
 */
- (NSInteger)green;

/**
 @author Lilei
 
 @brief 获取UIColor中蓝色的取值
 
 @return NSInteger
 */
- (NSInteger)blue;

/**
 @author Lilei
 
 @brief 获取UIColor中透明度的取值
 
 @return NSInteger
 */
- (CGFloat)alpha;

/**
 @author Lilei
 
 @brief 设置反色
 
 @return UIColor
 */
- (UIColor *)reversedColor;

@end
