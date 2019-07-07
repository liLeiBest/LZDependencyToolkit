//
//  UIView+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import "UIView+LZExtension.h"
#import "NSBundle+LZExtension.h"

@implementation UIView (LZFrame)

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
	self.x = left;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
	self.y = top;
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
	self.x = right - self.width;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	self.y = bottom - self.height;
}

- (CGFloat)centerX {
	return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
	
	CGPoint center = self.center;
	center.x = centerX;
	self.center = center;
}

- (CGFloat)centerY {
	return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
	
	CGPoint center = self.center;
	center.y = centerY;
	self.center = center;
}

- (CGFloat)x {
	return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
	
	CGRect tempFrame = self.frame;
	tempFrame.origin.x = x;
	self.frame = tempFrame;
}

- (CGFloat)y {
	return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
	
	CGRect tempFrame = self.frame;
	tempFrame.origin.y  = y;
	self.frame = tempFrame;
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	
	CGRect tempFrame = self.frame;
	tempFrame.size.width = width;
	self.frame = tempFrame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	
	CGRect tempFrame = self.frame;
	tempFrame.size.height = height;
	self.frame = tempFrame;
}

- (CGPoint)orgin {
	return self.frame.origin;
}

- (void)setOrgin:(CGPoint)orgin {
	
	CGRect frame = self.frame;
	frame.origin = orgin;
	self.frame = frame;
}

- (CGSize)size {
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (CGPoint)midPoint {
	return CGPointMake(self.width / 2, self.height / 2);
}

- (CGFloat)midX {
	return self.width / 2;
}

- (CGFloat)midY {
	return self.height / 2;
}

@end

@implementation UIView (LZViewController)

/** 获取当前视图所在的控制器 */
- (UIViewController *)viewController {
	
	UIResponder *responder = self;
	while ((responder = [responder nextResponder])) {
		
		if ([responder isKindOfClass: [UIViewController class]]) {
			return (UIViewController *)responder;
		}
	}
	
	return nil;
}

@end

@implementation UIView (LZBunble)

- (NSBundle *)bundleForResource:(NSString *)resource {
	return [NSBundle bundleForResource:resource
						referenceClass:NSStringFromClass([self class])];
}

- (UIImage *)image:(NSString *)imageName
		  inBundle:(NSString *)bundleName {
	return [NSBundle image:imageName
				  inBundle:bundleName
			referenceClass:NSStringFromClass([self class])];
}

+ (instancetype)viewFromXib:(NSString *)xibName
				   inBundle:(NSString *)bundleName {
	return [NSBundle viewFromXib:xibName
						inBundle:bundleName
				  referenceClass:NSStringFromClass([self class])];
}

- (instancetype)reuseViewFromXib:(NSString *)xibName
						inBundle:(NSString *)bundleName {
	
	return [NSBundle reuseViewFromXib:xibName
								owner:self
							 inBundle:bundleName
					   referenceClass:NSStringFromClass([self class])];
}

@end

@implementation UIView (LZRoundCorner)

- (void)roundingCorners:(UIRectCorner)corners
				 radius:(CGFloat)radius {
	
	[self roundedRect:self.bounds roundingCorners:corners radius:radius];
}

- (void)roundedRect:(CGRect)rect
	roundingCorners:(UIRectCorner)corners
			 radius:(CGFloat)radius {
	
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
											   byRoundingCorners:corners
													 cornerRadii:CGSizeMake(radius, radius)];
	CAShapeLayer *shapeLayer = [CAShapeLayer layer];
	shapeLayer.path = path.CGPath;
	self.layer.mask = shapeLayer;
}

@end
