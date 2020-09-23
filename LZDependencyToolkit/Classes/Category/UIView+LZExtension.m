//
//  UIView+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import "UIView+LZExtension.h"
#import "NSBundle+LZExtension.h"
#import "NSObject+LZRuntime.h"

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

static char const * const kBorderLayer = "zl_borderLayer";
@interface LZWeakLayerObjectContainer : NSObject

@property (nonatomic, readonly, strong) id weakObject;

/** 构造方法 */
- (instancetype)initWithWeakObject:(id)object;

@end

@implementation LZWeakLayerObjectContainer

- (instancetype)initWithWeakObject:(id)object {
    
    if (self = [super init]) {
        _weakObject = object;
    }
    return self;
}

@end

@implementation UIView (LZRoundCorner)

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
    
    LZWeakLayerObjectContainer *container = LZ_getAssociatedObject(self, kBorderLayer);
    return container.weakObject;
}

- (void)setBorderLayer:(CAShapeLayer *)emptyDataSetImage {
    LZ_setAssociatedObject(self, kBorderLayer, [[LZWeakLayerObjectContainer alloc] initWithWeakObject:emptyDataSetImage]);
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

@implementation UIView (LZInputView)

- (void)configLimitLength:(NSUInteger)limitLength
              textContent:(NSString *)textContent {
    [self configLimitLength:limitLength textContent:textContent changeHandler:nil];
}

- (void)configLimitLength:(NSUInteger)limitLength
              textContent:(NSString *)textContent
            changeHandler:(nullable void (^)(BOOL))handler {
    
    Protocol *protocol = @protocol(UITextInput);
    NSAssert([self conformsToProtocol:protocol], @"不是可输入视图");
    UIView<UITextInput> *inputView = (UIView<UITextInput> *)self;
    
    long count = 0;
    // 获取当前输入模式
    NSArray *activeInputModes = [UITextInputMode activeInputModes];
    UITextInputMode *currentInputMode = [activeInputModes firstObject];
    NSString *currentLanguage = [currentInputMode primaryLanguage];
    
    UITextPosition *position = nil;
    if ([currentLanguage isEqualToString:@"zh-Hans"]) {
        //获取高亮部分
        UITextRange *selectedRange = [inputView markedTextRange];
        position = [inputView positionFromPosition:selectedRange.start offset:0];
        if (!position) { // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            count = limitLength - textContent.length;
            if (handler) {
                handler(NO);
            }
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
            if (handler) {
                handler(YES);
            }
        }
    } else { // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        count = limitLength - [inputView countWord:textContent];
        if (handler) {
            handler(NO);
        }
    }
    
    if (count <= 0 && nil == position) {
        
        SEL selector = @selector(setText:);
        if ([inputView respondsToSelector:selector]) {
            
            NSString *content = [textContent substringToIndex:limitLength];
            IMP imp = [inputView methodForSelector:selector];
            void (*func)(id, SEL, NSString *) = (void *)imp;
            func(inputView, selector, content);
        }
        if (handler) {
            handler(NO);
        }
    }
}

// MARK: - Private
- (long)countWord:(NSString *)s {
    
    long i, n = [s length], l = 0,a = 0,b = 0;
    unichar c;
    for (i = 0; i < n; i++) {
        
        c = [s characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a==0 && l==0) return 0;
    return l+(float)ceilf((float)(a+b));
}

@end

@implementation UIView (LZScreenShort)

- (UIImage *)onScreenShort {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    BOOL success = [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return success ? image : nil;
}

@end
