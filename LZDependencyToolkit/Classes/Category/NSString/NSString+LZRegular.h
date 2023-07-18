//
//  NSString+LZRegular.h
//  Pods
//
//  Created by Dear.Q on 2017/6/6.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LZRegular)

/**
 @author Lilei
 
 @brief 判断是有效的 String
 
 @return BOOL
 */
- (BOOL)isValidString;

/**
 @author Lilei
 
 @brief 判断全是空格 String
 
 @return BOOL
 */
- (BOOL)isWhitespaceString;

/**
 @author Lilei
 
 @brief 判断是有效的 URL 地址

 @return BOOL
 */
- (BOOL)isValidURL;

/**  */
/**
 @author Lilei
 
 @brief 提取 URL 地址

 @return NSArray
 */
- (NSArray * _Nullable)extractURLs;

/**
 @author Lilei
 
 @brief 判断是有效的 IP 地址
 
 @return BOOL
 */
- (BOOL)isValidIP;

/**
 @author Lilei
 
 @brief 判断是有效的 Email 地址

 @return BOOL
 */
- (BOOL)isValidEmail;

/**
 @author Lilei
 
 @brief 判断是有效的国内手机号
 
 @return BOOL
 */
- (BOOL)isValidMobilePhone;

/**
 @author Lilei
 
 @brief 判断是有效的国内固定电话
 
 @return BOOL
 */
- (BOOL)isValidFixedPhone;

/**
 @author Lilei
 
 @brief 判断是有效的邮政编码
 
 @return BOOL
 */
- (BOOL)isValidPostalCode;

/**
 @author Lilei
 
 @brief 判断是有效的居民身份证

 @return BOOL
 */
- (BOOL)isValidResidentIdentificationCard;

/**
 @author Lilei
 
 @brief 判断是有效的腾讯 QQ

 @return BOOL
 */
- (BOOL)isValidTencentQQ;

/**
 @author Lilei
 
 @brief 判断是有效的银行卡号
 
 @return BOOL
 */
- (BOOL)isValidBankCard;

/**
 @author Lilei
 
 @brief 判断是有效的银行卡后四位
 
 @return BOOL
 */
- (BOOL)isValidBankCardLastNumber;

/**
 @author Lilei
 
 @brief 判断是有效的银行卡 CVN
 
 @return BOOL
 */
- (BOOL)isValidBankCardCVNCode;

/**
 @author Lilei
 
 @brief 判断是有效的车牌号
 
 @return BOOL
 */
- (BOOL)isValidCarNumber;

/**
 @author Lilei
 
 @brief 判断是有效的车型
 
 @return BOOL
 */
- (BOOL)isValidCarType;

/**
 @author Lilei
 
 @brief 验证是否只是数字
 
 @return BOOL
 */
- (BOOL)validateIsOnlyNumber;

/**
 @author Lilei
 
 @brief 验证只能输入 n 位的数字
 
 @param figure 最大的位数
 @return BOOL
 */
- (BOOL)validateIsOnlyNumberMostWithFigure:(NSInteger)figure;

/**
 @author Lilei
 
 @brief 验证至少输入 n 位的数字
 
 @param figure 最小的位数
 @return BOOL
 */
- (BOOL)validateIsOnlyNumberLeastWithFigure:(NSInteger)figure;

/**
 @author Lilei
 
 @brief 验证只能输入 m~n 位的数字
 
 @param fromFigure 最小的位数
 @param toFigure 最大的位数
 @return BOOL
 */
- (BOOL)validateIsOnlyNumberFromFigure:(NSInteger)fromFigure
                              toFigure:(NSInteger)toFigure;

/**
 @author Lilei
 
 @brief 验证浮点数只能输入最大或最小 N 位整数和小数，并且是否允许以 0 开头
 
 @param integerFigure 最大整数的位数
 @param decimalFigure 最大小数的位数
 @return BOOL
 */
- (BOOL)validateFloatNumberWithIntegerFigure:(NSInteger)integerFigure
                          integerMostOrLeast:(BOOL)integerMost
                               decimalFigure:(NSInteger)decimalFigure
                          decimalMostOrLeast:(BOOL)decimalMost
                               beginWithZero:(BOOL)zero;

/**
 @author Lilei
 
 @brief 验证是否包含有 ^%&',;=?$/"等字符
 
 @return BOOL
 */
- (BOOL)validateIsSpecialCharacters;

/**
 @author Lilei
 
 @brief 验证字符串是否为中文
 
 @return BOOL
 */
- (BOOL)validateIsChineseText;

/**
 @author Lilei
 
 @brief 验证字符串是否为由 26 个英文字母组成的字符串
 
 @return BOOL
 */
- (BOOL)validateIs26EnglishLetter;

/**
 @author Lilei
 
 @brief 验证字符串是否为由26个英文字母的大写组成的字符串
 
 @return BOOL
 */
- (BOOL)validateIs26CapitalEnglishLetter;

/**
 @author Lilei
 
 @brief 验证字符串是否为由26个英文字母的小写组成的字符串
 
 @return BOOL
 */
- (BOOL)validateIs26LowercaseEnglishLetter;

/**
 @author Lilei
 
 @return 验证字符串是否为由26个不区分大小写的英文字母和汉字组成的字符串
 */
- (BOOL)validateisEnglishLetterAndChineseText;

/**
 @author Lilei
 
 @brief 验证字符串是否为由数字和26个英文字母组成的字符串
 
 @return BOOL
 */
- (BOOL)validateIsNumbersAnd26EnglishLetter;

/**
 @author Lilei
 
 @brief 验证字符串是否为由数字、26个英文字母或者下划线组成的字符串
 
 @return BOOL
 */
- (BOOL)validateIsNumbersAnd26EnglishLetterAndBottomLine;

/**
 @author Lilei

 @brief 判断是否只包含字母、数字及汉字

 @param resultString 只包含字母、数字及汉字的字符
 @return BOOL
 */
- (BOOL)isContainOnlyLettersAndNumbersAndChineseCharacter:(NSString  * _Nullable __autoreleasing * _Nullable)resultString;

/// 提取符合规则的内容
/// @param regularExpression 正则表达式
- (NSArray *)extractRegular:(NSString *)regularExpression;

// MARK: - Deprecated
- (BOOL)isValideString DEPRECATED_MSG_ATTRIBUTE("请使用 isValidString 替代");

@end

NS_ASSUME_NONNULL_END
