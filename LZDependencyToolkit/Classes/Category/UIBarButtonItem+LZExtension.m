//
//  UIBarButtonItem+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 16/8/18.
//
//

#import "UIBarButtonItem+LZExtension.h"
#import <CoreGraphics/CGGeometry.h>
#import "NSObject+LZRuntime.h"
#import "UIColor+LZExtension.h"
#import "UIImage+LZClipping.h"

@implementation UIBarButtonItem (LZExtension)

//MARK: - runtime
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = @selector(setTitleTextAttributes:forState:);
        SEL swizzleSelector = @selector(LZ_setTitleTextAttributes:forState:);
        LZ_exchangeInstanceMethod(self, originSelector, swizzleSelector);
    });
}

- (void)LZ_setTitleTextAttributes:(NSDictionary<NSString *,id> *)attributes forState:(UIControlState)state {
    
    UIView *customView = self.customView;
    if (customView) {
        
        if ([customView isKindOfClass:[UIButton class]]) {
            UIButton *tempBtn = (UIButton *)customView;
            if (nil == tempBtn.currentTitle && 0 == tempBtn.currentTitle.length) {
                return;
            }
            NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:tempBtn.currentTitle
                                                                                attributes:attributes];
            [tempBtn setAttributedTitle:attributedStr forState:state];
        }
    } else {
        [super setTitleTextAttributes:attributes forState:state];
    }
}

//MARK: - Getter/Setter
- (BOOL)isHidden {
    return self.customView.isHidden;
}

- (void)setHidden:(BOOL)hidden {
    self.customView.hidden = hidden;
}

//MARK: - Public
/** 创建一个自定义导航按钮(标题、默认状态图片、高亮状态图片、代理、点击事件) */
#pragma clang push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (UIBarButtonItem *)initWithTitle:(NSString *)title
                         normalImg:(NSObject *)normalImg
                      highlightImg:(NSObject *)highlightImg
                        disableImg:(NSObject *)disableImg
                            target:(id)target
                            action:(SEL)action {
        
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.opaque = YES;
    barButton.backgroundColor = [UIColor clearColor];
    barButton.adjustsImageWhenDisabled = nil == disableImg ? YES : NO;
    barButton.adjustsImageWhenHighlighted = NO;
    barButton.imageView.contentMode = UIViewContentModeLeft;
    
    if (nil != title && title.length) {
        
        [barButton setTitle:title forState:UIControlStateNormal];
        [barButton setTitle:title forState:UIControlStateHighlighted];
        [barButton setTitle:title forState:UIControlStateDisabled];
        UIBarButtonItem *theme = [UIBarButtonItem appearance];
        NSDictionary *normalAttributes = [theme titleTextAttributesForState:UIControlStateNormal];
        NSDictionary *highlightAttributes = [theme titleTextAttributesForState:UIControlStateHighlighted];
        NSDictionary *disableAttributes = [theme titleTextAttributesForState:UIControlStateDisabled];
        if (nil != normalAttributes || normalAttributes.allKeys.count ? YES : NO) {
            
            NSAttributedString *normalAttributedString =
            [[NSAttributedString alloc] initWithString:title
                                            attributes:normalAttributes];
            [barButton setAttributedTitle:normalAttributedString
                                 forState:UIControlStateNormal];
        } else {
            
        }
        if (nil != highlightAttributes || highlightAttributes.allKeys.count ? YES : NO) {
            
            NSAttributedString *hightlightAttributedString =
            [[NSAttributedString alloc] initWithString:title
                                            attributes:highlightAttributes];
            [barButton setAttributedTitle:hightlightAttributedString
                                 forState:UIControlStateHighlighted];
        }
        if (nil != disableAttributes || highlightAttributes.allKeys.count ? YES : NO) {
            
            NSAttributedString *disableAttributedString =
            [[NSAttributedString alloc] initWithString:title
                                            attributes:disableAttributes];
            [barButton setAttributedTitle:disableAttributedString
                                 forState:UIControlStateDisabled];
        }
        if (nil == normalAttributes && nil == highlightAttributes && nil == disableAttributes) {
            
            barButton.titleLabel.font = [UIFont systemFontOfSize:16];
            [barButton setTitleColor:LZColorWithHexString(@"#333333")
                            forState:UIControlStateNormal];
            [barButton setTitleColor:LZColorWithHexString(@"#333333")
                            forState:UIControlStateHighlighted];
            [barButton setTitleColor:LZColorWithHexString(@"#A8A8A8")
                            forState:UIControlStateDisabled];
        }
        if (nil != normalImg) {
            
            [barButton setImage:[self img:normalImg] forState:UIControlStateNormal];
            [barButton setImage:[self img:highlightImg] forState:UIControlStateHighlighted];
            [barButton setImage:[self img:disableImg] forState:UIControlStateDisabled];
        }
    } else {
        if (nil != normalImg) {
            
            [barButton setBackgroundImage:[self img:normalImg] forState:UIControlStateNormal];
            [barButton setBackgroundImage:[self img:highlightImg] forState:UIControlStateHighlighted];
            [barButton setBackgroundImage:[self img:disableImg] forState:UIControlStateDisabled];
        }
    }
    if (nil != barButton.currentImage || nil != barButton.currentTitle) {
        
        barButton.frame = (CGRect){{0,0},barButton.currentImage.size};
        if (nil != barButton.currentTitle) {
            
            CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:barButton.titleLabel.font}];
            CGRect oldFrame = barButton.frame;
            oldFrame.size.width = titleSize.width + barButton.currentImage.size.width;
            if (0 == oldFrame.size.height) oldFrame.size.height = titleSize.height;
            oldFrame.size.height = titleSize.height > oldFrame.size.height ? titleSize.height : oldFrame.size.height;
            barButton.frame = oldFrame;
        }
    }
    if (nil != barButton.currentBackgroundImage) {
        barButton.frame = (CGRect){{0,0},barButton.currentBackgroundImage.size};
    }
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    barBtnItem.target = target;
    barBtnItem.action = action;

    return barBtnItem;
}
#pragma clang pop

