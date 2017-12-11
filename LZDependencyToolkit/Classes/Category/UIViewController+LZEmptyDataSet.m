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

@interface LZWeakObjectContainer : NSObject

@property (nonatomic, readonly, strong) id weakObject;

/** 构造方法 */
- (instancetype)initWithWeakObject:(id)object;

@end

@implementation LZWeakObjectContainer

- (instancetype)initWithWeakObject:(id)object {
    
    if (self = [super init]) {
        _weakObject = object;
    }
    
    return self;
}

@end

static char const * const kEmptyDataSetImage = "emptyDataSetImage";
static char const * const kEmptyDataSetTitle = "emptyDataSetTitle";
static char const * const kEmptyDataSetTitleColor = "emptyDataSetImageColor";
static char const * const kEmptyDataSetDetail = "emptyDataSetDetail";
static char const * const kEmptyDataSetDetailColor = "emptyDataSetDetailColor";
static char const * const kEmptyDataSetButtonTitle = "emptyDataSetButtonTitle";
static char const * const kEmptyDataSetButtonTitleColor = "emptyDataSetButtonTitleColor";
static char const * const kEmptyDataSetButtonBackgroundColor = "emptyDataSetButtonBackgroundColor";
static char const * const kEmptyDataSetButtonBackgroundImage = "emptyDataSetButtonBackgroundImage";

@interface UIViewController (LZEmptyDataSet)<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@end

@implementation UIViewController (LZEmptyDataSet)

//MARK: - Public
//MARK: Setter/Getter
- (UIImage *)emptyDataSetImage {
    
    LZWeakObjectContainer *container = LZ_getAssociatedObject(self, kEmptyDataSetImage);
    
    return container.weakObject;
}

- (void)setEmptyDataSetImage:(UIImage *)emptyDataSetImage {
    
    LZ_setAssociatedObject(self, kEmptyDataSetImage, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetImage]);
}

- (NSString *)emptyDataSetTitle {
    
    LZWeakObjectContainer *container = LZ_getAssociatedObject(self, kEmptyDataSetTitle);
    
    return container.weakObject;
}

- (void)setEmptyDataSetTitle:(NSString *)emptyDataSetTitle {
    
    LZ_setAssociatedObject(self, kEmptyDataSetTitle, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetTitle]);
}

- (UIColor *)emptyDataSetTitleColor {
    
    LZWeakObjectContainer *container = LZ_getAssociatedObject(self, kEmptyDataSetTitleColor);
    
    return container.weakObject;
}

- (void)setEmptyDataSetTitleColor:(UIColor *)emptyDataSetTitleColor {
    
    LZ_setAssociatedObject(self, kEmptyDataSetTitleColor, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetTitleColor]);
}

- (NSString *)emptyDataSetDetail {
    
    LZWeakObjectContainer *container = LZ_getAssociatedObject(self, kEmptyDataSetDetail);
    
    return container.weakObject;
}

- (void)setEmptyDataSetDetail:(NSString *)emptyDataSetDetail {
    
    LZ_setAssociatedObject(self, kEmptyDataSetDetail, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetDetail]);
}

- (UIColor *)emptyDataSetDetailColor {
    
    LZWeakObjectContainer *container = LZ_getAssociatedObject(self, kEmptyDataSetDetailColor);
    
    return container.weakObject;
}

- (void)setEmptyDataSetDetailColor:(UIColor *)emptyDataSetDetailColor {
    
    LZ_setAssociatedObject(self, kEmptyDataSetDetailColor, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetDetailColor]);
}

- (NSString *)emptyDataSetButtonTitle {
    
    LZWeakObjectContainer *container = LZ_getAssociatedObject(self, kEmptyDataSetButtonTitle);
    
    return container.weakObject;
}

- (void)setEmptyDataSetButtonTitle:(NSString *)emptyDataSetButtonTitle {
    
    LZ_setAssociatedObject(self, kEmptyDataSetButtonTitle, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetButtonTitle]);
}

- (UIColor *)emptyDataSetButtonTitleColor {
    
    LZWeakObjectContainer *container = LZ_getAssociatedObject(self, kEmptyDataSetButtonTitleColor);
    
    return container.weakObject;
}

- (void)setEmptyDataSetButtonTitleColor:(UIColor *)emptyDataSetButtonTitleColor {
    
    LZ_setAssociatedObject(self, kEmptyDataSetButtonTitleColor, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetButtonTitleColor]);
}

- (NSString *)emptyDataSetButtonBackgroundColor {
    
    LZWeakObjectContainer *container = LZ_getAssociatedObject(self, kEmptyDataSetButtonBackgroundColor);
    
    return container.weakObject;
}

- (void)setEmptyDataSetButtonBackgroundColor:(NSString *)emptyDataSetButtonBackgroundColor {
    
    LZ_setAssociatedObject(self, kEmptyDataSetButtonBackgroundColor, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetButtonBackgroundColor]);
}

- (UIImage *)emptyDataSetButtonBackgroundImage {
    
    LZWeakObjectContainer *container = LZ_getAssociatedObject(self, kEmptyDataSetButtonBackgroundImage);
    
    return container.weakObject;
}

- (void)setEmptyDataSetButtonBackgroundImage:(UIImage *)emptyDataSetButtonBackgroundImage {
    
    LZ_setAssociatedObject(self, kEmptyDataSetButtonBackgroundImage, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetButtonBackgroundImage]);
}

//MARK: Method
- (void)showEmptyDataSet:(UIScrollView *)scrollView {
    
    scrollView.emptyDataSetSource = self;
    scrollView.emptyDataSetDelegate = self;
    [scrollView reloadEmptyDataSet];
}

- (void)hideEmptyDataSet:(UIScrollView *)scrollView {
    
    scrollView.emptyDataSetSource = nil;
    scrollView.emptyDataSetDelegate = nil;
}

//MARK: - Private
- (NSAttributedString *)emptyDataTitleAttribute:(NSString *)title {
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:[UIFont systemFontOfSize:15]
                   forKey:NSFontAttributeName];
    [attributes setObject:self.emptyDataSetTitleColor ? self.emptyDataSetTitleColor : [UIColor lightGrayColor]
                   forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:title
                                           attributes:attributes];
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
    
    return [[NSMutableAttributedString alloc] initWithString:detail
                                                  attributes:attributes];
}

- (NSAttributedString *)LZEmptyDataSetButtonTitleAttribute:(NSString *)title {
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:[UIFont systemFontOfSize:13]
                   forKey:NSFontAttributeName];
    [attributes setObject:self.emptyDataSetButtonTitleColor ? self.emptyDataSetButtonTitleColor : [UIColor whiteColor]
                   forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:title
                                           attributes:attributes];
}

//MARK: - DZNEmptyDataSet
//MARK: <DZNEmptyDataSetSource>
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
    
    if ([self respondsToSelector:@selector(emptyDataCustomView)]) {
        
        UIView *customView = [self emptyDataCustomView];
        NSAssert(nil != customView, @"自定义 View 不能为空");
        
        return customView;
    }
    
    return nil;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
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
    return NO;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView
          didTapView:(UIView *)view {
    
    if ([self respondsToSelector:@selector(emptyDidTapView)]) {
        [self emptyDidTapView];
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView
        didTapButton:(UIButton *)button {
    
    if ([self respondsToSelector:@selector(emptyDidTapButton)]) {
        [self emptyDidTapButton];
    }
}

@end
