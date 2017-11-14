//
//  UIView+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import <UIKit/UIKit.h>

@interface UIView (LZFrame)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property(nonatomic,assign) CGPoint orgin;
@property (nonatomic, assign) CGSize size;
@property(nonatomic, readonly) CGPoint midPoint;
@property(nonatomic, readonly) CGFloat midX;
@property(nonatomic, readonly) CGFloat midY;

@end

@interface UIView (LZViewController)

/**
 @author Lilei
 
 @brief 获取当前视图所在的控制器
 
 @return UIViewController
 */
- (UIViewController *)viewController;

@end
