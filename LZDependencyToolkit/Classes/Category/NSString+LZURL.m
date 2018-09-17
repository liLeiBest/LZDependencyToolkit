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
	return [self stringByAppendingFormat:@"%@%@", [self connector], paraString];
}

// MARK: - Private
- (NSString *)connector {
	
	if ([self hasSuffix:@"?"] || [self hasSuffix:@"&"]) {
		return @"";
	}
	return [self rangeOfString:@"?"].location == NSNotFound ? @"?" : @"&";
}

@end
