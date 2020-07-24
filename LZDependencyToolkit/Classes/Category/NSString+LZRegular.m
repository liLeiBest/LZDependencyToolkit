//
//  NSString+LZRegular.m
//  Pods
//
//  Created by Dear.Q on 2017/6/6.
//
//

#import "NSString+LZRegular.h"

@implementation NSString (LZRegular)

/** 判断是有效的 String */
- (BOOL)isValidString {
    return nil != self && [self isKindOfClass:[NSString class]] && 0 < self.length;
}

/** 判断是有效的 URL 地址 */
- (BOOL)isValidURL {
    
    NSString *URLRegular = @"https?:[^\\s]*";
    return [self verifyRegular:URLRegular];
}

/** 判断是有效的 IP 地址 */
- (BOOL)isValidIP {
    
    NSString *IPRegular = @"^(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5]).(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5]).(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5]).(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])$";
    return [self verifyRegular:IPRegular];
}

/** 判断是有效的 Email 地址 */
- (BOOL)isValidEmail {
    
//    @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    @"\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}";
    NSString *emailRegular = @"^[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?$";
    return [self verifyRegular:emailRegular];
}

/** 判断是有效的国内手机号 */
- (BOOL)isValidMobilePhone {
    
    NSString *mobilePhoneRegular = @"^0?(13|14|15|16|17|18|19)[0-9]{9}$";
    return [self verifyRegular:mobilePhoneRegular];
}

/** 判断是有效的国内固定电话 */
- (BOOL)isValidFixedPhone {
    
    NSString *fixedPhoneRegular = @"^[0-9-()（）]{7,18}$";
    return [self verifyRegular:fixedPhoneRegular];
}

/** 判断是有效的邮政编码 */
- (BOOL)isValidPostalCode {
    
    NSString *postalCodeRegular = @"^[1-9]\\d{5}(?!\\d)$";
    return [self verifyRegular:postalCodeRegular];
}

/** 判断是有效的居民身份证 */
- (BOOL)isValidResidentIdentificationCard {
    
    NSString *identificationCardRegular = @"^(\\d{17}[\\d|x|X]|\\d{15})$";
    return [self verifyRegular:identificationCardRegular];
}

/** 判断是有效的腾讯 QQ */
- (BOOL)isValidTencentQQ {
    
    NSString *tencentQQRegular = @"^[1-9]([0-9]{4,10})$";
    return [self verifyRegular:tencentQQRegular];
}

/** 判断是有效的银行卡号 */
- (BOOL)isValidBankCard {
    
    NSString *bankCardRegular = @"^(\\d{15,30})";
    return [self verifyRegular:bankCardRegular];
}

/** 判断是有效的银行卡后四位 */
- (BOOL)isValidBankCardLastNumber {
    
    NSString *bankCardLastNumberRegular = @"^(\\d{4})";
    return [self verifyRegular:bankCardLastNumberRegular];
}

/** 判断是有效的银行卡 CVN */
- (BOOL)isValidBankCardCVNCode {
    
    NSString *bankCardCVNCodeRegular = @"^(\\d{3})";
    return [self verifyRegular:bankCardCVNCodeRegular];
}

/** 判断是有效的车牌号 */
- (BOOL)isValidCarNumber {
    
    NSString *carNumberRegular = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    return [self verifyRegular:carNumberRegular];
}

/** 判断是有效的车型 */
- (BOOL)isValidCarType {
    
    NSString *CarTypeRegular = @"^[\u4E00-\u9FFF]+$";
    return [self verifyRegular:CarTypeRegular];
}

/** 验证是否只是数字 */
- (BOOL)validateIsOnlyNumber {
    
    NSString *regular = @"^[0-9]*$";
    return [self verifyRegular:regular];
}

/** 验证只能输入 n 位的数字 */
- (BOOL)validateIsOnlyNumberMostWithFigure:(NSInteger)figure {
    
    NSString *regular = [NSString stringWithFormat:@"^\\d{%ld}$", (long)figure];
    return [self verifyRegular:regular];
}

/** 验证至少输入 n 位的数字 */
- (BOOL)validateIsOnlyNumberLeastWithFigure:(NSInteger)figure {
    
    NSString *regular = [NSString stringWithFormat:@"^\\d{%ld,}$", (long)figure];
    return [self verifyRegular:regular];
}

/** 验证只能输入 m~n 位的数字 */
- (BOOL)validateIsOnlyNumberFromFigure:(NSInteger)fromFigure
                              toFigure:(NSInteger)toFigure {
    
    NSString *regular = [NSString stringWithFormat:@"^\\d{%ld,%ld}$", (long)fromFigure, (long)toFigure];
    return [self verifyRegular:regular];
}

