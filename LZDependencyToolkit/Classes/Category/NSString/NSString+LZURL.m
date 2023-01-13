//
//  NSString+LZURL.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2018/9/17.
//

#import "NSString+LZURL.h"
#import "NSString+LZRegular.h"

@implementation NSString (LZURL)

// MARK: - Public
- (NSString *)urlByAppendingParameter:(NSDictionary * _Nonnull)paraDict {
	
	NSMutableString *paraString = [NSMutableString string];
    [paraDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSObject *value, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[NSString class]] && [(NSString *)value isValidString]) {
            
            NSArray *components = [(NSString *)value componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (components && components.count) {
                
                NSMutableString *componentsStrM = [NSMutableString string];
                for (NSString *component in components) {
                    if (component && component.length) {
                        
                        NSString *string = [component stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        if (string && string.length) {
                            [componentsStrM appendString:string];
                        }
                    }
                }
                value = [componentsStrM copy];
            }
            [paraString appendFormat:@"%@=%@&", key, value];
        } else {
            [paraString appendFormat:@"%@=%@&", key, value.description];
        }
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
    NSString *urlString = self;
    // 去掉前后空格
    urlString = [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 特殊处理：兼容 H5 的路由规则
    NSString *regx = @"/#{1,1}.{0,}/";
    NSRange range = [urlString rangeOfString:regx options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        // 编码前，先解码，防止二次编码
        urlString = [urlString stringByRemovingPercentEncoding];
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
