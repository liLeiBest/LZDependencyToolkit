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

 @remark 不能为空
 @return UIView
 */
- (UIView *)emptyDataCustomView;

@end

@interface UIViewController (LZEmptyDataSet)<LZEmptyDataSetDelegate>

/** 图标 */
@property (nonatomic, weak) UIImage *emptyDataSetImage;
/** 标题 */
@property (nonatomic, weak) NSString *emptyDataSetTitle;
/** 标题颜色 */
@property (nonatomic, weak) UIColor *emptyDataSetTitleColor;
/** 描述 */
@property (nonatomic, weak) NSString *emptyDataSetDetail;
/** 描述颜色 */
@property (nonatomic, weak) UIColor *emptyDataSetDetailColor;
/** 按钮标题 */
@property (nonatomic, weak) NSString *emptyDataSetButtonTitle;
/** 按钮标题颜色 */
@property (nonatomic, weak) UIColor *emptyDataSetButtonTitleColor;
/** 按钮背景颜色 */
@property (nonatomic, weak) NSString *emptyDataSetButtonBackgroundColor;
/** 按钮背景图片 */
@property (nonatomic, weak) UIImage *emptyDataSetButtonBackgroundImage;


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