/** 验证浮点数只能输入最大或最小 N 位整数和小数，并且是否允许以 0 开头 */
- (BOOL)validateFloatNumberWithIntegerFigure:(NSInteger)integerFigure
                          integerMostOrLeast:(BOOL)integerMost
                               decimalFigure:(NSInteger)decimalFigure
                          decimalMostOrLeast:(BOOL)decimalMost
                               beginWithZero:(BOOL)zero {
    
    NSInteger maxFirstNumber = YES == zero ? 0 : 1;
    NSInteger maxInteger = integerFigure - 1;
    NSInteger minInteger = YES == integerMost ? 0 : maxInteger;
    NSInteger maxDecimal = decimalFigure;
    NSInteger minDecimal = YES == decimalMost ? 0 : maxDecimal;
    NSString *regular = [NSString stringWithFormat:@"^[%ld-9]\\d{%ld,%ld}+(\\.\\d{%ld,%ld})?$", maxFirstNumber, minInteger, maxInteger, minDecimal, maxDecimal];
    return [self verifyRegular:regular];
}

/** 验证是否包含有 ^%&',;=?$/"等字符 */
- (BOOL)validateIsSpecialCharacters {
    
    NSString *regular = @"^([~!/@#$%^&*()-_=+\\|[{}];:\'\",<.>/?]+)$";
    return [self verifyRegular:regular];
}

/** 验证字符串是否为中文 */
- (BOOL)validateIsChineseText {
    
    NSString *regular = @"^[\u4E00-\u9FA5]*$";
    return [self verifyRegular:regular];
}

/** 验证字符串是否为由 26 个英文字母组成的字符串 */
- (BOOL)validateIs26EnglishLetter {
    
    NSString *regular = @"^[A-Za-z]+$";
    return [self verifyRegular:regular];
}

/** 验证字符串是否为由26个英文字母的大写组成的字符串 */
- (BOOL)validateIs26CapitalEnglishLetter {
    
    NSString *regular = @"^[A-Z]+$";
    return [self verifyRegular:regular];
}

/** 验证字符串是否为由26个英文字母的小写组成的字符串 */
- (BOOL)validateIs26LowercaseEnglishLetter {
    
    NSString *regular = @"^[a-z]+$";
    return [self verifyRegular:regular];
}

/** 验证字符串是否为由26个不区分大小写的英文字母和汉字组成的字符串 */
- (BOOL)validateisEnglishLetterAndChineseText {
    
    NSString *regular = @"^[a-zA-Z_\u4e00-\u9fa5_/]+$";
    return [self verifyRegular:regular];
}

/** 验证字符串是否为由数字和26个英文字母组成的字符串 */
- (BOOL)validateIsNumbersAnd26EnglishLetter {
    
    NSString *regular = @"^[A-Za-z0-9]+$";
    return [self verifyRegular:regular];
}

/** 验证字符串是否为由数字、26个英文字母或者下划线组成的字符串 */
- (BOOL)validateIsNumbersAnd26EnglishLetterAndBottomLine {
    
    NSString *regular = @"^[0-9a-zA-Z_]{1,}$";
    return [self verifyRegular:regular];
}

/** 返回只包含字母、数字及汉字的字符串 */
- (BOOL)isContainOnlyLettersAndNumbersAndChineseCharacter:(NSString *__autoreleasing  _Nullable *)resultString {
    
    NSString *regex = @"^[a-zA-Z0-9_\u4e00-\u9fa5_/]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    BOOL isContainsSpecialCharacter = NO;
    NSString *temp = nil;
    NSString *string = self;
    for (int i = 0; i < [string length]; i++) {
        
        temp = [string substringWithRange:NSMakeRange(i, 1)];
        if ([predicate evaluateWithObject:temp]) {
            NSLog(@"%@ This character is OK", temp);
        } else {
            
            isContainsSpecialCharacter = YES;
            NSRange range = NSMakeRange(i, 1);
            string = [string stringByReplacingCharactersInRange:range withString:@" "];
        }
    }

    NSString *withoutEmojiString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    *resultString = withoutEmojiString;
    return isContainsSpecialCharacter;
}

#pragma mark - -> Private
/**
 验证正则表达式
 
 @param regularExpression 正则表达式
 @return BOOL
 */
- (BOOL)verifyRegular:(NSString *)regularExpression {
    
    if (self.length <= 0) return NO;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];;
    BOOL isValid = [predicate evaluateWithObject:self];
    return isValid;
}

// MARK: - Deprecated
- (BOOL)isValideString {
    return [self isValidString];
}

@end
