//
//  NSString+LZFormat.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2021/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LZFormat)

/// 密文手机号
- (NSString *)ciphertextPhone;

/// 密文姓名
- (NSString *)ciphertextFullName;

@end

NS_ASSUME_NONNULL_END
