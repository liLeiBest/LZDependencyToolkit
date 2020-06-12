//
//  UIButton+LZEventInterval.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2020/2/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// UIButton 与 RAC  冲突，所以改为 UIControl
@interface UIControl (LZEventInterval)

/// 事件响应的间隔时间
@property (nonatomic, assign) NSTimeInterval eventInterval;

@end

NS_ASSUME_NONNULL_END
