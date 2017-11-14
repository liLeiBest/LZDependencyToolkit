//
//  NSString+LZEmoji.m
//  Pods
//
//  Created by Dear.Q on 2017/6/6.
//
//

#import "NSString+LZEmoji.h"

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (LZEmoji)

+ (NSString *)emojiWithIntCode:(int)intCode {
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

- (NSString *)emoji
{
    const char *charCode = self.UTF8String;
    int intCode = (int)strtol(charCode, NULL, 16);
    
    return [NSString emojiWithIntCode:intCode];
}

/** 判断是否包含 Emoji */
- (BOOL)isContainsEmoji
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring,
                                       NSRange substringRange,
                                       NSRange enclosingRange,
                                       BOOL *stop)
    {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff)
        {
            if (substring.length > 1)
            {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if ((0x1d000 <= uc && uc <= 0x1f77f) || (0x1F900 <= uc && uc <= 0x1f9ff))
                {
                    returnValue = YES;
                }
            }
        }
        else if (substring.length > 1)
        {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3)
            {
                returnValue = YES;
            }
        }
        else
        {
            if (0x2100 <= hs && hs <= 0x27ff)
            {
                returnValue = YES;
            }
            else if (0x2B05 <= hs && hs <= 0x2b07)
            {
                returnValue = YES;
            }
            else if (0x2934 <= hs && hs <= 0x2935)
            {
                returnValue = YES;
            }
            else if (0x3297 <= hs && hs <= 0x3299)
            {
                returnValue = YES;
            }
            else if (hs == 0xa9 ||
                     hs == 0xae ||
                     hs == 0x303d ||
                     hs == 0x3030 ||
                     hs == 0x2b55 ||
                     hs == 0x2b1c ||
                     hs == 0x2b1b ||
                     hs == 0x2b50)
            {
                returnValue = YES;
            }
            else if (hs == 0x200d)
            {
                returnValue = YES;
            }
        }
    }];
    
    return returnValue;
}


@end
