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

//MARK: - Override
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
 
    UIEdgeInsets edgeInsets = self.hitEdgeInsets;
    if (UIEdgeInsetsEqualToEdgeInsets(edgeInsets, UIEdgeInsetsZero) // 边界无变化
        || YES == self.hidden // 隐藏
        || 0.0f == self.alpha // 透明
        || NO == self.enabled) // 不可用
        return [super pointInside:point withEvent:event];
    
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, edgeInsets);
    hitFrame.size.width = MAX(hitFrame.size.width, 0);
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

// MARK: - Public
- (void)setHitEdgeInsets:(UIEdgeInsets)hitEdgeInsets {
    LZ_setAssociatedObject(self, _cmd, [NSValue valueWithUIEdgeInsets:hitEdgeInsets]);
}

- (UIEdgeInsets)hitEdgeInsets {
    
    NSValue *value = LZ_getAssociatedObject(self, @selector(setHitEdgeInsets:));
    if (value) {
        return [value UIEdgeInsetsValue];
    } else {
        return UIEdgeInsetsZero;
    }
}

- (void)setHitScale:(CGFloat)hitScale {
    
    CGFloat width = self.bounds.size.width * hitScale;
    CGFloat height = self.bounds.size.height * hitScale;
    self.hitEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
    LZ_setAssociatedObject(self, _cmd, [NSNumber numberWithFloat:hitScale]);
}

- (CGFloat)hitScale{
    return [LZ_getAssociatedObject(self, @selector(setHitScale:)) floatValue];
}

- (void)setHitWidthScale:(CGFloat)hitWidthScale {
    
    CGFloat width = self.bounds.size.width * hitWidthScale;
    CGFloat height = self.bounds.size.height;
    self.hitEdgeInsets = UIEdgeInsetsMake(-height, -width, -height, -width);
    LZ_setAssociatedObject(self, _cmd, [NSNumber numberWithFloat:hitWidthScale]);
}

- (CGFloat)hitWidthScale{
    return [LZ_getAssociatedObject(self, @selector(setHitWidthScale:)) floatValue];
}

- (void)setHitHeightScale:(CGFloat)hitHeightScale{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height * hitHeightScale;
    self.hitEdgeInsets = UIEdgeInsetsMake(-height, -width, -height, -width);
    LZ_setAssociatedObject(self, _cmd, [NSNumber numberWithFloat:hitHeightScale]);
}

- (CGFloat)hitHeightScale{
    return [LZ_getAssociatedObject(self, @selector(setHitHeightScale:)) floatValue];
}

@end
