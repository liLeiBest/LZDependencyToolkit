//
//  NSString+LZURL.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2018/9/17.
//

#import <Foundation/Foundation.h>

@interface NSString (LZURL)

/**
 拼接参数
 
 @param paraDict 字典
 @return NSString
 */
- (NSString * _Nonnull)urlByAppendingParameter:(NSDictionary * _Nonnull)paraDict;

/**
 拼接参数
 
 @param paraString 参数字符串 key=value
 @return NSString
 */
- (NSString * _Nonnull)urlByAppendingKeyAndValue:(NSString * _Nonnull)paraString;

@end
