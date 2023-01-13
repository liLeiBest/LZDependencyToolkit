//
//  UIScrollView+LZRegisterReuseView.m
//  LZDependent_toolkit
//
//  Created by Dear.Q on 2018/9/12.
//

#import "UIScrollView+LZRegisterReuseView.h"
#import "NSBundle+LZExtension.h"

@implementation UIScrollView (LZRegisterReuseView)

// MARK: - Public
/** 注册复用的 cellClass */
- (void)registerCellClass:(Class)cellClass
	  withReuseIdentifier:(NSString *)identifier {
	
	SEL selector = nil;
	if ([self isTableView]) {
		selector = @selector(registerClass:forCellReuseIdentifier:);
	} else if ([self isCollectionView]) {
		selector = @selector(registerClass:forCellWithReuseIdentifier:);
	}
	if ([self respondsToSelector:selector]) {
		[self invocationSelector:selector parameters:@[cellClass, identifier]];
	}
}

/** 注册复用的 cellNib */
- (void)registerCellNib:(NSString *)cellNib
	withReuseIdentifier:(NSString *)identifier
			   inBundle:(NSString *)bundle
		 referenceClass:(NSString *)className {
	
	UINib *nib = [NSBundle nib:cellNib inBundle:bundle referenceClass:className];
	SEL selector = nil;
	if ([self isTableView]) {
		selector = @selector(registerNib:forCellReuseIdentifier:);
	} else if ([self isCollectionView]) {
		selector = @selector(registerNib:forCellWithReuseIdentifier:);
	}
	if ([self respondsToSelector:selector]) {
		[self invocationSelector:selector parameters:@[nib, identifier]];
	}
}

/** 注册复用的 headerClass */
- (void)registerHeaderClass:(Class)headerClass
		withReuseIdentifier:(NSString *)identifier {
	
	if ([self isTableView]) {
		
		SEL selector = @selector(registerClass:forHeaderFooterViewReuseIdentifier:);
		if ([self respondsToSelector:selector]) {
			[self invocationSelector:selector parameters:@[headerClass, identifier]];
		}
	} else if ([self isCollectionView]) {
		
		SEL selector = @selector(registerClass:forSupplementaryViewOfKind:withReuseIdentifier:);
		if ([self respondsToSelector:selector]) {
			[self invocationSelector:selector parameters:@[headerClass, UICollectionElementKindSectionHeader, identifier]];
		}
	}
}

/** 注册复用的 HeaderNib */
- (void)registerHeaderNib:(NSString *)headerNib
	  withReuseIdentifier:(NSString *)identifier
				 inBundle:(NSString *)bundle
		   referenceClass:(NSString *)className {
	
	UINib *nib = [NSBundle nib:headerNib inBundle:bundle referenceClass:className];
	if ([self isTableView]) {
		
		SEL selector = @selector(registerNib:forHeaderFooterViewReuseIdentifier:);
		if ([self respondsToSelector:selector]) {
			[self invocationSelector:selector parameters:@[nib, identifier]];
		}
	} else if ([self isCollectionView]) {
		
		SEL selector = @selector(registerNib:forSupplementaryViewOfKind:withReuseIdentifier:);
		if ([self respondsToSelector:selector]) {
			[self invocationSelector:selector parameters:@[nib, UICollectionElementKindSectionHeader, identifier]];
		}
	}
}

/** 注册复用的 footerClass */
- (void)registerFooterClass:(Class)footerClass
		withReuseIdentifier:(NSString *)identifier {
	
	if ([self isTableView]) {
		
		SEL selector = @selector(registerClass:forHeaderFooterViewReuseIdentifier:);
		if ([self respondsToSelector:selector]) {
			[self invocationSelector:selector parameters:@[footerClass, identifier]];
		}
	} else if ([self isCollectionView]) {
		
		SEL selector = @selector(registerClass:forSupplementaryViewOfKind:withReuseIdentifier:);
		if ([self respondsToSelector:selector]) {
			[self invocationSelector:selector parameters:@[footerClass, UICollectionElementKindSectionFooter, identifier]];
		}
	}
}

/** 注册复用的 footerNib */
- (void)registerFooterNib:(NSString *)footerNib
	  withReuseIdentifier:(NSString *)identifier
				 inBundle:(NSString *)bundle
		   referenceClass:(NSString *)className {
	
	UINib *nib = [NSBundle nib:footerNib inBundle:bundle referenceClass:className];
	if ([self isTableView]) {
		
		SEL selector = @selector(registerNib:forHeaderFooterViewReuseIdentifier:);
		if ([self respondsToSelector:selector]) {
			[self invocationSelector:selector parameters:@[nib, identifier]];
		}
	} else if ([self isCollectionView]) {
		
		SEL selector = @selector(registerNib:forSupplementaryViewOfKind:withReuseIdentifier:);
		if ([self respondsToSelector:selector]) {
			[self invocationSelector:selector parameters:@[nib, UICollectionElementKindSectionFooter, identifier]];
		}
	}
}

// MAKR: - Private
- (BOOL)isTableView {
	return [self isKindOfClass:[UITableView class]];
}

- (BOOL)isCollectionView {
	return [self isKindOfClass:[UICollectionView class]];
}

- (void)invocationSelector:(SEL)selector
				parameters:(NSArray *)parameters {
	
	NSMethodSignature *methodSignature = [self methodSignatureForSelector:selector];
	if (nil != methodSignature) {
		
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
		[invocation setTarget:self];
		[invocation setSelector:selector];
		
		NSUInteger baseArgumentCount = 2;
		NSUInteger realArgumentCount = methodSignature.numberOfArguments - baseArgumentCount;
		NSUInteger formalArgumentCount = parameters.count;
		NSUInteger argumentCount = MIN(realArgumentCount, formalArgumentCount);
		for (NSUInteger i = 0; i < argumentCount; i++) {
			
			NSObject *obj = parameters[i];
			if ([obj isKindOfClass:[NSNull class]]) {
				obj = nil;
			}
			[invocation setArgument:&obj atIndex:i + baseArgumentCount];
		}
		[invocation retainArguments];
		[invocation invoke];
	} else {
		NSLog(@"注册失败:Target:%@ SEL:%@", NSStringFromClass([self class]), NSStringFromSelector(selector));
	}
}

@end
