//
//  UIImage+LZInstance.m
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import "UIImage+LZInstance.h"
#import "UIImage+LZEffect.h"
#import "UIColor+LZExtension.h"
#import "NSString+LZRegular.h"

@import AVFoundation;
@implementation UIImage (LZInstance)

#pragma mark - Public
/** 创建指定大小、指定颜色的纯色图片、是否为圆角 */
+ (UIImage *)imageWithColor:(UIColor *)color
					   size:(CGSize)size
					isRound:(BOOL)isRound {
	
	CGFloat width = size.width >= MAXFLOAT ? 1.0f : size.width;
	CGFloat height = size.height >= MAXFLOAT ? 1.0f : size.height;
	CGRect rect = CGRectMake(0.0f, 0.0f, width, height);
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
	
	if (isRound) {
		
		UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:height * 0.5f];
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		CGContextAddPath(ctx, path.CGPath);
		CGContextClip(ctx);
	}
	
	[color set];
	UIRectFill(rect);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

/** 根据传入参数的颜色创建相应颜色的图片 */
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size {
    return [self imageWithColor:color size:size isRound:NO];
}

/** 根据字符串内容、字体颜色、背景颜色、字体、尺寸及是否需要省略，创建图片 */
+ (UIImage *)imageWithString:(NSString *)string
             foregroundColor:(UIColor *)fgColor
             backgroundColor:(UIColor *)bgColor
                        font:(UIFont *)font
                        size:(CGSize)size
                       brief:(BOOL)brief {
    
    UIImage *image = [self imageWithColor:bgColor size:size];
    if (YES == brief) {
        string = [self watermarkFromString:string];
    }
    NSDictionary *attributes = @{
        NSFontAttributeName : font,
        NSForegroundColorAttributeName : fgColor,
    };
    return [image watermark:string attributes:attributes];
}

/** 根据字符串内容、字体颜色、背景颜色及尺寸，创建图片 */
+ (UIImage *)imageWithString:(NSString *)string
             foregroundColor:(UIColor *)fgColor
             backgroundColor:(UIColor *)bgColor
                        size:(CGSize)size {
    
    UIImage *image = [self imageWithColor:bgColor size:size];
    string = [self watermarkFromString:string];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : fgColor};
    return [image watermark:string attributes:attributes];
}

/** 根据字符串内容、前背颜色及尺寸，创建图片 */
+ (UIImage *)imageWithString:(NSString *)string
             backgroundColor:(UIColor *)bgColor
                        size:(CGSize)size {
    return [self imageWithString:string foregroundColor:[UIColor whiteColor] backgroundColor:bgColor size:size];
}

/** 根据字符串内容，创建指定大小的图片 */
+ (UIImage *)imageWithString:(NSString *)string
                        size:(CGSize)size {
    
    NSString *colorFilePath =
    [[NSBundle mainBundle] pathForResource:@"LZImageRandomColorConfig" ofType:@"plist"];
    NSArray *colorArrI = [NSArray arrayWithContentsOfFile:colorFilePath];
    if (nil == colorArrI || 0 == colorArrI.count) {
        colorArrI = [NSArray arrayWithObjects:
                     @"f4a739", @"f9886d", @"6fb7e7", @"8ec566", @"f97c94",
                     @"bdce00", @"f794be", @"7ccfde", @"b0a1d3", @"ff9c9c",
                     @"80e2c5", @"eebd93", @"b4beef", @"f1aea8", @"9abfdf",
                     @"ed8aa6", @"e2d240", @"e97984", @"acd3be", @"d8a7ca",
                     @"98da8e", @"eeaa93", @"f7ae4a", @"fcca4d", @"e8c707",
                     @"f299af", @"94ca76", @"c4d926", @"d6c7b0", @"a1d8ef",
                     nil];
    }
    
    NSUInteger index = [self colorIndexOfString:string fromColorTotal:colorArrI.count];
    UIColor *bgColor = [UIColor colorWithHexString:[colorArrI objectAtIndex:index]];
    return [self imageWithString:string foregroundColor:[UIColor whiteColor] backgroundColor:bgColor size:size];
}

