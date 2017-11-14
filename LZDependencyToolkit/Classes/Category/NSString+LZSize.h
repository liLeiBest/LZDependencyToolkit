//
//  NSString+LZSize.h
//  Pods
//
//  Created by Dear.Q on 2017/6/6.
//
//

#import <Foundation/Foundation.h>

@interface NSString (LZSize)

/**
 @author Lilei
 
 @brief 根据文本的属性及内容，计算文本所占的宽、高
 
 @param attributes 文本属性
 @param maxSize 最大尺寸
 @return 实际尺寸
 */
- (CGSize)sizeWithAttributes:(NSDictionary *)attributes
                     maxSize:(CGSize)maxSize;

/**
 @author Lilei
 
 @brief 根据文本的字体及内容，计算文本所占宽、高
 
 @param font 字体
 @param maxSize 最大尺寸
 @return 实际尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font
               maxSize:(CGSize)maxSize;

@end
