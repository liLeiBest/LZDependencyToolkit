//
//  UIScrollView+LZRefreshControl.h
//  Pods
//
//  Created by Dear.Q on 16/8/18.
//
//

#import <UIKit/UIKit.h>

/** 进入刷新状态的回调 */
typedef void (^LZRefreshingBlock)(void);

@interface UIScrollView (LZRefreshControl)

/**
 @author Lilei
 
 @brief 是否正在刷新
 
 @return YES: 刷新中;NO:其它
 */
- (BOOL)isRefreshing;

/**
 @author Lilei
 
 @brief 开始下拉刷新
 */
- (void)beginHeaderRefresh;

/**
 @author Lilei
 
 @brief 结束下拉刷新
 */
- (void)endHeaderRefresh;

/**
 @author Lilei
 
 @brief 开始上拉加载
 */
- (void)beginFooterRefresh;

/**
 @author Lilei
 
 @brief 结束上拉加载
 */
- (void)endFooterRefresh;

/**
 @author Lilei
 
 @brief 隐藏下拉刷新
 */
- (void)hideHeader;

/**
 @author Lilei
 
 @brief 显示下拉刷新
 */
- (void)showHeader;

/**
 @author Lilei
 
 @brief 隐藏上拉加载
 */
- (void)hideFooter;

/**
 @author Lilei
 
 @brief 显示上拉加载
 */
- (void)showFooter;

/**
 @author Lilei
 
 @brief 结束上拉加载，并提示没有更多
 */
- (void)endFooterRefreshingWithNoMoreData;

/**
 @author Lilei
 
 @brief 重置没有更多提示
 */
- (void)resetFooterNoMoreData;

/**
 @author Lilei
 
 @brief 当没有数据时，隐藏上拉刷新
 @remark 暂未实现，现等同于 - (void)hideFooter
 */
- (void)setupHideFooterNoData;

/**
 @author Lilei
 
 @brief 添加下拉刷新
 
 @param refreshingBlock LZRefreshingBlock
 */
- (void)headerWithRefreshingBlock:(LZRefreshingBlock)refreshingBlock;

/**
 @author Lilei
 
 @brief 添加下拉刷新
 
 @param target Target
 @param action Action
 */
- (void)headerWithRefreshingTarget:(id)target
				  refreshingAction:(SEL)action;

/**
 @author Lilei
 
 @brief 添加上拉加载
 
 @param refreshingBlock LZRefreshingBlock
 */
- (void)footerWithRefreshingBlock:(LZRefreshingBlock)refreshingBlock;

/**
 @author Lilei
 
 @brief 添加上拉加载
 
 @param target Target
 @param action Action
 */
- (void)footerWithRefreshingTarget:(id)target
				  refreshingAction:(SEL)action;
/**
 @author Lilei
 
 @brief 移除下拉刷新
 */
- (void)removeHeader;

/**
 @author Lilei
 
 @brief 移除上拉加载
 */
- (void)removeFooter;

/**
 @author Lilei
 
 @brief 获取TableView或Collection的单元数
 
 @return NSInteger
 */
- (NSInteger)totalDataCount;

@end
