//
//  UIViewController+LZEmptyDataSet.h
//  Pods
//
//  Created by Dear.Q on 16/8/18.
//
//

#import <UIKit/UIKit.h>

@protocol LZEmptyDataSetDelegate <NSObject>

@optional

/**
 @author Lilei
 
 @brief 图片点击事件
 */
- (void)emptyDidTapView;

/**
 @author Lilei
 
 @brief 按钮点击事件
 */
- (void)emptyDidTapButton;

/**
 @author Lilei
 
 @brief 自定空白页视图

 @attention 不能为空
 @return UIView
 */
- (UIView *)emptyDataCustomView;

/**
@author Lilei

@brief 指定空白页偏移量，默认 0

@attention 负：向上；正向下
@return CGFloat
*/
- (CGFloat)verticalOffsetForEmptyDataSet;

@end

@interface UIViewController (LZEmptyDataSet)<LZEmptyDataSetDelegate>

/** 图标 */
@property (nonatomic, strong) UIImage *emptyDataSetImage;
/** 标题 */
@property (nonatomic, copy) NSString *emptyDataSetTitle;
/** 标题颜色 */
@property (nonatomic, strong) UIColor *emptyDataSetTitleColor;
/** 描述 */
@property (nonatomic, copy) NSString *emptyDataSetDetail;
/** 描述颜色 */
@property (nonatomic, strong) UIColor *emptyDataSetDetailColor;
/** 按钮标题 */
@property (nonatomic, copy) NSString *emptyDataSetButtonTitle;
/** 按钮标题颜色 */
@property (nonatomic, strong) UIColor *emptyDataSetButtonTitleColor;
/** 按钮背景颜色 */
@property (nonatomic, copy) NSString *emptyDataSetButtonBackgroundColor;
/** 按钮背景图片 */
@property (nonatomic, strong) UIImage *emptyDataSetButtonBackgroundImage;
/** 垂直偏移量 */
@property (nonatomic, strong) NSNumber *emptyDataSetVerticalOff;


/**
 @author Lilei
 
 @brief 设置空白页
 
 @param scrollView UIScrollView
 */
- (void)showEmptyDataSet:(UIScrollView *)scrollView;

/**
 @author Lilei
 
 @brief 显示空白页
 
 @param scrollView UIScrollView
 */
- (void)hideEmptyDataSet:(UIScrollView *)scrollView;

@end
