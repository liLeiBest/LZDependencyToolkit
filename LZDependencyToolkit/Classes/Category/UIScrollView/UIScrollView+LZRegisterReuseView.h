//
//  UIScrollView+LZRegisterReuseView.h
//  LZDependent_toolkit
//
//  Created by Dear.Q on 2018/9/12.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LZRegisterReuseView)

/**
 @author Lilei
 
 @brief 注册复用的 cellClass
 
 @param cellClass Class
 @param identifier 复用标识
 */
- (void)registerCellClass:(nonnull Class)cellClass
	  withReuseIdentifier:(nonnull NSString *)identifier;

/**
 @author Lilei
 
 @brief 注册复用的 cellNib

 @param cellNib Nib 名称
 @param identifier 复用标识
 @param bundle 资源目录
 @param className 参数类名
 */
- (void)registerCellNib:(nonnull NSString *)cellNib
	withReuseIdentifier:(nonnull NSString *)identifier
			   inBundle:(nullable NSString *)bundle
		 referenceClass:(nullable NSString *)className;

/**
 @author Lilei
 
 @brief 注册复用的 headerClass
 
 @param headerClass Class
 @param identifier 复用标识
 */
- (void)registerHeaderClass:(nonnull Class)headerClass
		withReuseIdentifier:(nonnull NSString *)identifier;

/**
 @author Lilei
 
 @brief 注册复用的 HeaderNib
 
 @param headerNib Nib 名称
 @param identifier 复用标识
 @param bundle 资源目录
 @param className 参数类名
 */
- (void)registerHeaderNib:(nonnull NSString *)headerNib
	  withReuseIdentifier:(nonnull NSString *)identifier
				 inBundle:(nullable NSString *)bundle
		   referenceClass:(nullable NSString *)className;

/**
 @author Lilei
 
 @brief 注册复用的 footerClass
 
 @param footerClass Class
 @param identifier 复用标识
 */
- (void)registerFooterClass:(nonnull Class)footerClass
		withReuseIdentifier:(nonnull NSString *)identifier;

/**
 @author Lilei
 
 @brief 注册复用的 footerNib
 
 @param footerNib Nib 名称
 @param identifier 复用标识
 @param bundle 资源目录
 @param className 参数类名
 */
- (void)registerFooterNib:(nonnull NSString *)footerNib
	  withReuseIdentifier:(nonnull NSString *)identifier
				 inBundle:(nullable NSString *)bundle
		   referenceClass:(nullable NSString *)className;

@end
