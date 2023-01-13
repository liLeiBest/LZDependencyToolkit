//
//  UIScrollView+LZRefreshControl.m
//  Pods
//
//  Created by Dear.Q on 16/8/18.
//
//

#import "UIScrollView+LZRefreshControl.h"
#import "NSObject+LZRuntime.h"
#import "MJRefresh.h"

static NSDictionary *RefreshTextAttributes = nil;
static NSString *RefreshNoMoreTitle = @"已经没有更多了";
@implementation UIScrollView (LZRefreshControl)

- (NSString *)noMoreDataTitle {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setNoMoreDataTitle:(NSString *)noMoreDataTitle {
    LZ_setAssociatedCopyObject(self, @selector(noMoreDataTitle), noMoreDataTitle);
}

- (NSDictionary *)textAttributes {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setTextAttributes:(NSDictionary *)textAttributes {
    LZ_setAssociatedObject(self, @selector(textAttributes), textAttributes);
}

- (void (^)(void))headerRefreshingCallback {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setHeaderRefreshingCallback:(void (^)(void))headerRefreshingCallback {
    LZ_setAssociatedCopyObject(self, @selector(headerRefreshingCallback), headerRefreshingCallback);
}

- (void (^)(void))footerRefreshingCallback {
    return LZ_getAssociatedObject(self, _cmd);
}

- (void)setFooterRefreshingCallback:(void (^)(void))footerRefreshingCallback {
    LZ_setAssociatedCopyObject(self, @selector(footerRefreshingCallback), footerRefreshingCallback);
}

+ (void)configTextAttibutes:(NSDictionary *)attributes {
    RefreshTextAttributes = attributes;
}

+ (void)configNoMoreDataTitle:(NSString *)noMoreDataTitle {
    RefreshNoMoreTitle = noMoreDataTitle;
}

- (BOOL)isHeaderRefreshing {
    return [self.mj_header isRefreshing];
}

- (BOOL)isFooterRefreshing {
    return [self.mj_footer isRefreshing];
}

- (BOOL)isRefreshing {
    return [self isHeaderRefreshing] || [self isFooterRefreshing];
}

- (void)beginHeaderRefresh {
    if (self.mj_footer.state == MJRefreshStateNoMoreData) {
        [self.mj_footer resetNoMoreData];
    }
    [self.mj_header beginRefreshing];
}

- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
}

- (void)endHeaderRefreshComplete:(void (^)(void))completeHandler {
    [self.mj_header endRefreshingWithCompletionBlock:completeHandler];
}

- (void)beginFooterRefresh {
    [self.mj_footer beginRefreshing];
}

- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}

- (void)endFooterRefreshComplete:(void (^)(void))completeHandler {
    [self.mj_footer endRefreshingWithCompletionBlock:completeHandler];
}

- (void)hideHeader {
    [self.mj_header setHidden:YES];
}

- (void)showHeader {
    [self.mj_header setHidden:NO];
}

- (void)hideFooter {
    [self.mj_footer setHidden:YES];
}

- (void)showFooter {
    [self.mj_footer setHidden:NO];
}

- (void)endFooterRefreshingWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetFooterNoMoreData {
    [self.mj_footer resetNoMoreData];
}

- (void)setupHideFooterNoData {
    if ([self totalDataCount]) {
        self.mj_footer.hidden = NO;
    } else {
        self.mj_footer.hidden = YES;
    }
}

- (void)headerWithRefreshingBlock:(LZRefreshingBlock)refreshingBlock {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.mj_footer.state == MJRefreshStateNoMoreData) {
            [self.mj_footer resetNoMoreData];
        }
        if (self.headerRefreshingCallback) {
            self.headerRefreshingCallback();
        }
        if (refreshingBlock) {
            refreshingBlock();
        }
    }];
    NSDictionary *textArrs = self.textAttributes ?: RefreshTextAttributes;
    if (nil != textArrs) {
        
        header.stateLabel.textColor = textArrs[NSForegroundColorAttributeName];
        header.lastUpdatedTimeLabel.textColor = textArrs[NSForegroundColorAttributeName];
    }
    self.mj_header = header;
}

- (void)headerWithRefreshingTarget:(id)target
                  refreshingAction:(SEL)action {
    MJRefreshNormalHeader *header =
    [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    header.refreshingBlock = ^{
        if (self.mj_footer.state == MJRefreshStateNoMoreData) {
            [self.mj_footer resetNoMoreData];
        }
        if (self.headerRefreshingCallback) {
            self.headerRefreshingCallback();
        }
    };
    NSDictionary *textArrs = self.textAttributes ?: RefreshTextAttributes;
    if (nil != textArrs) {
        
        header.stateLabel.textColor = textArrs[NSForegroundColorAttributeName];
        header.lastUpdatedTimeLabel.textColor = textArrs[NSForegroundColorAttributeName];
    }
    self.mj_header = header;
}

- (void)footerWithRefreshingBlock:(LZRefreshingBlock)refreshingBlock {
    
    MJRefreshAutoNormalFooter *footer =
    [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshingBlock];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    NSDictionary *textArrs = self.textAttributes ?: RefreshTextAttributes;
    if (nil != textArrs) {
        footer.stateLabel.textColor = textArrs[NSForegroundColorAttributeName];
    }
    __weak typeof(footer) weakFooter = footer;
    __weak typeof(self) weakSelf = self;
    footer.refreshingBlock = ^{
        if ([weakSelf totalDataCount]) {
            
            NSString *title = weakSelf.noMoreDataTitle ?: RefreshNoMoreTitle;
            [weakFooter setTitle:title forState:MJRefreshStateNoMoreData];
        } else {
            [weakFooter setTitle:@"" forState:MJRefreshStateNoMoreData];
        }
        if (self.footerRefreshingCallback) {
            self.footerRefreshingCallback();
        }
    };
    self.mj_footer = footer;
}

- (void)footerWithRefreshingTarget:(id)target
                  refreshingAction:(SEL)action {
    
    MJRefreshAutoNormalFooter *footer =
    [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    NSDictionary *textArrs = self.textAttributes ?: RefreshTextAttributes;
    if (nil != textArrs) {
        footer.stateLabel.textColor = textArrs[NSForegroundColorAttributeName];
    }
    __weak typeof(footer) weakFooter = footer;
    footer.refreshingBlock = ^{
        if ([self totalDataCount]) {
            
            NSString *title = self.noMoreDataTitle ?: RefreshNoMoreTitle;
            [weakFooter setTitle:title forState:MJRefreshStateNoMoreData];
        } else {
            [weakFooter setTitle:@"" forState:MJRefreshStateNoMoreData];
        }
        if (self.footerRefreshingCallback) {
            self.footerRefreshingCallback();
        }
    };
    self.mj_footer = footer;
}

- (void)removeHeader {
    [self.mj_header removeFromSuperview];
}

- (void)removeFooter {
    [self.mj_footer removeFromSuperview];
}

- (NSInteger)totalDataCount {
    
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

@end
