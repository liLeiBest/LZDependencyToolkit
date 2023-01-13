//
//  UIButton+LZExtendTouchRect.h
//  Pods
//
//  Created by Dear.Q on 16/8/15.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (LZExtendTouchRect)

/**
 自定义响应边界
 @code UIEdgeInsetsMake(top, left, bottom, right)
 - 负数表示扩大
 - 正数表示缩小
 */
@property (nonatomic, assign) UIEdgeInsets hitEdgeInsets;

/**
 自定义响应范围扩大倍数
 @code self.hitScale = 3.0;
 */
@property(nonatomic, assign) CGFloat hitScale;

/**
 自定义响应范围的宽度扩倍数
 @code self.hitWidthScale = 3.0;
 */
@property(nonatomic, assign) CGFloat hitWidthScale;

/**
 自定义响应范围的高度扩倍数
 @code self.hitHeightScale = 3.0;
 */
@property(nonatomic, assign) CGFloat hitHeightScale;

@end
