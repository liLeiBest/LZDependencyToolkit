//
//  UIView+LZInputView.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LZInputView)

/**
配置输入框的最大输入长度

@param limitLength NSUInteger
@param textContent NSString
*/
- (void)configLimitLength:(NSUInteger)limitLength
              textContent:(nullable NSString *)textContent;

/**
配置输入框的最大输入长度

@param limitLength NSUInteger
@param textContent NSString
@param handler 监听回调
*/
- (void)configLimitLength:(NSUInteger)limitLength
              textContent:(nullable NSString *)textContent
            changeHandler:(nullable void (^)(BOOL marked))handler;

/**
配置输入框的最大输入长度

@param limitLength NSUInteger
@param textContent NSString
@param handler 监听回调
*/
- (void)limitLength:(NSUInteger)limitLength
               text:(nullable NSString *)textContent
            handler:(nullable void (^)(BOOL marked, BOOL overflow))handler;

@end

NS_ASSUME_NONNULL_END
