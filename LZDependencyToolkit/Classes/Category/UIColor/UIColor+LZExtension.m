//
//  UIColor+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import "UIColor+LZExtension.h"

NSString * const LZHexDefaulColorKey = @"white";

@implementation UIColor (LZExtension)

#pragma mark - Public
/** RGBA的颜色设置 */
+ (instancetype)colorWithR:(CGFloat)red
                         G:(CGFloat)green
                         B:(CGFloat)blue
                         A:(CGFloat)alpha {
    if (alpha > 1.0) alpha = (float)alpha / 255.0f;
    return [UIColor colorWithRed:red / 255.0f
                           green:green / 255.0f
                            blue:blue / 255.0f
                           alpha:alpha];
}

/** RGB的颜色设置 */
+ (instancetype)colorWithR:(CGFloat)red
                         G:(CGFloat)green
                         B:(CGFloat)blue {
    return [self colorWithR:red G:green B:blue A:1.0];
}


/** 十六进制字符串转为颜色，可以设置透明度 */
+ (instancetype)colorWithHexString:(NSString *)hexString
                             alpha:(CGFloat)alphaValue {
    // 删除字符串的空格和换行符
    hexString = [[hexString stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceAndNewlineCharacterSet]]
                 lowercaseString];
    // 如果开关包括"#"或“##”或"0#"，则去掉
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    } else if ([hexString hasPrefix:@"##"] || [hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    // 设置默认颜色
    UIColor *color = [self colorWithName:LZHexDefaulColorKey];
    // 通过名字获取颜色
    UIColor *tempColor = [self colorWithName:hexString];
    if (tempColor != nil) return tempColor;
    // 颜色值校验
    if(![self valideColorStrFormat:hexString]) return color;
    NSRange range = NSMakeRange(0, 2);
    // R
    NSString *rString = [hexString substringWithRange:range];
    // G
    range.location = 2;
    NSString *gString = [hexString substringWithRange:range];
    // B
    range.location = 4;
    NSString *bString = [hexString substringWithRange:range];
    // Scan value
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    color = [UIColor colorWithRed:(float)r / 255.0f
                            green:(float)g / 255.0f
                             blue:(float)b / 255.0f
                            alpha:alphaValue];
    if (color == nil) color = [UIColor blueColor];
    return color;
}

/** 十六进制字符串转为颜色 */
+ (instancetype)colorWithHexString:(NSString *)hexString {
    return [self colorWithHexString:hexString alpha:1.0f];
}

/** 十六进制数值转为颜色，可以设置透明度 */
+ (instancetype)colorWithHexValue:(NSInteger)hexValue
                            alpha:(CGFloat)alphaValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF)) / 255.0
                           alpha:alphaValue];
}

/** 十六进制数值转为颜色 */
+ (instancetype)colorWithHexValue:(NSInteger)hexValue {
    return [UIColor colorWithHexValue:hexValue alpha:1.0];
}

/** 随机颜色 */
+ (instancetype)randomColor {
    return [self colorWithR:arc4random_uniform(256)
                          G:arc4random_uniform(256)
                          B:arc4random_uniform(256)
                          A:1.0];
}

/** 获取颜色的十六进制字符串(方法一) */
- (NSString *)hexString {
    
    UIColor *color = self;
    if (color == nil) return @"#000000";
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [[NSString stringWithFormat:@"#%.2x%.2x%.2x",
            (int)(components[0] * 255.0),
            (int)(components[1] * 255.0),
            (int)(components[2] * 255.0)]
            uppercaseString];
}

/** 颜色转字符串(方法二)*/
- (NSString *)changeUIColorToRGB {
    
    const CGFloat *cs = CGColorGetComponents(self.CGColor);
    NSString *r = [NSString stringWithFormat:@"%@", [self ToHex:cs[0] * 255]];
    NSString *g = [NSString stringWithFormat:@"%@", [self ToHex:cs[1] * 255]];
    NSString *b = [NSString stringWithFormat:@"%@", [self ToHex:cs[2] * 255]];
    return [NSString stringWithFormat:@"#%@%@%@", r , g, b];
}

/** 设置颜色的透明度 */
- (UIColor *)colorWithAlpha:(CGFloat)alpha {
    
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        return [UIColor colorWithRed:components[0]
                               green:components[0]
                                blue:components[0]
                               alpha:alpha];
    }
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:alpha];
}

/** 获取UIColor中红色的取值 */
- (NSInteger)red {
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        return (int)ceil((CGColorGetComponents(self.CGColor)[0] * 255.0));
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
        return NSNotFound;
    }
    return (int)ceil((CGColorGetComponents(self.CGColor)[0] * 255.0));
}

