//
//  UIBarButtonItem+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 16/8/18.
//
//

#import "UIBarButtonItem+LZExtension.h"
#import "UIColor+LZExtension.h"

@implementation UIBarButtonItem (LZExtension)

#pragma mark - -> Public
/** 创建一个自定义导航按钮(标题、默认状态图片、高亮状态图片、代理、点击事件) */
#pragma clang push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (UIBarButtonItem *)initWithTitle:(NSString *)title
                         normalImg:(NSString *)normalImg
                      highlightImg:(NSString *)highlightImg
                            target:(id)target
                            action:(SEL)action
{
    // 实例
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置属性
    barButton.backgroundColor = [UIColor clearColor];
    barButton.adjustsImageWhenDisabled = NO;
    barButton.adjustsImageWhenHighlighted = NO;
    barButton.imageView.contentMode = UIViewContentModeLeft;
    
    if (nil != title && title.length)
    {
        // 设置 barButton 的文字显示
        [barButton setTitle:title forState:UIControlStateNormal];
        [barButton setTitle:title forState:UIControlStateHighlighted];
        
        // 获取 UIBarButtonItem 默认属性，iOS8 以前无效
        UIBarButtonItem *theme = [UIBarButtonItem appearance];
        NSDictionary *normalAttributes = [theme titleTextAttributesForState:UIControlStateNormal];
        NSDictionary *highlightAttributes = [theme titleTextAttributesForState:UIControlStateHighlighted];
        NSDictionary *disableAttributes = [theme titleTextAttributesForState:UIControlStateDisabled];
        
        // 设置 barButton 的默认状态
        if (nil != normalAttributes || normalAttributes.allKeys.count ? YES : NO)
        {
            NSAttributedString *normalAttributedString =
            [[NSAttributedString alloc] initWithString:title
                                            attributes:normalAttributes];
            [barButton setAttributedTitle:normalAttributedString
                                 forState:UIControlStateNormal];
        }
        else
        {
            barButton.titleLabel.font = [UIFont systemFontOfSize:16];
            [barButton setTitleColor:[UIColor colorWithHexString:@"#333333"]
                            forState:UIControlStateNormal];
            [barButton setTitleColor:[UIColor colorWithHexString:@"#333333"]
                            forState:UIControlStateHighlighted];
            [barButton setTitleColor:[UIColor colorWithHexString:@"#A8A8A8"]
                            forState:UIControlStateDisabled];
        }
        
        // 设置 barButton 的高亮状态
        if (nil != highlightAttributes || highlightAttributes.allKeys.count ? YES : NO)
        {
            NSAttributedString *hightlightAttributedString =
            [[NSAttributedString alloc] initWithString:title
                                            attributes:highlightAttributes];
            [barButton setAttributedTitle:hightlightAttributedString
                                 forState:UIControlStateHighlighted];
        }
        
        // 设置 barButton 的不可用状态
        if (nil != disableAttributes || highlightAttributes.allKeys.count ? YES : NO)
        {
            NSAttributedString *disableAttributedString =
            [[NSAttributedString alloc] initWithString:title
                                            attributes:disableAttributes];
            [barButton setAttributedTitle:disableAttributedString
                                 forState:UIControlStateDisabled];
        }
        
        // 设置 barButton 的图标
        if (nil != normalImg && normalImg.length)
        {
            [barButton setImage:[self img:normalImg]
                       forState:UIControlStateNormal];
            [barButton setImage:[self img:highlightImg]
                       forState:UIControlStateHighlighted];
        }
    }
    else
    {
        if (nil != normalImg && normalImg.length)
        {
            [barButton setBackgroundImage:[self img:normalImg]
                                 forState:UIControlStateNormal];
            [barButton setBackgroundImage:[self img:highlightImg]
                                 forState:UIControlStateHighlighted];
        }
    }
    
    // 设置Frame
    if (nil != barButton.currentImage || nil != barButton.currentTitle)
    {
        barButton.frame = (CGRect){{0,0},barButton.currentImage.size};
        
        if (nil != barButton.currentTitle)
        {
            CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:barButton.titleLabel.font}];
            CGRect oldFrame = barButton.frame;
            oldFrame.size.width = titleSize.width + barButton.currentImage.size.width;
            if (0 == oldFrame.size.height) oldFrame.size.height = titleSize.height;
            oldFrame.size.height = 28;
            barButton.frame = oldFrame;
        }
    }
    
    if (nil != barButton.currentBackgroundImage)
    {
        barButton.frame = (CGRect){{0,0},barButton.currentBackgroundImage.size};
    }
    
    // 微调
//    barButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -2);
//    barButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 2);
    
    // 设置点击事件
    [barButton addTarget:target
                  action:action
        forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}
#pragma clang pop

/** 创建一个自定义导航按钮(标题、默认状态图片、高亮状态图片、代理、点击事件) */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                        noralImage:(NSString *)normalImage
                  highlightedImage:(NSString *)highlightedImage
                            target:(id)target
                            action:(SEL)action
{
    return [[self alloc] initWithTitle:title
                             normalImg:normalImage
                          highlightImg:highlightedImage
                                target:target
                                action:action];
}

/** 创建一个自定义导航按钮(标题、代理、点击事件) */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                            target:(id)target
                            action:(SEL)action
{
    return [[self alloc] initWithTitle:title
                             normalImg:nil
                          highlightImg:nil
                                target:target
                                action:action];
}

#pragma mark - -> Private
/**
 @author Lilei
 
 @brief 实例 Image

 @param imgNameOrPath 文件名或路径
 @return UIImage
 */
- (UIImage *)img:(NSString *)imgNameOrPath
{
    UIImage *image = [UIImage imageNamed:imgNameOrPath];
    if (nil == image) image = [UIImage imageWithContentsOfFile:imgNameOrPath];
    
    return image;
}

@end

@implementation UINavigationItem (LZExtension)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
        negativeSeperator.width = -10;
        if (_leftBarButtonItem)
        {
            [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
        }
        else
        {
            [self setLeftBarButtonItems:@[negativeSeperator]];
        }
    }
    else
    {
        [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
    }
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
        CGFloat minitrim = -12;
        if (_rightBarButtonItem.title.length > 2) minitrim = 0;
        negativeSeperator.width = minitrim;
        if (_rightBarButtonItem)
        {
            [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
        }
        else
        {
            [self setRightBarButtonItems:@[negativeSeperator]];
        }
    }
    else
    {
        [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
    }
}
#endif

@end
