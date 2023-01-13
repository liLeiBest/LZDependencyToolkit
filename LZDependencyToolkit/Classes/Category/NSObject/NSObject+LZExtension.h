//
//  NSObject+LZExtension.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2020/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LZExtension)

/// 判断是否为空对象
- (BOOL)isNullObj;

/// 判断是否为空
/// @attention NSString/NSArray/NSDictionary/NSSet
- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
