//
//  UIImage+LZClipping.m
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import "UIImage+LZClipping.h"

@implementation UIImage (LZClipping)

#pragma mark - Public
/** 根据size缩放图片 */
- (instancetype)scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** 对UIImage进行放大 */
- (instancetype)scale:(CGFloat)scale
{
    return [UIImage imageWithCGImage:self.CGImage
                               scale:scale
                         orientation:UIImageOrientationUp];
}

/** 根据rect缩放图片 */
- (instancetype)clipToRect:(CGRect)newRect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, newRect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    
    return smallImage;
}

/** 等比例缩放图片 */
- (instancetype)ratioToSize:(CGSize)newSize
{
	CGFloat width = self.size.width;
	CGFloat height = self.size.height;
	float verticalRadio = newSize.height / height;
	float horizontalRadio = newSize.width / width;
	float radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
	width = width * radio;
	height = height * radio;
	
	return [self scaledToSize:CGSizeMake(width,height)];
}

/** 按最短边等比压缩 */
- (instancetype)ratioCompressToSize:(CGSize)newSize
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    if(width < newSize.width && height < newSize.height)
    {
        return self;
    }
    else
    {
        return [self ratioToSize:newSize];
    }
}

/** 添加圆角 */
- (instancetype)roundToSize:(CGSize)size
{
    int w = size.width;
    int h = size.height;
    
    UIImage *img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (uint32_t)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, w * 0.5f, h * 0.5f);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage* image2 =  [UIImage imageWithCGImage:imageMasked];
    CGContextRelease(context);
    CGImageRelease(imageMasked);
    CGColorSpaceRelease(colorSpace);
    return image2;
}

/** 设置 Image 的尺寸 */
- (UIImage *)resizeImageToSize:(CGSize)size
          interpolationQuality:(CGInterpolationQuality)quality
{
    CGImageRef imageRef = self.CGImage;
    CGSize srcSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    if (CGSizeEqualToSize(size, srcSize)) return self;
    CGFloat scaleRatio = size.width / srcSize.width;
    UIImageOrientation orientation = self.imageOrientation;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (orientation)
    {
        case UIImageOrientationUp:
        {
            transform = CGAffineTransformIdentity;
            break;
        }
        case UIImageOrientationDown:
        {
            transform = CGAffineTransformMakeTranslation(srcSize.width, srcSize.height);
            transform = CGAffineTransformScale(transform, -1.0, -1.0);
            break;
        }
        case UIImageOrientationLeft:
        {
            size = CGSizeMake(size.height, size.width);
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
        }
        case UIImageOrientationRight:
        {
            size = CGSizeMake(size.height, size.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            transform = CGAffineTransformMakeTranslation(srcSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            size = CGSizeMake(size.height, size.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, srcSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            size = CGSizeMake(size.height, size.width);
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        }
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Inval image orientaion!"];
            break;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (nil == context) return nil;
    
    if (orientation == UIImageOrientationRight ||
        orientation == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -srcSize.height, 0);
    }
    else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -srcSize.height);
    }
    
    CGContextConcatCTM(context, transform);
    CGContextSetInterpolationQuality(context, quality);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, srcSize.width, srcSize.height), imageRef);
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizeImage;
}

/** 设置图片的 UIViewContentMode、CGSize、CGInterpolationQuality */
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality
{
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode)
    {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException
                        format:@"Unsupported content mode: %d", (int)contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self resizeImageToSize:newSize interpolationQuality:quality];
}

-(UIImage *)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale
{
    CGImageRef imgRef = self.CGImage;
    CGSize srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    UIImageOrientation orient = self.imageOrientation;
    switch (orient) {
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            boundingSize = CGSizeMake(boundingSize.height, boundingSize.width);
            break;
        default:
            break;
    }
    
    CGSize dstSize;
    if ( !scale && (srcSize.width < boundingSize.width) && (srcSize.height < boundingSize.height) ) {
        dstSize = srcSize;
    } else {
        CGFloat wRatio = boundingSize.width / srcSize.width;
        CGFloat hRatio = boundingSize.height / srcSize.height;
        
        if (wRatio < hRatio) {
            dstSize = CGSizeMake(boundingSize.width, floorf(srcSize.height * wRatio));
        } else {
            dstSize = CGSizeMake(floorf(srcSize.width * hRatio), boundingSize.height);
        }
    }
    
    return [self resizeImageToSize:dstSize interpolationQuality:kCGInterpolationDefault];
}

#pragma mark - Private
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw,fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);                // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);   // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);     // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);      // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);    // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality
{
    CGRect newRect;
    if ([self respondsToSelector:@selector(scale)])
    {
        newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width * self.scale, newSize.height * self.scale));
    }
    else
    {
        newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    }
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage;
    if ([self respondsToSelector:@selector(scale)] &&
        [UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        newImage = [UIImage imageWithCGImage:newImageRef scale:self.scale orientation:self.imageOrientation];
    } else {
        newImage = [UIImage imageWithCGImage:newImageRef];
    }
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

@end
