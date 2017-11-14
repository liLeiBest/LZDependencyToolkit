//
//  UIImage+LZEffect.m
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import "UIImage+LZEffect.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (LZEffect)

#pragma mark - Public
/** 根据色值改变图片的暗度 */
- (UIImage *)darkToValue:(float)darkValue
{
    return [self pixelOperationBlock:^(UInt8 *redRef,
                                       UInt8 *greenRef,
                                       UInt8 *blueRef)
    {
        *redRef = *redRef * darkValue;
        *greenRef = *greenRef * darkValue;
        *blueRef = *blueRef * darkValue;
    }];
}

/** 根据灰度级别改变图片的灰度 */
- (UIImage *)grayToLevelType:(UIImageGrayLevelType)type
{
    return [self pixelOperationBlock:^(UInt8 *redRef,
                                       UInt8 *greenRef,
                                       UInt8 *blueRef)
    {
        UInt8 red = *redRef , green = *greenRef , blue = *blueRef;
        switch (type)
        {
            case 0:
            {
                *redRef = red * 0.5;
                *greenRef = green * 0.5;
                *blueRef = blue * 0.5;
            }
                break;
            case 1:
            {
                UInt8 brightness = (77 * red + 28 * green + 151 * blue) / 256;
                *redRef = brightness;
                *greenRef = brightness;
                *blueRef = brightness;
            }
                break;
            case 2:
            {
                *redRef = red;
                *greenRef = green * 0.7;
                *blueRef = blue * 0.4;
            }
                break;
            case 3:
            {
                *redRef = 255 - red;
                *greenRef = 255 - green;
                *blueRef = 255 - blue;
            }
                break;
        }
    }];
}

/** 给图片加模糊效果 */
- (UIImage *)blurToLevel:(CGFloat)blur
{
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    // 模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) blur = 0.5f;
    
    // boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    // 图像处理
    CGImageRef img = self.CGImage;
    
    // 图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    // 像素缓存
    void *pixelBuffer;
    
    // 数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    // 宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    // 像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    // Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (!error)
    {
        error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }
    else if (!error)
    {
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }
    
    if (error) NSLog(@"error from convolution %ld", error);
    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    
    // 颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(self.CGImage));
    
    // 根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    // clean up
    CGContextRelease(ctx);
//    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}

/** 高斯模糊 */
- (UIImage *)gaussBlur:(CGFloat)blurLevel
{
    // CGImage
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    UIImage *tmpImage = [UIImage imageWithData:imageData];
    CGImageRef img = tmpImage.CGImage;
    
    // 图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    // 像素缓存
    void *pixelBuffer;
    
    // create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);

    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    // 宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    // 像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // 模糊度
    blurLevel = MIN(1.0,MAX(0.0, blurLevel));
    
    int boxSize = (int)(blurLevel * 0.1 * MIN(self.size.width, self.size.height));
    //    int boxSize = 20;
    
    boxSize = boxSize - (boxSize % 2) + 1;
    NSInteger windowR = boxSize / 2;
    
    CGFloat sig2 = windowR / 3.0;
    
    if (windowR>0) sig2 = -1/(2*sig2*sig2);
    
    int16_t *kernel = (int16_t*)malloc(boxSize*sizeof(int16_t));
    
    int32_t  sum = 0;
    
    for(NSInteger i=0; i<boxSize; ++i)
    {
        kernel[i] = 255*exp(sig2*(i-windowR)*(i-windowR));
        sum += kernel[i];
    }
    
    // convolution
    
    error = vImageConvolve_ARGB8888(&inBuffer, &outBuffer,NULL, 0, 0, kernel, boxSize, 1, sum, NULL, kvImageEdgeExtend);
    
    if (!error)
    {
        error = vImageConvolve_ARGB8888(&outBuffer, &inBuffer,NULL, 0, 0, kernel, 1, boxSize, sum, NULL, kvImageEdgeExtend);
    }
    
    free(kernel);
    
    outBuffer = inBuffer;
    
    if (error) NSLog(@"error from convolution %ld", error);
    
    CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             
                                             outBuffer.width,
                                             
                                             outBuffer.height,
                                             
                                             8,
                                             
                                             outBuffer.rowBytes,
                                             
                                             colorSpace,
                                             
                                             kCGBitmapAlphaInfoMask &kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef =CGBitmapContextCreateImage(ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    // clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}

/** 添加水印 */
- (UIImage *)watermark:(NSString *)content
            attributes:(NSDictionary *)attributes
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    NSMutableDictionary *tempAttributes = [NSMutableDictionary dictionaryWithDictionary:attributes];
    UIFont *myFont = [attributes objectForKey:NSFontAttributeName];
    if (nil == myFont)
    {
        myFont = [UIFont systemFontOfSize:self.size.width / 4];
        [tempAttributes setObject:myFont
                           forKey:NSFontAttributeName];
    }
    
    UIColor *myColor = [attributes objectForKey:NSForegroundColorAttributeName];
    if (nil == myColor)
    {
        myColor = [UIColor whiteColor];
        [tempAttributes setObject:myColor
                           forKey:NSForegroundColorAttributeName];
    }
    
    CGSize theStringSize = [content sizeWithAttributes:tempAttributes];
    CGRect rect = CGRectMake(self.size.width / 2 - theStringSize.width / 2,
                             self.size.height / 2 - theStringSize.height / 2,
                             theStringSize.width,
                             theStringSize.height);
    
    [tempAttributes removeObjectForKey:NSStrokeColorAttributeName];
    [content drawInRect:rect withAttributes:tempAttributes];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Private
- (UIImage *)pixelOperationBlock:(void(^)(UInt8 *redRef,
                                          UInt8 *greenRef,
                                          UInt8 *blueRef))block
{
    if(block == nil)
        return self;
    
    CGImageRef  imageRef = self.CGImage;
    if(imageRef == NULL)
        return nil;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    CFDataRef   data = CGDataProviderCopyData(dataProvider);
    UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            block(&red,&green,&blue);
            
            *(tmp + 0) = red;
            *(tmp + 1) = green;
            *(tmp + 2) = blue;
        }
    }
    
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [UIImage imageWithCGImage:effectedCgImage];
    
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}

@end
