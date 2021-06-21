//
//  LZLogDefine.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/16.
//

#ifndef LZLogDefine_h
#define LZLogDefine_h

/** 替换 NSLog 来使用，debug 模式下可以打印很多信息：方法名、行等 */
#if DEBUG
#define LZLog(fmt, ...) { \
    __block NSString *displayName = nil; \
    __block NSDateFormatter *dateFormatter = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary; \
        NSString *displayNameKey = @"CFBundleDisplayName"; \
        displayName = [infoDict objectForKey:displayNameKey]; \
        if (nil == displayName || 0 == displayName.length) { \
            displayNameKey = @"CFBundleName"; \
            displayName = [infoDict objectForKey:displayNameKey]; \
        } \
        dateFormatter = [[NSDateFormatter alloc] init]; \
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle]; \
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle]; \
        NSTimeZone* timeZone = [NSTimeZone systemTimeZone]; \
        [dateFormatter setTimeZone:timeZone]; \
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSSZ"]; \
    }); \
    const char *time = [[dateFormatter stringFromDate:[NSDate date]] UTF8String]; \
    const char *app = [displayName UTF8String]; \
    const char *file = [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String]; \
    const char *content = [[NSString stringWithFormat:@"%@"fmt, @"", ##__VA_ARGS__] UTF8String]; \
    const char *line_start = [@"--------------------------Start--------------------------" UTF8String]; \
    const char *line_end =   [@"---------------------------End---------------------------" UTF8String]; \
    fprintf(stderr, "%s %s %s %s [Line %d]\n%s\n%s\n%s\n", time, app, file, __PRETTY_FUNCTION__, __LINE__, line_start, content, line_end);\
}
#else
#define LZLog(fmt, ...)
#endif

#endif /* LZLogDefine_h */
