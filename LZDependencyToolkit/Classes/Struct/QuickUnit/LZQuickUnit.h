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
	
	// MARK: - Font
	/**
	 已安装的字体名称
	 */
	NSArray * (* installedFontNames)(void);
	
	/**
	 根据大小返回系统常规字体
	 */
	UIFont * (* font)(CGFloat fontSize);
	
	/**
	 根据大小返回系统加粗字体
	 */
	UIFont * (* boldFont)(CGFloat fontSize);
	
	/**
	 根据大小返回系统斜体字体
	 */
	UIFont * (* italicFont)(CGFloat fontSize);
	
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_2
	/**
	 根据大小及 UIFontWeight 返回系统字体
	 */
	UIFont * (* fontWeight)(CGFloat fontSize, UIFontWeight weight);
#endif
	/**
	 根据名称和大小返回指定字体
	 */
	UIFont * (* fontName)(NSString *fontName, CGFloat fontSize);
	
	// MARK: - Alert
	/**
	 Alert 提示
	 */
	void (* alert)(NSString *title, NSString *message, NSArray<UIAlertAction *> *actions);
    
    /**
     Sheet 提示
     */
    void (* sheet)(NSString *title, NSString *message, NSArray<UIAlertAction *> *actions);
	
    // MARK: Notification
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
