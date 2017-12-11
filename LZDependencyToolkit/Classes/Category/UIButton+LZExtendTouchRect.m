//
//  UIButton+LZExtendTouchRect.m
//  Pods
//
//  Created by Dear.Q on 16/8/15.
//
//

#import "UIButton+LZExtendTouchRect.h"
#import "NSObject+LZRuntime.h"

@implementation UIButton (LZExtendTouchRect)

//MARK: - runtime
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = @selector(pointInside:withEvent:);
        SEL swizzleSelector = @selector(LZ_pointInside:withEvent:);
        LZ_exchangeInstanceMethod(self, originSelector, swizzleSelector);
    });
}

- (BOOL)LZ_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIEdgeInsets edgeInsets = self.touchExtendInset;
    if (UIEdgeInsetsEqualToEdgeInsets(edgeInsets, UIEdgeInsetsZero) ||
        self.hidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled)) {
        return [super pointInside:point withEvent:event];
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, edgeInsets);
    hitFrame.size.width = MAX(hitFrame.size.width, 0);
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    
    return CGRectContainsPoint(hitFrame, point);
}

//MARK: - Setter、Getter
- (void)setTouchExtendInset:(UIEdgeInsets)touchExtendInset {
    LZ_setAssociatedObject(self, _cmd, [NSValue valueWithUIEdgeInsets:touchExtendInset]);
}

- (UIEdgeInsets)touchExtendInset {
    
    NSValue *value = LZ_getAssociatedObject(self, @selector(setTouchExtendInset:));
    if (value) {
        return [value UIEdgeInsetsValue];
    } else {
        return UIEdgeInsetsZero;
    }
}

@end
