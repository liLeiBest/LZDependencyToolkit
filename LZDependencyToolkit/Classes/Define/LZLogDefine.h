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
    static NSString *lz_log_displayName = nil; \
    static NSDateFormatter *lz_log_dateFormatter = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary; \
        NSString *displayNameKey = @"CFBundleDisplayName"; \
        lz_log_displayName = [infoDict objectForKey:displayNameKey]; \
        if (nil == lz_log_displayName || 0 == lz_log_displayName.length) { \
            displayNameKey = @"CFBundleName"; \
            lz_log_displayName = [infoDict objectForKey:displayNameKey]; \
        } \
        lz_log_dateFormatter = [[NSDateFormatter alloc] init]; \
        [lz_log_dateFormatter setDateStyle:NSDateFormatterMediumStyle]; \
        [lz_log_dateFormatter setTimeStyle:NSDateFormatterShortStyle]; \
        NSTimeZone* timeZone = [NSTimeZone systemTimeZone]; \
        [lz_log_dateFormatter setTimeZone:timeZone]; \
        [lz_log_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSSZ"]; \
    }); \
    const char *_lz_log_time = [[lz_log_dateFormatter stringFromDate:[NSDate date]] UTF8String]; \
    const char *_lz_log_app = [lz_log_displayName UTF8String]; \
    const char *_lz_log_file = [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String]; \
    const char *_lz_log_content = [[NSString stringWithFormat:@"%@" fmt, @"", ##__VA_ARGS__] UTF8String]; \
    const char *_lz_log_line_start = [@"--------------------------Start--------------------------" UTF8String]; \
    const char *_lz_log_line_end =   [@"---------------------------End---------------------------" UTF8String]; \
    fprintf(stderr, "%s %s %s %s [Line %d]\n%s\n%s\n%s\n", _lz_log_time, _lz_log_app, _lz_log_file, __PRETTY_FUNCTION__, __LINE__, _lz_log_line_start, _lz_log_content, _lz_log_line_end);\
}
#else
#define LZLog(fmt, ...)
#endif

#endif /* LZLogDefine_h */
