//
//  UIButton+LZEventInterval.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2020/2/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LZEventInterval)

// 事件响应的间隔时间
@property (nonatomic, assign) NSTimeInterval eventInterval;

@end

NS_ASSUME_NONNULL_END
