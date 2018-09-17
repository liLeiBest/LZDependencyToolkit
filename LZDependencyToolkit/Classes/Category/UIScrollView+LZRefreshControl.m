//
//  UIScrollView+LZRefreshControl.m
//  Pods
//
//  Created by Dear.Q on 16/8/18.
//
//

#import "UIScrollView+LZRefreshControl.h"
#import "MJRefresh.h"

@implementation UIScrollView (LZRefreshControl)

- (BOOL)isRefreshing {
	return [self.mj_header isRefreshing];
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

- (void)beginFooterRefresh {
	[self.mj_footer beginRefreshing];
}

- (void)endFooterRefresh {
	[self.mj_footer endRefreshing];
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
		
		if (refreshingBlock) {
			refreshingBlock();
		}
	}];
	
	self.mj_header = header;
}

- (void)headerWithRefreshingTarget:(id)target
				  refreshingAction:(SEL)action {
	MJRefreshNormalHeader *header =
	[MJRefreshNormalHeader headerWithRefreshingTarget:target
									 refreshingAction:action];
	header.refreshingBlock = ^{
		
		if (self.mj_footer.state == MJRefreshStateNoMoreData) {
			[self.mj_footer resetNoMoreData];
		}
	};
	self.mj_header = header;
}

- (void)footerWithRefreshingBlock:(LZRefreshingBlock)refreshingBlock {
	
	MJRefreshAutoNormalFooter *footer =
	[MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshingBlock];
	[footer setTitle:@"" forState:MJRefreshStateIdle];
	[footer setTitle:@"已经没有更多了" forState:MJRefreshStateNoMoreData];
	self.mj_footer = footer;
}

- (void)footerWithRefreshingTarget:(id)target
				  refreshingAction:(SEL)action {
	
	MJRefreshAutoNormalFooter *footer =
	[MJRefreshAutoNormalFooter footerWithRefreshingTarget:target
										 refreshingAction:action];
	[footer setTitle:@"" forState:MJRefreshStateIdle];
	[footer setTitle:@"已经没有更多了" forState:MJRefreshStateNoMoreData];
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
