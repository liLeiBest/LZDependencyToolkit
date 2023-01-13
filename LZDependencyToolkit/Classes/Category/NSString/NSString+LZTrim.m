//
//  NSString+LZTrim.m
//  Pods
//
//  Created by Dear.Q on 2017/6/6.
//
//

#import "NSString+LZTrim.h"

@implementation NSString (LZTrim)

#pragma mark - -> Public
/** 截去左侧特殊字符 */
- (NSString *)trimmingLeftCharactersInSet:(NSCharacterSet *)characterSet
{
    // 获取字符数据
    NSUInteger length = [self length];
    if (length == 0) return @"";
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    // 获取左边第一个非特定字符的位置
    NSUInteger location = 0;
    while ([characterSet characterIsMember:charBuffer[location]]) location ++;
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

/** 截去右侧特殊字符 */
- (NSString *)trimmingRightCharactersInSet:(NSCharacterSet *)characterSet
{
    // 获取字符数据
    NSUInteger length = [self length];
    if (length == 0) return @"";
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    // 获取右边第一个非特定字符的长度 length - 1：数组下标从 0 开始
    while ([characterSet characterIsMember:charBuffer[length - 1]]) length --;
    
    return [self substringWithRange:NSMakeRange(0, length)];
}

/** 截去两侧的控制字符集 */
- (NSString *)trimmingControlCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet controlCharacterSet]];
}

/** 截去两侧的空白符 */
- (NSString *)trimmingWhitespaceCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
}

/** 截去所有的空白符 */
- (NSString *)trimmingAllWhitespace
{
	NSRange range = {0, self.length};
	return [self stringByReplacingOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
}

/** 截去两侧换行符 */
- (NSString *)trimmingNewlineCharacterSet
{
	return [self trimmingCharacterSet:[NSCharacterSet newlineCharacterSet]];
}

/** 截去所有换行符 */
- (NSString *)trimmingAllNewline
{
	NSRange range = {0, self.length};
	return [self stringByReplacingOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range];
}

/** 截去两侧的空格和换行符 */
- (NSString *)trimmingWhitespaceAndNewlineCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/** 截去所有的空格、换行符 */
- (NSString *)trimmingAllWhitespaceAndNewline
{
	NSString *tmpString = [self trimmingAllWhitespace];
	tmpString = [tmpString trimmingAllNewline];
	return tmpString;
}

/** 截去十进制数字，即阿拉伯数字 */
- (NSString *)trimmingDecimalDigitCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
}

/** 截去两侧的汉字和字母 */
- (NSString *)trimmingLetterCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet letterCharacterSet]];
}

/** 截去两侧的小写字母 */
- (NSString *)trimmingLowercaseLetterCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet lowercaseLetterCharacterSet]];
}

/** 截去两侧的大写字母 */
- (NSString *)trimmingUppercaseLetterCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet uppercaseLetterCharacterSet]];
}

/** 截去两侧的非基本字符集 */
- (NSString *)trimmingNonBaseCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet nonBaseCharacterSet]];
}

/** 截去两侧的汉字、字母、数字 */
- (NSString *)trimmingAlphanumericCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
}

/** 截去两侧的可分解字符集 */
- (NSString *)trimmingDecomposableCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet decomposableCharacterSet]];
}

/** 截去两侧的非法字符集 */
- (NSString *)trimmingIllegalCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet illegalCharacterSet]];
}

/** 截去两侧的标点符号 */
- (NSString *)trimmingPunctuationCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet punctuationCharacterSet]];
}

/** 截去两侧首字母大写的字符集 */
- (NSString *)trimmingCapitalizedLetterCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet capitalizedLetterCharacterSet]];
}

/** 截去两侧符号字符集 */
- (NSString *)trimmingSymbolCharacterSet
{
    return [self trimmingCharacterSet:[NSCharacterSet symbolCharacterSet]];
}

#pragma mark - -> Private
- (NSString *)trimmingCharacterSet:(NSCharacterSet *)characterSet
{
    if (nil != self && self.length) return [self stringByTrimmingCharactersInSet:characterSet];
    
    return @"";
}

#pragma mark - -> Deprecated
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet
{
    return [self trimmingLeftCharactersInSet:characterSet];
}

- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet
{
    return [self trimmingRightCharactersInSet:characterSet];
}

+ (NSString *)trimWhitespaceAndNewline:(NSString *)val
{
    [val trimmingCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [val trimmingCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