/** 创建一个自定义导航按钮(标题、默认状态图片、高亮状态图片、代理、点击事件) */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                       normalImage:(NSString *)normalImage
                    highlightImage:(NSString *)highlightImage
                      disableImage:(NSString *)disableImage
                            target:(id)target
                            action:(SEL)action {
    return [[self alloc] initWithTitle:title
                             normalImg:normalImage
                          highlightImg:highlightImage
                            disableImg:disableImage
                                target:target
                                action:action];
}

/** 创建一个自定义导航按钮(标题、代理、点击事件) */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                            target:(id)target
                            action:(SEL)action {
    return [[self alloc] initWithTitle:title
                             normalImg:nil
                          highlightImg:nil
                            disableImg:nil
                                target:target
                                action:action];
}

//MARK: - Private
/**
 @author Lilei
 
 @brief 实例 Image
 
 @param imgNameOrPath 文件名或路径
 @return UIImage
 */
- (UIImage *)img:(NSObject *)imgNameOrPath {
    
    if (nil == imgNameOrPath || !([imgNameOrPath isKindOfClass:[UIImage class]] || [imgNameOrPath isKindOfClass:[NSString class]])) {
        return nil;
    }
    
    UIImage *image = nil;
    if ([imgNameOrPath isKindOfClass:[UIImage class]]) {
        image = (UIImage *)imgNameOrPath;
    }
    if ([imgNameOrPath isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:(NSString *)imgNameOrPath];
        if (nil == image) {
            image = [UIImage imageWithContentsOfFile:(NSString *)imgNameOrPath];
        }
    }
    
    if (image.size.width > 48) {
        image = [image scaledToSize:CGSizeMake(48, 48)];
    }
    return image;
}

@end

@implementation UINavigationItem (LZExtension)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1 && __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_11_0
- (UIBarButtonItem *)leftBarButtonItem {
    
    __block UIBarButtonItem *leftItem = nil;
    [self.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.target respondsToSelector:obj.action]) {
            
            leftItem = obj;
            *stop = YES;
        }
    }];
    
    return leftItem;
}

- (UIBarButtonItem *)rightBarButtonItem {
    
    __block UIBarButtonItem *rightItem = nil;
    [self.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.target respondsToSelector:obj.action]) {
            
            rightItem = obj;
            *stop = YES;
        }
    }];
    
    return rightItem;
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem {
    
    if (nil == _leftBarButtonItem || nil != self.leftBarButtonItem) {
        [self setLeftBarButtonItems:nil];
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0 &&
        nil != _leftBarButtonItem.customView) {
        
        UIBarButtonItem *negativeSeperator = [self fixedSpaceItem];
        if (_leftBarButtonItem) {
            [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
        } else {
            [self setLeftBarButtonItems:@[negativeSeperator]];
        }
    } else {
        [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
    }
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem {
    
    if (nil == _rightBarButtonItem || nil != self.rightBarButtonItem) {
        [self setRightBarButtonItems:nil];
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0 &&
        nil != _rightBarButtonItem.customView) {
        
        UIBarButtonItem *negativeSeperator = [self fixedSpaceItem];
        if (_rightBarButtonItem) {
            [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
        } else {
            [self setRightBarButtonItems:@[negativeSeperator]];
        }
    } else {
        [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
    }
}

- (void)setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)_leftBarButtonItems {
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        
        UIBarButtonItem *negativeSeperator = [self fixedSpaceItem];
        if (_leftBarButtonItems && 0 < _leftBarButtonItems.count) {
            
            UIBarButtonItem *tempBarBtnItem = [_leftBarButtonItems firstObject];
            if (tempBarBtnItem.customView) {
                
                NSMutableArray *tempArrM = [NSMutableArray arrayWithObject:negativeSeperator];
                [tempArrM addObjectsFromArray:_leftBarButtonItems];
                [self setLeftBarButtonItems:[tempArrM copy]];
            } else {
                [self setLeftBarButtonItems:_leftBarButtonItems animated:NO];
            }
        } else {
            [self setLeftBarButtonItems:@[negativeSeperator]];
        }
    } else {
        [self setLeftBarButtonItems:_leftBarButtonItems animated:NO];
    }
}

- (void)setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)_rightBarButtonItems {
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        
        UIBarButtonItem *negativeSeperator = [self fixedSpaceItem];
        if (_rightBarButtonItems && 0 < _rightBarButtonItems.count) {
            
            UIBarButtonItem *tempBarBtnItem = [_rightBarButtonItems firstObject];
            if (tempBarBtnItem.customView) {
                
                NSMutableArray *tempArrM = [NSMutableArray arrayWithObject:negativeSeperator];
                [tempArrM addObjectsFromArray:_rightBarButtonItems];
                [self setRightBarButtonItems:[tempArrM copy]];
            } else {
                [self setRightBarButtonItems:_rightBarButtonItems animated:NO];
            }
        } else {
            [self setRightBarButtonItems:@[negativeSeperator]];
        }
    } else {
        [self setRightBarButtonItems:_rightBarButtonItems animated:NO];
    }
}

//MARK: - Private
- (UIBarButtonItem *)fixedSpaceItem {
    
    UIBarButtonItem *seperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    seperator.width = -7;
    
    return seperator;
}
#endif
@end
