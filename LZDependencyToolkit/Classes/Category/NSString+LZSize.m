//
//  NSString+LZSize.m
//  Pods
//
//  Created by Dear.Q on 2017/6/6.
//
//

#import "NSString+LZSize.h"

@implementation NSString (LZSize)

/** 根据文本的属性及内容，计算文本所占的宽、高 */
- (CGSize)sizeWithAttributes:(NSDictionary *)attributes maxSize:(CGSize)maxSize
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize stringSize = [self boundingRectWithSize:maxSize
                                           options:options
                                        attributes:attributes
                                           context:nil].size;
    
    return CGSizeMake(ceil(stringSize.width), ceil(stringSize.height));
}

/** 根据文本的字体及内容，计算文本所占宽、高 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [self sizeWithAttributes:@{NSFontAttributeName:font} maxSize:maxSize];
}

@end