+ (UIImage *)imageNamed:(id)name
              allowNull:(BOOL)allowNull {
    if ([name isKindOfClass:[UIImage class]]) {
        return (UIImage *)name;
    }
    UIImage *image = nil;
    if ([name isKindOfClass:[NSURL class]]) {
        
        NSData *imgData = [NSData dataWithContentsOfURL:(NSURL *)name];
        image = [UIImage imageWithData:imgData];
        return image;
    } else if ([name isKindOfClass:[NSData class]]) {
        
        image = [UIImage imageWithData:(NSData *)name];
        return image;
    } else if ([name isValidString]) {
        if (nil == image) {
            image = [UIImage imageWithContentsOfFile:name];;
        }
        if (nil == image) {
            
            NSURL *imgURL = [NSURL URLWithString:name];
            NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
            image = [UIImage imageWithData:imgData];
        }
        if (nil == image) {
            
            NSString *imgName = [NSString stringWithFormat:@"%@.png", name];
            NSString *path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
            image = [UIImage imageWithContentsOfFile:path];
            if (nil == image) {
                
                imgName = [NSString stringWithFormat:@"%@.jpg", name];
                path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
                image = [UIImage imageWithContentsOfFile:path];
            }
            if (nil == image) {
                
                imgName = [NSString stringWithFormat:@"%@@%.0fx.png", name, [[UIScreen mainScreen] scale]];
                path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
                image = [UIImage imageWithContentsOfFile:path];
            }
        }
    }
    if (nil == image && NO == allowNull) {
        image = [UIImage imageWithString:name size:CGSizeMake(100, 100)];
    }
    return image;
}

/** 从图片中心拉伸图片，类方法 */
+ (UIImage *)middleStretchImage:(NSString *)imageName {
    return [self stretchImage:imageName leftRatio:0.5 topRatio:0.5];
}

/** 从图片中心拉伸图片，对象方法 */
- (UIImage *)middleStretch {
    return [self stretchLeftRatio:0.5 topRatio:0.5];
}
            
/** 指定位置拉伸图片 */
+ (UIImage *)stretchImage:(NSString *)imageNmae
                leftRatio:(CGFloat)leftRatio
                 topRatio:(CGFloat)topRatio {
    
    UIImage *image = [UIImage imageNamed:imageNmae];
    CGSize imageSize = image.size;
    image = [image stretchableImageWithLeftCapWidth:imageSize.width * leftRatio
                                       topCapHeight:imageSize.height * topRatio];
    return image;
}

- (UIImage *)stretchLeftRatio:(CGFloat)leftRatio
                     topRatio:(CGFloat)topRatio {
    
    CGSize imageSize = self.size;
    return [self stretchableImageWithLeftCapWidth:imageSize.width * leftRatio
                                     topCapHeight:imageSize.height * topRatio];;
}

/** 获取当前视图截图 */
+ (UIImage *)imageFromView:(UIView *)theView {
    
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/** 获取启动图片 */
+ (UIImage *)launchImage {
    
    UIApplication *application = [UIApplication sharedApplication];
    CGSize viewSize = application.keyWindow.bounds.size;
    UIInterfaceOrientation currentOrientation = application.statusBarOrientation;
    
    NSString *viewOrientation = @"";
    switch (currentOrientation) {
        case UIInterfaceOrientationUnknown:
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            viewOrientation = @"Portrait";
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            viewOrientation = @"Landscape";
            break;
        default:
            viewOrientation = @"Portrait";
            break;
    }
    
    NSString *launchImageName = nil;
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict) {
        
        CGSize imageSize = CGSizeFromString([dict objectForKey:@"UILaunchImageSize"]);
        NSString *orientation = [dict objectForKey:@"UILaunchImageOrientation"];
        if (CGSizeEqualToSize(imageSize, viewSize)
            && [viewOrientation isEqualToString:orientation]) {
            launchImageName = [dict objectForKey:@"UILaunchImageName"];
            break;
        }
    }
    return launchImageName ? [UIImage imageNamed:launchImageName] : nil;
}

/** 获取应用图标 */
+ (UIImage *)iconImage {
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    NSString *iconLastName = [iconsArr lastObject];
    return [UIImage imageNamed:iconLastName];
}

/** 获取视频预览图 */
+ (UIImage *)previewImageWithVideoURL:(NSURL *)videoURL {
    
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMake(1, asset.duration.timescale);
    CGImageRef img = [generator copyCGImageAtTime:time actualTime:NULL error:nil];
    UIImage *image = [UIImage imageWithCGImage:img];
    CGImageRelease(img);
    return image;
}

