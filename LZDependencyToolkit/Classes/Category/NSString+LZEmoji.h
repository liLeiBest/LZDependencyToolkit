//
//  NSString+LZEmoji.h
//  Pods
//
//  Created by Dear.Q on 2017/6/6.
//
//

#import <Foundation/Foundation.h>

@interface NSString (LZEmoji)

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
- (NSString *)emoji;

/**
 @author Lilei
 
 @brief 判断是否包含 Emoji

 @return BOOL
 */
- (BOOL)isContainsEmoji;

@end