/** 获取UIColor中绿色的取值 */
- (NSInteger)green {
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        return (int)ceil((CGColorGetComponents(self.CGColor)[0] * 255.0));
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
        return NSNotFound;
    }
    return (int)ceil((CGColorGetComponents(self.CGColor)[1] * 255.0));
}

/** 获取UIColor中蓝色的取值 */
- (NSInteger)blue {
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        return (int)ceil((CGColorGetComponents(self.CGColor)[0] * 255.0));
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
        return NSNotFound;
    }
    return (int)ceil((CGColorGetComponents(self.CGColor)[2] * 255.0));
}

/** 获取UIColor中透明度的取值 */
- (CGFloat)alpha {
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        return CGColorGetComponents(self.CGColor)[1];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
        return NSNotFound;
    }
    return CGColorGetComponents(self.CGColor)[3];
}

/** 设置反色 */
- (UIColor *)reversedColor {
    
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        return [UIColor colorWithRed:1-components[0]
                               green:1-components[0]
                                blue:1-components[0]
                               alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor))!=kCGColorSpaceModelRGB) {
        return nil;
    }
    return [UIColor colorWithRed:1-components[0]
                           green:1-components[1]
                            blue:1-components[2]
                           alpha:components[1]];
}

#pragma mark - Private
/** 通过颜色名称读取Color */
+ (UIColor *)colorWithName:(NSString *)name {
    
    if(name==nil || name.length==0) return nil;
    name = [name lowercaseString];
    NSDictionary *COLOR_DICT = @{@"transparent" : [UIColor colorWithRed:0 green:0 blue:0 alpha:0],
                                 @"black" : [UIColor blackColor],
                                 @"darkgray" : [UIColor darkGrayColor],
                                 @"lightgray" : [UIColor lightGrayColor],
                                 @"white" : [UIColor whiteColor],
                                 @"gray" : [UIColor grayColor],
                                 @"red" : [UIColor redColor],
                                 @"green" : [UIColor greenColor],
                                 @"blue" : [UIColor blueColor],
                                 @"cyan" : [UIColor cyanColor],
                                 @"yellow" : [UIColor yellowColor],
                                 @"magenta" : [UIColor magentaColor],
                                 @"orange" : [UIColor orangeColor],
                                 @"purple" : [UIColor purpleColor],
                                 @"brown" : [UIColor brownColor],
                                 @"clear" : [UIColor clearColor]
                                 };
    if([COLOR_DICT.allKeys containsObject:name]) return COLOR_DICT[name];
    return nil;
}

/** 颜色值校验 */
+ (BOOL)valideColorStrFormat:(NSString *)source {
    if(source == nil || source.length == 0) {
        return NO;
    }
    if (source.length != 3 && source.length != 6 && source.length != 8) {
        return NO;
    }
    
    NSError *error;
    NSString *strNumberRegExp = @"[0-9a-fA-F]{6}";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:strNumberRegExp
                                                                             options:NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionCaseInsensitive
                                                                               error:&error];
    NSArray *matchResults = [regExp matchesInString:source
                                            options:NSMatchingReportCompletion
                                              range:NSMakeRange(0, source.length)];
    if(matchResults != nil && matchResults.count == 1) {
        
        NSRange range = [matchResults[0] range];
        return [source isEqualToString:[source substringWithRange:range]];
    }
    return NO;
}

/** 十进制转十六进制 */
- (NSString *)ToHex:(int)tmpid {
    
    NSString *endtmp = @"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig = tmpid % 16;
    int tmp = tmpid / 16;
    switch (ttmpig) {
        case 10:
            nLetterValue = @"A";
            break;
        case 11:
            nLetterValue = @"B";
            break;
        case 12:
            nLetterValue = @"C";
            break;
        case 13:
            nLetterValue = @"D";
            break;
        case 14:
            nLetterValue = @"E";
            break;
        case 15:
            nLetterValue = @"F";
            break;
        default:
            nLetterValue = [[NSString alloc] initWithFormat:@"%i", ttmpig];
    }
    
    switch (tmp) {
        case 10:
            nStrat = @"A";
            break;
        case 11:
            nStrat = @"B";
            break;
        case 12:
            nStrat = @"C";
            break;
        case 13:
            nStrat = @"D";
            break;
        case 14:
            nStrat = @"E";
            break;
        case 15:
            nStrat = @"F";
            break;
        default:
            nStrat = [[NSString alloc] initWithFormat:@"%i", tmp];
            
    }
    endtmp = [[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}

@end
