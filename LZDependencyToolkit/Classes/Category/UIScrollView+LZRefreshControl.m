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

@interface LZWeakRefreshObjectContainer : NSObject

@property (nonatomic, readonly, strong) id weakObject;

/** 构造方法 */
- (instancetype)initWithWeakObject:(id)object;

@end

@implementation LZWeakRefreshObjectContainer

- (instancetype)initWithWeakObject:(id)object {
    
    if (self = [super init]) {
        _weakObject = object;
    }
    return self;
}

@end

static char const * const kLZRefreshNoMoreDataTitle = "lz_refreshNoMoreDataTitle";
static char const * const kLZRefreshTextAttributes = "lz_refreshTextAttributes";
static NSDictionary *RefreshTextAttributes = nil;
static NSString *RefreshNoMoreTitle = @"已经没有更多了";
@implementation UIScrollView (LZRefreshControl)

- (NSString *)noMoreDataTitle {
    
    LZWeakRefreshObjectContainer *container = LZ_getAssociatedObject(self, kLZRefreshNoMoreDataTitle);
    return container.weakObject;
}

- (void)setNoMoreDataTitle:(NSString *)noMoreDataTitle {
    LZ_setAssociatedObject(self, kLZRefreshNoMoreDataTitle, [[LZWeakRefreshObjectContainer alloc] initWithWeakObject:noMoreDataTitle]);
}

- (NSDictionary *)textAttributes {
    
    LZWeakRefreshObjectContainer *container = LZ_getAssociatedObject(self, kLZRefreshTextAttributes);
    return container.weakObject;
}

- (void)setTextAttributes:(NSDictionary *)textAttributes {
    LZ_setAssociatedObject(self, kLZRefreshTextAttributes, [[LZWeakRefreshObjectContainer alloc] initWithWeakObject:textAttributes]);
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
    NSString *title = self.noMoreDataTitle ?: RefreshNoMoreTitle;
	[footer setTitle:title forState:MJRefreshStateNoMoreData];
    
    NSDictionary *textArrs = self.textAttributes ?: RefreshTextAttributes;
    if (nil != textArrs) {
        footer.stateLabel.textColor = textArrs[NSForegroundColorAttributeName];
    }
	self.mj_footer = footer;
}

- (void)footerWithRefreshingTarget:(id)target
				  refreshingAction:(SEL)action {
	
	MJRefreshAutoNormalFooter *footer =
	[MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
	[footer setTitle:@"" forState:MJRefreshStateIdle];
    NSString *title = self.noMoreDataTitle ?: RefreshNoMoreTitle;
	[footer setTitle:title forState:MJRefreshStateNoMoreData];
	NSDictionary *textArrs = self.textAttributes ?: RefreshTextAttributes;
    if (nil != textArrs) {
        footer.stateLabel.textColor = textArrs[NSForegroundColorAttributeName];
    }
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
