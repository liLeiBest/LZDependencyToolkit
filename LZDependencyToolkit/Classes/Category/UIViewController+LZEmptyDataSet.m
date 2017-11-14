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
#import <objc/runtime.h>

@interface LZWeakObjectContainer : NSObject
@property (nonatomic, readonly, strong) id weakObject;

- (instancetype)initWithWeakObject:(id)object;
@end

@implementation LZWeakObjectContainer

- (instancetype)initWithWeakObject:(id)object
{
    if (self = [super init])
    {
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

@interface UIViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@end

@implementation UIViewController (LZEmptyDataSet)

- (UIImage *)emptyDataSetImage
{
    LZWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetImage);
    return container.weakObject;
}

- (void)setEmptyDataSetImage:(UIImage *)emptyDataSetImage
{
    objc_setAssociatedObject(self, kEmptyDataSetImage, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetImage], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)emptyDataSetTitle
{
    LZWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetTitle);
    return container.weakObject;
}

- (void)setEmptyDataSetTitle:(NSString *)emptyDataSetTitle
{
    objc_setAssociatedObject(self, kEmptyDataSetTitle, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetTitle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)emptyDataSetTitleColor
{
    LZWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetTitleColor);
    return container.weakObject;
}

- (void)setEmptyDataSetTitleColor:(UIColor *)emptyDataSetTitleColor
{
    objc_setAssociatedObject(self, kEmptyDataSetTitleColor, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetTitleColor], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)emptyDataSetDetail
{
    LZWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetDetail);
    return container.weakObject;
}

- (void)setEmptyDataSetDetail:(NSString *)emptyDataSetDetail
{
    objc_setAssociatedObject(self, kEmptyDataSetDetail, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetDetail], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)emptyDataSetDetailColor
{
    LZWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetDetailColor);
    return container.weakObject;
}

- (void)setEmptyDataSetDetailColor:(UIColor *)emptyDataSetDetailColor
{
    objc_setAssociatedObject(self, kEmptyDataSetDetailColor, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetDetailColor], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)emptyDataSetButtonTitle
{
    LZWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetButtonTitle);
    return container.weakObject;
}

- (void)setEmptyDataSetButtonTitle:(NSString *)emptyDataSetButtonTitle
{
    objc_setAssociatedObject(self, kEmptyDataSetButtonTitle, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetButtonTitle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)emptyDataSetButtonTitleColor
{
    LZWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetButtonTitleColor);
    return container.weakObject;
}

- (void)setEmptyDataSetButtonTitleColor:(UIColor *)emptyDataSetButtonTitleColor
{
    objc_setAssociatedObject(self, kEmptyDataSetButtonTitleColor, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetButtonTitleColor], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)emptyDataSetButtonBackgroundColor
{
    LZWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetButtonBackgroundColor);
    return container.weakObject;
}

- (void)setEmptyDataSetButtonBackgroundColor:(NSString *)emptyDataSetButtonBackgroundColor
{
    objc_setAssociatedObject(self, kEmptyDataSetButtonBackgroundColor, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetButtonBackgroundColor], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)emptyDataSetButtonBackgroundImage
{
    LZWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetButtonBackgroundImage);
    return container.weakObject;
}

- (void)setEmptyDataSetButtonBackgroundImage:(UIImage *)emptyDataSetButtonBackgroundImage
{
    objc_setAssociatedObject(self, kEmptyDataSetButtonBackgroundImage, [[LZWeakObjectContainer alloc] initWithWeakObject:emptyDataSetButtonBackgroundImage], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/** 设置空白页 */
- (void)showEmptyDataSet:(UIScrollView *)scrollView
{
    scrollView.emptyDataSetSource = self;
    scrollView.emptyDataSetDelegate = self;
    [scrollView reloadEmptyDataSet];
}

- (void)hideEmptyDataSet:(UIScrollView *)scrollView
{
    scrollView.emptyDataSetSource = nil;
    scrollView.emptyDataSetDelegate = nil;
}

- (NSAttributedString *)LZEmptyDataSetTitleAttribute:(NSString *)title
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:[UIFont systemFontOfSize:15]
                   forKey:NSFontAttributeName];
    [attributes setObject:self.emptyDataSetTitleColor ? self.emptyDataSetTitleColor : [UIColor lightGrayColor]
                   forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:title
                                           attributes:attributes];
}

- (NSAttributedString *)LZEmptyDataSetDetailAttribute:(NSString *)detail
{
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

- (NSAttributedString *)LZEmptyDataSetButtonTitleAttribute:(NSString *)title
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:[UIFont systemFontOfSize:13]
                   forKey:NSFontAttributeName];
    [attributes setObject:self.emptyDataSetButtonTitleColor ? self.emptyDataSetButtonTitleColor : [UIColor whiteColor]
                   forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:title
                                           attributes:attributes];
}

#pragma mark - DZNEmptyDataSet
#pragma mark <DZNEmptyDataSetSource>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyDataSetImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (nil != self.emptyDataSetTitle && self.emptyDataSetTitle.length)
    {        
        return [self LZEmptyDataSetTitleAttribute:self.emptyDataSetTitle];
    }
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (nil != self.emptyDataSetDetail && self.emptyDataSetDetail.length)
    {
        return [self LZEmptyDataSetDetailAttribute:self.emptyDataSetDetail];
    }
    return nil;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (nil != self.emptyDataSetButtonTitle && self.emptyDataSetButtonTitle.length)
    {
        return [self LZEmptyDataSetButtonTitleAttribute:self.emptyDataSetButtonTitle];
    }
    return nil;
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (nil != self.emptyDataSetButtonBackgroundImage)
    {
        return self.emptyDataSetButtonBackgroundImage;
    }
    
    if (nil != self.emptyDataSetButtonBackgroundColor && self.emptyDataSetButtonBackgroundColor.length)
    {
        return [UIImage imageWithColor:[UIColor colorWithHexString:self.emptyDataSetButtonBackgroundColor]
                                  size:CGSizeMake(100, 100)];
    }
    
    return nil;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor clearColor];
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self respondsToSelector:@selector(emptyDataCustomView)])
    {
        UIView *customView = [self emptyDataCustomView];
        
        NSAssert(nil != customView, @"自定义 View 不能为空");
        
        return customView;
    }
    return nil;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{    
    return -scrollView.contentOffset.y * 0.5;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0.0;
}

#pragma mark <DZNEmptyDataSetDelegate>
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if ([self respondsToSelector:@selector(emptyDidTapView)])
    {
        [self emptyDidTapView];
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    if ([self respondsToSelector:@selector(emptyDidTapButton)])
    {
        [self emptyDidTapButton];
    }
}

@end
