//
//  NSObject+LZDescription.h
//  Pods
//
//  Created by Dear.Q on 16/8/9.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LZDescription)

/**
 参数字符串
 */
- (NSString *)lz_parameterString;

@end

@interface NSArray (LZDescription)

/**
参数字符串
*/
- (NSString *)lz_parameterString;

@end

@interface NSObject (LZDescription)

- (NSString *)lz_customDescription;

@end
