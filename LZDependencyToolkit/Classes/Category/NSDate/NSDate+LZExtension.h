//
//  NSDate+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import <Foundation/Foundation.h>

/// 日期分隔符类型
typedef NS_ENUM(NSUInteger, LZDateSepartorType) {
    /// e.g 2000-01-01 00:00:00
    LZDateSepartorTypeDefault,
    /// e.g 2000年01月01日 00时00分00秒
    LZDateSepartorTypeChinese,
    /// e.g 2000/01/01 00/00/00
    LZDateSepartorTypeSlash,
    /// e.g 20000101000000
    LZDateSepartorTypeNone,
};

/// 描述日期间隔
typedef struct lz_date_interval_type {
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
} LZDateInterval;

/// 星期
typedef NS_ENUM(NSUInteger, LZWeekType) {
    LZWeekTypeMonday,
    LZWeekTypeTuesday,
    LZWeekTypeWednesday,
    LZWeekTypeThursday,
    LZWeekTypeFriday,
    LZWeekTypeSaturday,
    LZWeekTypeSunday,
    LZWeekTypeUnknow,
};

@interface NSDate (LZExtension)

//MARK: - 对象方法
/// 是否为今天
- (BOOL)isToday;

/// 是否为昨天
- (BOOL)isYesterday;

/// 是否为前天
- (BOOL)isBeforeYesterday;

/// 是否为明天
- (BOOL)isTomorrow;

/// 是否为后天
- (BOOL)isAfterTomorrow;

/// 是否为周未
- (BOOL)isWeekend;

/// 星期几
- (LZWeekType)weekday;

/// 是否为今年
- (BOOL)isThisYear;

/// 返回距今的日期间隔
/// @param unit NSCalendarUnit
- (NSDateComponents *)dateComponentsTillNow:(NSCalendarUnit)unit;

/// 日期格式化为年月日 e.g 2000-01-01
- (NSString *)dateFormatToYMD;

/// 根据分隔线类型格式化年月日日期
/// @param separtorType LZDateSepartorType
- (NSString *)dateFormatToYMDWithSepartorType:(LZDateSepartorType)separtorType;

/// 根据分隔线类型格式化日期
/// @param separtorType LZDateSepartorType
- (NSString *)dateFormatWithSepartorType:(LZDateSepartorType)separtorType;

/// 根据指定格式格式化日期
/// @param format 日期格式
- (NSString *)dateFormat:(NSString *)format;

/// 将日期转化为时间戳
- (NSString *)timeStamp;

/// 根据指定格式转化为时间戳
/// @param format 日期格式
- (NSString *)timeStamp:(NSString *)format;

//MARK: - 类方法
/// 获取当前时区的日期
+ (NSDate *)currentDate;

//MARK: 日期格式化
/// 获取当前的时间戳
+ (NSString *)currentTimeStamp;

/// 获取当前的时间戳
/// @param format 日期格式
+ (NSString *)currentTimeStamp:(NSString *)format;

/// 根据指定格式的日期转换为时间戳
/// @param dateStr 日期
/// @param dateFormat 日期格式
+ (NSString *)timeStamp:(NSString *)dateStr
             dateFormat:(NSString *)dateFormat;

/// 根据指定的日期格式将字符串转换为日期
/// @param dateStr 日期
/// @param formats 日期格式
+ (NSDate *)dateFormatToDate:(NSString *)dateStr
                     formats:(NSArray<NSString *> *)formats;

/// 日期格式转换
/// @param dateStr 日期
/// @param originDateFormat 原始日期格式
/// @param resultDateFormat 目标日期格式
/// @attention 是字符串类格式时间，originDateFormat 则必填；如果是时间戳，则填 nil 或 @""。
+ (NSString *)dateFormatConvert:(NSString *)dateStr
               originDateFormat:(NSString *)originDateFormat
               resultDateFormat:(NSString *)resultDateFormat;

/// 返回包含 年月 年月日 的日期描述
/// @param dateStr 时间戳
/// @discussion 如果是今年，e.g MM月dd日；其它情况，e.g yyyy年MM月dd日
+ (NSString *)dateFormatToMDOrYMD:(NSString *)dateStr;

/// 返回包含 今天 昨天 月日 年月日 的日期描述
/// @param dateStr 时间戳
/// @discussion 如果是今天，e.g 今天；如果是昨天，e.g 昨天；如果是今年，e.g MM月dd日；其它情况，e.g yyyy年MM月dd日
+ (NSString *)dateFormatToTdayOrYdayOrYMD:(NSString *)dateStr;

/// 返回包含 今天的时间 昨天 月日 年月日 的日期描述
/// @param dateStr 时间戳
/// @discussion 如果是今天，e.g HH:mm；如果是昨天，e.g 昨天；如果是今年，e.g MM月dd日；其它情况，e.g yyyy年MM月dd日
+ (NSString *)dateFormatToTdayTimeOrYdayOrYMD:(NSString *)dateStr;

/// 返回包含 今天的时间 月日的时间 年月日的时间 的日期描述
/// @param dateStr 时间戳
/// @discussion 如果是今天，e.g HH:mm；如果是今年，e.g MM月dd日 HH:mm；其它情况，e.g yyyy年MM月dd日 HH:mm
+ (NSString *)dateFormatToTdayTimeOrYMDTime:(NSString *)dateStr;

