//
//  UIImage+LZMachineReadableCode.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2020/4/17.
//

#import "UIImage+LZMachineReadableCode.h"
#import "UIImage+LZClipping.h"
#import <CoreImage/CoreImage.h>

@implementation UIImage (LZMachineReadableCode)

// MARK: - Public
// MARK: 二维码
+ (UIImage *)QRCodeImageWithString:(NSString *)string {
    
    CIImage *image = [self QRCodeCIImageWithString:string];
    return [UIImage imageWithCIImage:image];
}

+ (UIImage *)QRCodeImageWithString:(NSString *)string
                              size:(CGFloat)size {
    
    CIImage *image = [self QRCodeCIImageWithString:string];
    return [self createNonInterpolatedUIImageFromCIImage:image withSize:size];
}

- (UIImage *)QRCodeImageWithString:(NSString *)string
                              size:(CGFloat)size {
    return [self QRCodeImageWithString:string size:size fillColor:nil];
}

- (UIImage *)QRCodeImageWithString:(NSString *)string
                              size:(CGFloat)size
                         fillColor:(UIColor *)color {
    
    UIImage *image = [UIImage QRCodeImageWithString:string size:size];
    
    if (nil != color
        && 4 == CGColorGetNumberOfComponents(color.CGColor)) {
        
        CGFloat R, G, B;
        CGColorRef colorRef = [color CGColor];
        const CGFloat *components = CGColorGetComponents(colorRef);
        R = components[0] * 255.0;
        G = components[1] * 255.0;
        B = components[2] * 255.0;
        image = [self imageBlackToTransparent:image red:R green:G blue:B];
    }
    UIImage *finalImg = image;
    if (NO == CGSizeEqualToSize(self.size, CGSizeZero)) {
        
        UIImage *centerImg = self;
        if (MIN(self.size.width, self.size.height) > size * 0.3) {
            
            CGFloat fitSize = size * 0.3;
            centerImg = [centerImg scaledToSize:CGSizeMake(fitSize, fitSize)];
        }
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        CGFloat x = (image.size.width - centerImg.size.width) * 0.5;
        CGFloat y = (image.size.height - centerImg.size.height) * 0.5;
        [centerImg drawAtPoint:CGPointMake(x, y)];
        finalImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return finalImg;
}

- (NSString *)QRCodeString {
    
    CIImage *ciimage = [CIImage imageWithCGImage:self.CGImage];
    if (ciimage) {
        
        CIContext *ciContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
        CIDetector *qrDetector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:ciContext options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
        NSArray *resultArr = [qrDetector featuresInImage:ciimage];
        if (resultArr.count > 0) {
            
            CIFeature *feature = resultArr[0];
            CIQRCodeFeature *qrFeature = (CIQRCodeFeature *)feature;
            NSString *result = qrFeature.messageString;
            return result;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

// MARK: 条形码
+ (UIImage *)barCodeImageWithString:(NSString *)string {
    
    CIImage *image = [self barCodeCIImageWithString:string];
    return [UIImage imageWithCIImage:image scale:0 orientation:UIImageOrientationUp];
}

// MARK: - Private
/// 机器码类型
typedef NS_ENUM(NSInteger, MachineReadableCodeType) {
    /// 二维码
    MachineReadableQRCode,
    /// 条形码
    MachineReadableBarCode
};

/**
@author Lilei

@brief 生成机器码

@param string 字符串

@return CIImage
*/
+ (CIImage *)machineCode:(MachineReadableCodeType)codeType
                  string:(NSString *)string {
    
    NSString *filterName = nil;
    switch (codeType) {
        case MachineReadableQRCode:
            filterName = @"CIQRCodeGenerator";
            break;
        case MachineReadableBarCode:
            filterName = @"CICode128BarcodeGenerator";
        default:
            break;
    }
    if (nil == filterName) {
        return nil;
    }
    CIFilter *filter = [CIFilter filterWithName:filterName];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKey:@"inputMessage"];
    if (codeType == MachineReadableQRCode) {
        /**
         inputCorrectionLevel
         等级  容错率
         L     7%
         M     15%  默认值
         Q     25%
         H     30%
         */
        [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    }
    if (codeType == MachineReadableBarCode) {
        // 设置生成的条形码的上，下，左，右的margins的值
        [filter setValue:[NSNumber numberWithInteger:0] forKey:@"inputQuietSpace"];
    }
    CIImage *image = [filter outputImage];
    return image;
}

/**
@author Lilei

@brief 生成二维码

@param string 字符串

@return CIImage
*/
+ (CIImage *)QRCodeCIImageWithString:(NSString *)string {
    return [self machineCode:MachineReadableQRCode string:string];
}

/**
@author Lilei

@brief 根据CIImage生成指定大小的UIImage

@param image CIImage
@param size  图片宽度以及高度

@return CIImage
*/
+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image
                                            withSize:(CGFloat)size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/**
@author Lilei

@brief 改变图片中黑色

@param image UIImage
@param red   CGFloat 0~255
@param green CGFloat 0~255
@param blue  CGFloat 0~255
@return UIImage
*/
- (UIImage*)imageBlackToTransparent:(UIImage *)image
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(CGFloat)blue {
    
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) { // 将白色变成透明
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red;
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

/**
@author Lilei

@brief 生成条件码

@param string 字符串

@return CIImage
*/
+ (CIImage *)barCodeCIImageWithString:(NSString *)string {
    return [self machineCode:MachineReadableBarCode string:string];;
}

@end
