//
//  NSString+LZURL.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2018/9/17.
//

#import "NSString+LZURL.h"

@implementation NSString (LZURL)

// MARK: - Public
- (NSString *)urlByAppendingParameter:(NSDictionary * _Nonnull)paraDict {
	
	NSMutableString *paraString = [NSMutableString string];
	[paraDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
		[paraString appendFormat:@"%@=%@&", key, value];
	}];
	if (0 < paraString.length) {
		
		NSString *paras = [paraString substringToIndex:paraString.length - 1];
		return [self urlByAppendingKeyAndValue:paras];
	} else {
		return self;
	}
}

- (NSString *)urlByAppendingKeyAndValue:(NSString * _Nonnull)paraString {
    
    NSCharacterSet *queryCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    paraString = [paraString stringByAddingPercentEncodingWithAllowedCharacters:queryCharacterSet];
    // 去掉前后空格
    NSString *urlString = self;
    urlString = [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 特殊处理：兼容 H5 的路由规则
    NSString *regx = @"/#{1,1}.{0,}/";
    NSRange range = [urlString rangeOfString:regx options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:queryCharacterSet];
    }
    // 拼接参数
    if ([urlString hasSuffix:@"?"]
        || [urlString hasSuffix:@"&"]
        || [urlString hasSuffix:@"/"]) {
        urlString = [urlString substringToIndex:urlString.length - 1];
    }
    if ([urlString rangeOfString:@"?"].location != NSNotFound) {
        urlString = [NSString stringWithFormat:@"%@&%@", urlString, paraString];
    } else {
        urlString = [NSString stringWithFormat:@"%@?%@", urlString, paraString];
    }
    return urlString;
}

@end