/// 返回包含 今天的时间 昨天的时间 月日的时间 年月日的时间 的日期描述
/// @param dateStr 时间戳
/// @discussion 如果是今天，e.g HH:mm；如果是昨天，e.g 昨天 HH:mm；如果是今年，e.g MM月dd日 HH:mm；其它情况，e.g yyyy年MM月dd日 HH:mm
+ (NSString *)dateFormatToTdayTimeOrYdayTimeOrYMDTime:(NSString *)dateStr;

/// 返回包含 今天的时间 昨天的时间 星期几的时间 年月日的时间 的日期描述
/// @param dateStr 时间戳
/// @discussion 如果是今天，e.g HH:mm；如果是昨天，e.g 昨天 HH:mm；如果是一周内，e.g EEEE HH:mm；其它情况，e.g yyyy年MM月dd日 HH:mm
+ (NSString *)dateFormatToTdayTimeOrYdayTimeOrWkTimeOrYMDTime:(NSString *)dateStr;

/// 返回包含 刚刚 几分钟前 几小时前 昨天 2天前 月日 年月日 的日期描述，优先考虑 24小时内的情况
/// @param dateStr 时间戳
/// @discussion 如果是今天，e.g 刚刚 or 几分钟前 or 几小时前；如果是昨天，e.g 昨天；如果是前天，e.g 2天前；如果是今年，e.g MM月dd日；其它情况，e.g yyyy年MM月dd日；只能计算当前时间以前的日期。将来的时间被视为 刚刚
/// @attention 优先考虑 24小时内的情况，大于 24 小时再考虑跨天的情况
+ (NSString *)dateFormatToTimeIntervalOrYMDFromHistory:(NSString *)dateStr;

/// 返回包含 刚刚 几分钟前 几小时前 昨天 2天前 月日 年月日 的日期描述，优先考虑跨天的情况
/// @param dateStr 时间戳
/// @discussion 如果是今天，e.g 刚刚 or 几分钟前 or 几小时前；如果是昨天，e.g 昨天；如果是前天，e.g 2天前；如果是今年，e.g MM月dd日；其它情况，e.g yyyy年MM月dd日。只能计算当前时间以前的日期。将来的时间被视为 刚刚。
/// @attention 优先考虑跨天的情况
+ (NSString *)dateFormatToTimeIntervalOrYMDFromHistoryInEveryDay:(NSString *)dateStr;

/// 返回包含 1分钟前 N分钟前 N小时前 昨天 2天前 N天前 的日期描述
/// @param dateStr 时间戳
/// @discussion 如果是今天，e.g 1分钟前 or 几分钟前 or 几小时前；如果是昨天，e.g 昨天；如果是前天，e.g 2天前；其它，e.g N天前
/// @attention 只能计算当前时间以前的日期。将来的时间被视为 1分钟前。
+ (NSString *)dateFormatToTimeOrDayIntervalFromHistory:(NSString *)dateStr;

/// 返回包含 刚刚 几分钟前 几小时前 昨天 明天 2天前 2天后 月日 年月日 的日期描述
/// @param dateStr 时间戳
/// @discussion 如果是今天，e.g 刚刚 or 几分钟前 or 几小时前；如果是昨天，e.g 昨天；如果是前天，e.g 2天前；如果是明天，e.g 明天；如果是后天，e.g 2天后；如果是今年，e.g MM月dd日；其它情况，e.g yyyy年MM月dd日。
+ (NSString *)dateFormatToTimeIntervalOrYMDFromHistoryOrFuture:(NSString *)dateStr;

//MARK: 日期比较
/// 判断 date1 是否大于 date2，即 date1 是否晚于 date2
/// @param date1 NSDate
/// @param date2 NSDate
+ (BOOL)compareDate:(NSDate *)date1
             toDate:(NSDate *)date2;

/// 判断当前日期是否介于 date1 和 date2 之间
/// @param date1 NSDate
/// @param date2 NSDate
+ (BOOL)isBetweenDate:(NSDate *)date1
              andDate:(NSDate *)date2;

//MARK: 日期间隔
/// 返回距离现在日期间隔
/// @param dateStr 日期
/// @param dateFormat 日期格式
/// @discussion 可以计算将来的日期距离现在的间隔
/// @attention 如果是字符串类格式时间，dateFormat 则必填；如果是时间戳，则填 nil 或 @""。
+ (LZDateInterval)dateInterval:(NSString *)dateStr
              originDateFormat:(NSString *)dateFormat;

/// 返回距离现在日期间隔的总天数
/// @param dateStr 日期
/// @param dateFormat 日期格式
/// @discussion 可以计算将来的日期距离现在的总天数
/// @attention 如果是字符串类格式时间，dateFormat 则必填；如果是时间戳，则填 nil 或 @""。
+ (NSInteger)dateIntervalForDays:(NSString *)dateStr
                originDateFormat:(NSString *)dateFormat;

/// 返回年的生日描述，N岁
/// @param dateStr 日期
/// @param dateFormat 日期格式
/// @attention 如果是字符串类格式时间，则必填；如果是时间戳，则填 nil 或 @""。
+ (NSString *)dateIntervalForAgeDescOfYear:(NSString *)dateStr
                          originDateFormat:(NSString *)dateFormat;

/// 返回年月的生日描述，N岁N个月
/// @param dateStr 日期
/// @param dateFormat 日期格式
/// @attention 如果是字符串类格式时间，则必填；如果是时间戳，则填 nil 或 @""。
+ (NSString *)dateIntervalForAgeDescOfYearAndMonth:(NSString *)dateStr
                                  originDateFormat:(NSString *)dateFormat;

@end
