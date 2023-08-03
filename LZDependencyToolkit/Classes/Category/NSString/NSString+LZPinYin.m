//
//  NSString+LZPinYin.m
//  Pods
//
//  Created by Dear.Q on 16/8/9.
//
//

#import "NSString+LZPinYin.h"
#import "NSString+LZRegular.h"

@implementation NSString (LZPinYin)

- (NSString *)fullPinyin {
    
    NSString *result = self;
    if (NO == [result isValidString]) {
        return @"";
    }
    
    NSMutableString *pinyinM = [NSMutableString stringWithString:result];
    CFStringTransform((__bridge CFMutableStringRef)pinyinM, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyinM, NULL, kCFStringTransformStripDiacritics, NO);
    return pinyinM.copy;
}

- (NSString *)pinyinString {
    
    NSString *result = self.fullPinyin;
    NSRange range = [result rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    if (range.location != NSNotFound) {
        result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    range = [result rangeOfString:@" "];
    if (range.location != NSNotFound) {
        result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return result;
}

- (NSString *)pinyinFirstLetter {
    
    NSString *pinyin = self.pinyinString;
    if (pinyin.length) return [pinyin substringToIndex:1];
    else return @"";
}

@end

@implementation NSArray (LZPinYin)

- (NSArray *)sortedArrayUsingChineseKey:(NSString *)chineseKey {
    
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:self.count];
    for (int i = 0; i < self.count; ++i) {
        
        NSString *chineseString = (chineseKey == nil) ? self[i] : [self[i] valueForKeyPath:chineseKey];
        [tmpArray addObject:@{@"obj": self[i], @"pinyin": chineseString.pinyinString.lowercaseString}];
    }
    
    [tmpArray sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        return [obj1[@"pinyin"] compare:obj2[@"pinyin"]];
    }];
    return [tmpArray valueForKey:@"obj"];;
}

@end
