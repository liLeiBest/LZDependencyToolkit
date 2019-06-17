//
//  LZQuickUnit.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/16.
//

#ifndef LZQuickUnit_h
#define LZQuickUnit_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

struct LZQuickUnit_type {
	
	// MARK: - Format
	/**
	 角度获取弧度
	 */
	CGFloat (* toRadian)(CGFloat degree);
	
	/**
	 弧度获取角度
	 */
	CGFloat (* toDegree)(CGFloat radian);
	
	/**
	 数字转字符串， NSNumber/NSDiction/NSArray
	 */
	NSString * (* toString)(id object);
	
	// MARK: - Path
	/**
	 缓存目录
	 */
	NSString * (* cacheDir)(void);
	
	/**
	 文档目录
	 */
	NSString * (* documentDir)(void);
	
	/**
	 特定目录
	 */
	NSString * (* searchDir)(NSSearchPathDirectory searchPathDir);
	
	/**
	 创建目录
	 */
	BOOL (* createDir)(NSString *dirPath);
	
	/**
	 创建缓存子目录
	 */
	BOOL (* createCacheSubDir)(NSString *subPath);
	
	/**
	 创建文档子目录
	 */
	BOOL (* createDocumentSubDir)(NSString *subPath);
	
	// MARK: - Font
	/**
	 已安装的字体名称
	 */
	NSArray * (* installedFontNames)(void);
	
	/**
	 根据大小返回系统字体
	 */
	UIFont * (* font)(CGFloat fontSize);
	
	/**
	 根据名称和大小返回指定字体
	 */
	UIFont * (* fontName)(NSString *fontName, CGFloat fontSize);
	
	// MARK: -
	/**
	 强提示
	 */
	void (* alert)(NSString *title, NSString *mssage, NSArray<UIAlertAction *> *actions);
	
	/**
	 通知中心
	 */
	NSNotificationCenter * (* notificationCenter)(void);
	
	/**
	 添加通知监听，返回值被系统持有，为了能够通过 removeObserver: 移除监听，调用者也并且持有。
	 */
	id <NSObject>  (* notificationObserver)(NSNotificationName name, void (^callBackHandler)(NSNotification *note));
	
	/**
	 添加通知监听
	 */
	void (* notificationAdd)(id observer, SEL selector, NSNotificationName name);
	
	/**
	 发送通知
	 */
	void (* notificationPost)(NSNotificationName name, id anyObject, NSDictionary *userInfo);
	
	/**
	 移除通知监听
	 */
	void (* notificationRemove)(id observer, NSNotificationName name);
};

FOUNDATION_EXTERN struct LZQuickUnit_type LZQuickUnit;

#endif /* LZQuickUnit_h */