+ (NSData *)compress:(id)image toMaxSize:(NSUInteger)maxSize {
    // 获取图片大小
    NSUInteger size = 0;
    if ([image isKindOfClass:[NSData class]]) {
        // 获取NSData字节数
        NSData *data = (NSData *)image;
        size = [data length];
        image = [[UIImage alloc] initWithData:(NSData *)image];
    } else if ([image isKindOfClass:[NSString class]]) {
        // 数据文件字节数
        NSString *path = (NSString *)image;
        NSFileManager *fileM = [NSFileManager defaultManager];
        NSDictionary<NSFileAttributeKey, id> *attributes = [fileM attributesOfItemAtPath:path error:NULL];
        size = [attributes fileSize];
        image = [UIImage imageWithContentsOfFile:(NSString *)image];
    } else if ([image isKindOfClass:[NSURL class]]) {
        // 数据文件字节数
        NSURL *URL = (NSURL *)image;
        NSFileManager *fileM = [NSFileManager defaultManager];
        NSDictionary<NSFileAttributeKey, id> *attributes = [fileM attributesOfItemAtPath:URL.relativePath error:NULL];
        size = [attributes fileSize];
        image = [UIImage imageWithContentsOfFile:URL.relativePath];
    } else if ([image isKindOfClass:[UIImage class]]) {
        // 图片字节数
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        size = data.length;
    }
    // 单位转换，1KB=1000Byte，向下四取整
    NSUInteger unit = 1000;
    NSUInteger kb = size / unit;
    // 判断是否需要压缩
    BOOL needCompress = kb > maxSize;
    NSData *data = nil;
    if (YES == needCompress) {
        data = [self compressImage:image toByte:maxSize * unit];
    } else {
        // 压缩系数不能为1，否则有些小图片会上传图片可以会失败
        data = UIImageJPEGRepresentation(image, 0.9);
    }
    return data;
}

// MARK: - Private
/**
 @author Lilei
 
 @brief 获取字符串对应的颜色索引
 
 @param string 字符串
 
 @return 颜色序号
 */
+ (NSUInteger)colorIndexOfString:(NSString *)string
                  fromColorTotal:(NSUInteger)total {
    
    NSInteger length = total;
    if (nil == string || 0 == string.length) return 0;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    const char *bytes = data.bytes;
    int r = 0;
    for (int i = 0; i < [data length]; i++) {
        r = r + (int)(bytes[i] & 0xff);
    }
    NSInteger index = r % length;
    return index;
}

/**
 @author Lilei
 
 @brief 获取需要作为水印添加的字符串
 
 @param string 原字符串
 
 @return 水印字符串
 */
+ (NSString *)watermarkFromString:(NSString *)string {
    if (string.length > 2) {
        if ([self includedInAlphabet:string]) {
            return [string substringToIndex:2];
        } else {
            return [string substringFromIndex:string.length - 2];
        }
    } else {
        return string;
    }
}

/**
 @author Lilei
 
 @brief 判断字符串是否为纯字母
 
 @param string 字符串
 
 @return BOOL
 */
+ (BOOL)includedInAlphabet:(NSString *)string {
    for (int i = 0; i < string.length; i++) {
        
        int s = [string characterAtIndex:i];
        if (s > 0x4e00 && s < 0x9fff) return NO;
    }
    return YES;
}

/// 压缩图片
/// @param image 图片
/// @param maxLength 允许大小
+ (NSData *)compressImage:(UIImage *)image
                   toByte:(NSUInteger)maxLength {
#if 1
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = nil;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        
        compression = (max + min) / 2.0;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
#else
     // Compress by size
     NSUInteger lastDataLength = 0;
     while (data.length > maxLength && data.length != lastDataLength) {
         
         lastDataLength = data.length;
         CGFloat ratio = (CGFloat)maxLength / data.length;
         CGSize size = CGSizeMake((NSUInteger)(image.size.width * sqrtf(ratio)),
                                  (NSUInteger)(image.size.height * sqrtf(ratio)));
         UIGraphicsBeginImageContext(size);
         [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
         image = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         data = UIImageJPEGRepresentation(image, compression);
     }
     return data;
#endif
}

// MARK: - Deprecated
+ (UIImage *)imageWithColor:(UIColor *)color
                    andSize:(CGSize)size {
    return [self imageWithColor:color size:size];
}
+ (UIImage *)imageWithString:(NSString *)string
                     andSize:(CGSize)size {
    return [self imageWithString:string size:size];
}
+ (UIImage *)imageNameToMiddleStretch:(NSString *)imageName {
    return [self middleStretchImage:imageName];
}
+ (UIImage *)imageNameToStretch:(NSString *)imageNmae
                      leftRatio:(CGFloat)leftRatio
                       topRatio:(CGFloat)topRatio {
    return [self stretchImage:imageNmae leftRatio:leftRatio topRatio:topRatio];
}

@end
