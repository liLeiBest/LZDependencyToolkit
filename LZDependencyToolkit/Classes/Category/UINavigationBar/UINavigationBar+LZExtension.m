//
//  UINavigationBar+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 16/9/8.
//
//

#import "UINavigationBar+LZExtension.h"
#import "NSObject+LZRuntime.h"

#ifndef GreateriOS10
#define GreateriOS10 [[UIDevice currentDevice].systemVersion compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending
#endif
#define bgView GreateriOS10 ? @"barBackgroundView" : @"backgroundView"

@interface UINavigationBar ()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation UINavigationBar (LZExtension)

//MARK: - Public
/** 设置 NavigationBar 背景色 方法1 */
- (void)setNavBarBackgroundColor:(UIColor *)color {
    
    if (!self.backgroundView) {
        
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.frame = CGRectMake(0, 0, self.bounds.size.width, 64);
        [[self.subviews firstObject] insertSubview:self.backgroundView atIndex:0];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundView.userInteractionEnabled = NO;
    }
    self.backgroundView.backgroundColor = color;
}

/** 设置导航栏左右按钮及标题的透明度 */
- (void)setNavBarElementsAlpha:(CGFloat)alpha {
    
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

/** 设置导航栏 Y 轴偏移量*/
- (void)setNavBarTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/** 重置 NavigationBar */
- (void)resetNavBar {
    
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

//MARK: - Private
/** runtime动态获取 backgroundView */
- (void)setBackgroundView:(UIView *)object {
    
    [self willChangeValueForKey:bgView];
    LZ_setAssociatedObject(self, _cmd, object);
    [self didChangeValueForKey:bgView];
}

- (UIView *)backgroundView {
    return LZ_getAssociatedObject(self, @selector(setBackgroundView:));
}

@end
