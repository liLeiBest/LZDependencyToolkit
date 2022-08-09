//
//  UIView+LZRoundCorner.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import "UIView+LZRoundCorner.h"
#import "NSObject+LZRuntime.h"

@implementation UIView (LZRoundCorner)

// MARK: - Public
- (void)roundingCorners:(UIRectCorner)corners
                 radius:(CGFloat)radius {
    [self roundedRect:self.bounds
      roundingCorners:corners
               radius:radius];
}

- (void)roundingCorners:(UIRectCorner)corners
                 radius:(CGFloat)radius
            borderColor:(UIColor *)borderColor
            borderWidth:(CGFloat)borderWidth {
    [self roundedRect:self.bounds
    roundingCorners:corners
             radius:radius
        borderColor:borderColor
        borderWidth:borderWidth];
}

- (void)roundedRect:(CGRect)rect
    roundingCorners:(UIRectCorner)corners
             radius:(CGFloat)radius {
    [self roundedRect:rect
      roundingCorners:corners
               radius:radius
               border:NO
          borderColor:nil
          borderWidth:0];
}

- (void)roundedRect:(CGRect)rect
    roundingCorners:(UIRectCorner)corners
             radius:(CGFloat)radius
        borderColor:(UIColor *)borderColor
        borderWidth:(CGFloat)borderWidth {
    [self roundedRect:rect
      roundingCorners:corners
               radius:radius
               border:YES
          borderColor:borderColor
          borderWidth:borderWidth];
}

// MARK: - Private
- (CAShapeLayer *)borderLayer {
    return LZ_getAssociatedObject(self, _cmd);;
}

- (void)setBorderLayer:(CAShapeLayer *)emptyDataSetImage {
    LZ_setAssociatedObject(self, @selector(borderLayer), emptyDataSetImage);
}

- (void)roundedRect:(CGRect)rect
    roundingCorners:(UIRectCorner)corners
             radius:(CGFloat)radius
             border:(BOOL)border
        borderColor:(UIColor * __nullable)borderColor
        borderWidth:(CGFloat)borderWidth {
    // 圆角
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    // 边框
    if (YES == border) {
        if (nil == self.borderLayer) {
            
            self.borderLayer = [CAShapeLayer layer];
            [self.layer addSublayer:self.borderLayer];
        }
        CAShapeLayer *borderLayer = self.borderLayer;
        borderLayer.path = path.CGPath;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.lineWidth = borderWidth;
        borderLayer.frame = rect;
    }
}

@end
