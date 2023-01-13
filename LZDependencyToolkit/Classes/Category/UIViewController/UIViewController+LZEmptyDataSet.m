//
//  UIViewController+LZEmptyDataSet.m
//  Pods
//
//  Created by Dear.Q on 16/8/18.
//
//

#import "UIViewController+LZEmptyDataSet.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIImage+LZInstance.h"
#import "UIColor+LZExtension.h"
#import "NSObject+LZRuntime.h"

@interface UIViewController (LZEmptyDataSet)<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, LZEmptyDataSetDelegate>
@end

@implementation UIViewController (LZEmptyDataSet)

// MARK: - Public
// MARK: Setter/Getter
- (UIImage *)emptyDataSetImage {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetImage:(UIImage *)emptyDataSetImage {
    LZ_setAssociatedObject(self, @selector(emptyDataSetImage), emptyDataSetImage);
}

- (NSString *)emptyDataSetTitle {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetTitle:(NSString *)emptyDataSetTitle {
    LZ_setAssociatedCopyObject(self, @selector(emptyDataSetTitle), emptyDataSetTitle);
}

- (UIColor *)emptyDataSetTitleColor {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetTitleColor:(UIColor *)emptyDataSetTitleColor {
    LZ_setAssociatedObject(self, @selector(emptyDataSetTitleColor), emptyDataSetTitleColor);
}

- (NSString *)emptyDataSetDetail {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetDetail:(NSString *)emptyDataSetDetail {
    LZ_setAssociatedCopyObject(self, @selector(emptyDataSetDetail), emptyDataSetDetail);
}

- (UIColor *)emptyDataSetDetailColor {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetDetailColor:(UIColor *)emptyDataSetDetailColor {
    LZ_setAssociatedObject(self, @selector(emptyDataSetDetailColor), emptyDataSetDetailColor);
}

- (NSString *)emptyDataSetButtonTitle {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetButtonTitle:(NSString *)emptyDataSetButtonTitle {
    LZ_setAssociatedCopyObject(self, @selector(emptyDataSetButtonTitle), emptyDataSetButtonTitle);
}

- (UIColor *)emptyDataSetButtonTitleColor {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetButtonTitleColor:(UIColor *)emptyDataSetButtonTitleColor {
    LZ_setAssociatedObject(self, @selector(emptyDataSetButtonTitleColor), emptyDataSetButtonTitleColor);
}

- (NSString *)emptyDataSetButtonBackgroundColor {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetButtonBackgroundColor:(NSString *)emptyDataSetButtonBackgroundColor {
    LZ_setAssociatedCopyObject(self, @selector(emptyDataSetButtonBackgroundColor), emptyDataSetButtonBackgroundColor);
}

- (UIImage *)emptyDataSetButtonBackgroundImage {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetButtonBackgroundImage:(UIImage *)emptyDataSetButtonBackgroundImage {
    LZ_setAssociatedObject(self, @selector(emptyDataSetButtonBackgroundImage), emptyDataSetButtonBackgroundImage);
}

- (NSNumber *)emptyDataSetVerticalOff {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setEmptyDataSetVerticalOff:(NSNumber *)emptyDataSetVerticalOff {
    LZ_setAssociatedObject(self, @selector(emptyDataSetVerticalOff), emptyDataSetVerticalOff);
}

// MARK: Method
- (void)showEmptyDataSet:(UIScrollView *)scrollView {
    
    scrollView.emptyDataSetSource = self;
    scrollView.emptyDataSetDelegate = self;
    [scrollView reloadEmptyDataSet];
}

- (void)hideEmptyDataSet:(UIScrollView *)scrollView {
    
    scrollView.emptyDataSetSource = nil;
    scrollView.emptyDataSetDelegate = nil;
}

// MARK: - Private
- (NSAttributedString *)emptyDataTitleAttribute:(NSString *)title {
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:[UIFont systemFontOfSize:15]
                   forKey:NSFontAttributeName];
    [attributes setObject:self.emptyDataSetTitleColor ? self.emptyDataSetTitleColor : [UIColor lightGrayColor]
                   forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (NSAttributedString *)emptyDataDetailAttribute:(NSString *)detail {
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:[UIFont systemFontOfSize:13]
                   forKey:NSFontAttributeName];
    [attributes setObject:self.emptyDataSetDetailColor ? self.emptyDataSetDetailColor : [UIColor lightGrayColor]
                   forKey:NSForegroundColorAttributeName];
    [attributes setObject:paragraph
                   forKey:NSParagraphStyleAttributeName];
    return [[NSMutableAttributedString alloc] initWithString:detail attributes:attributes];
}

- (NSAttributedString *)LZEmptyDataSetButtonTitleAttribute:(NSString *)title {
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:[UIFont systemFontOfSize:13]
                   forKey:NSFontAttributeName];
    [attributes setObject:self.emptyDataSetButtonTitleColor ? self.emptyDataSetButtonTitleColor : [UIColor whiteColor]
                   forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

// MARK: - DZNEmptyDataSet
// MARK: <DZNEmptyDataSetSource>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyDataSetImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (nil != self.emptyDataSetTitle && self.emptyDataSetTitle.length) {
        return [self emptyDataTitleAttribute:self.emptyDataSetTitle];
    }
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (nil != self.emptyDataSetDetail && self.emptyDataSetDetail.length) {
        return [self emptyDataDetailAttribute:self.emptyDataSetDetail];
    }
    return nil;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView
                                          forState:(UIControlState)state {
    if (nil != self.emptyDataSetButtonTitle && self.emptyDataSetButtonTitle.length) {
        return [self LZEmptyDataSetButtonTitleAttribute:self.emptyDataSetButtonTitle];
    }
    return nil;
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView
                                         forState:(UIControlState)state {
    if (nil != self.emptyDataSetButtonBackgroundImage) {
        return self.emptyDataSetButtonBackgroundImage;
    }
    if (nil != self.emptyDataSetButtonBackgroundColor && self.emptyDataSetButtonBackgroundColor.length) {
        return [UIImage imageWithColor:[UIColor colorWithHexString:self.emptyDataSetButtonBackgroundColor]
                                  size:CGSizeMake(100, 100)];
    }
    return nil;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    
    SEL selector = @selector(emptyDataCustomView);
    if ([self respondsToSelector:selector]) {
        
        IMP imp = [self methodForSelector:selector];
        UIView * (*func)(id, SEL) = (void *)imp;
        return func(self, selector);;
    }
    return nil;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    
    SEL selector = @selector(verticalOffsetForEmptyDataSet);
    if ([self respondsToSelector:selector]) {
        
        IMP imp = [self methodForSelector:selector];
        CGFloat (*func)(id, SEL) = (void *)imp;
        return func(self, selector);
    } else if (nil != self.emptyDataSetVerticalOff) {
        return self.emptyDataSetVerticalOff.floatValue;
    }
    return -scrollView.contentOffset.y * 0.5;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 0.0;
}

//MARK: <DZNEmptyDataSetDelegate>
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView
          didTapView:(UIView *)view {
    
    SEL selector = @selector(emptyDidTapView);
    if ([self respondsToSelector:selector]) {
        
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView
        didTapButton:(UIButton *)button {
    
    SEL selector = @selector(emptyDidTapButton);
    if ([self respondsToSelector:selector]) {
        
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
    }
}

@end
