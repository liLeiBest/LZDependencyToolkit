//
//  NSString+LZPinYin.h
//  Pods
//
//  Created by Dear.Q on 16/8/9.
//
//

#import <Foundation/Foundation.h>

@interface NSString (LZPinYin)

/** 拼音字符串，中间以空格隔开 */
@property (nonatomic, copy, readonly) NSString *fullPinyin;
/** 拼音字符串，中间无空格隔开 */
@property (nonatomic, copy, readonly) NSString *pinyinString;
/** 拼音首字母 */
@property (nonatomic, copy, readonly) NSString *pinyinFirstLetter;

@end

@interface NSArray (LZPinYin)


/**
 @author Lilei
 
 @brief 使用指定 key 的属性对数组进行排序
 
 @param chineseKey key
 
 @return NSArray
 */
- (NSArray *)sortedArrayUsingChineseKey:(NSString *)chineseKey;

@end
