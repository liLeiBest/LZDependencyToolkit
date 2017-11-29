//
//  NSDate+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DateSepartorType) {
    DateSepartorTypeDefault,    // e.g 2000-01-01 00:00:00
    DateSepartorTypeChinese,    // e.g 2000年01月01日 00时00分00秒
    DateSepartorTypeSlash,      // e.g 2000/01/01 00/00/00
    DateSepartorTypeNone,       // e.g 20000101000000
};

typedef struct _date_interval_type {
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
} DateInterval;

typedef NS_ENUM(NSUInteger, WeekType) {
    WeekTypeMonday,
    WeekTypeTuesday,
    WeekTypeWednesday,
    WeekTypeThursday,
    WeekTypeFriday,
    WeekTypeSaturday,
    WeekTypeSunday,
    WeekTypeUnknow,
};

@interface NSDate (LZExtension)

//MARK: - 对象方法
/**
 *  是否为今天
 *
 *  @return BOOL
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 *
 *  @return BOOL
 */
- (BOOL)isYesterday;

/**
 *  是否为前天
 *
 *  @return BOOL
 */
- (BOOL)isBeforeYesterday;

/**
 *  是否为明天
 *
 *  @return BOOL
 */
- (BOOL)isTomorrow;

/**
 *  是否为后天
 *
 *  @return BOOL
 */
- (BOOL)isAfterTomorrow;

/**
 *  是否为周未
 *
 *  @return BOOL
 */
- (BOOL)isWeekend;

/**
 *  星期几
 *
 *  @return WeekType
 */
- (WeekType)weekday;

/**
 *  是否为今年
 *
 *  @return BOOL
 */
- (BOOL)isThisYear;

/**
 *  返回距今的日期间隔
 *
 *  @param unit 指定日期单元
 *  @return NSDateComponents
 */
- (NSDateComponents *)dateComponentsTillNow:(NSCalendarUnit)unit;

/**
 * 日期格式化为年月日 e.g 2000-01-01
 *
 *  @return NSString
 */
- (NSString *)dateFormatToYMD;

/**
 *  根据分隔线类型格式化年月日日期
 *
 *  @return NSString
 */
- (NSString *)dateFormatToYMDWithSepartorType:(DateSepartorType)separtorType;

/**
 *  根据分隔线类型格式化日期
 *
 *  @return NSString
 */
- (NSString *)dateFormatWithSepartorType:(DateSepartorType)separtorType;

/**
 *  根据指定格式格式化日期
 *
 *  @return NSString
 */
- (NSString *)dateFormat:(NSString *)format;

/**
 *  根据时间转化为时间戳
 *
 *  @return NSString
 */
- (NSString *)timeStamp;

//MARK: - 类方法
//MARK: 日期格式化
/**
 *  获取当前的时间戳
 *
 *  @return NSString
 */
+ (NSString *)currentTimeStamp;

/**
 *  根据指定格式的时间转换为时间戳
 *
 *  @param dateStr 日期字符串
 *  @param dateFormat 日期格式
 *  @return NSString
 */
+ (NSString *)timeStamp:(NSString *)dateStr
             dateFormat:(NSString *)dateFormat;

/**
 *  根据指定的日期格式将字符串转换为日期
 *
 *  @param dateStr 字符串格式日期
 *  @param formats 可能包含的日期格式
 *  @return NSDate
 */
+ (NSDate *)dateFormatToDate:(NSString *)dateStr
                     formats:(NSArray<NSString *> *)formats;

/**
 *  日期格式转换
 *
 *  @param dateStr 字符串格式日期或时间戳
 *  @param originDateFormat 原始日期格式
 *  @param resultDateFormat 目标日期格式
 *  @return NSString
 *  @remark 如果是字符串类格式时间，则必填；如果是时间戳，则填 nil 或 @""。
 */
+ (NSString *)dateFormatConvert:(NSString *)dateStr
               originDateFormat:(NSString *)originDateFormat
               resultDateFormat:(NSString *)resultDateFormat;

/**
 *  返回包含年月或年月日的日期
 *
 *  @param dateStr 字符串格式日期或时间戳
 *  @return NSString
 *  @remark 如果是字符串类格式时间，则必填；如果是时间戳，则填 nil 或 @""。
 */
+ (NSString *)dateFormatToMDOrYMD:(NSString *)dateStr;

/**
 *  返回包含今天或明天或年月日的日期
 *
 *  @param dateStr 时间戳
 *  @return NSString
 *  @discussion 如果是今天，e.g 今天；如果是昨天，e.g 昨天；如果是今年，e.g MM月dd日；
 *  其它情况，e.g yyyy年MM月dd日
 */
+ (NSString *)dateFormatToTdayOrYdayOrYMD:(NSString *)dateStr;

/**
 *  返回包含今天的时间或昨天或年月日的日期
 *
 *  @param dateStr 时间戳
 *  @return NSString
 *  @discussion 如果是今天，e.g HH:mm；如果是昨天，e.g 昨天；如果是今年，e.g MM月dd日；
 *  其它情况，e.g yyyy年MM月dd日
 */
+ (NSString *)dateFormatToTdayTimeOrYdayOrYMD:(NSString *)dateStr;

/**
 *  返回包含今天的时间或等昨天的时间或年月日的时间的日期
 *
 *  @param dateStr 时间戳
 *  @return NSString
 *  @discussion 如果是今天，e.g HH:mm；如果是昨天，e.g 昨天 HH:mm；如果是今年，e.g MM月dd日 HH:mm；
 *  其它情况，e.g yyyy年MM月dd日 HH:mm
 */
+ (NSString *)dateFormatToTdayTimeOrYdayTimeOrYMDTime:(NSString *)dateStr;

/**
 *  返回包含今天的时间或年月日的时间的日期
 *
 *  @param dateStr 时间戳
 *  @return NSString
 *  @discussion 如果是今天，e.g HH:mm；如果是今年，e.g MM月dd日；
 *  其它情况，e.g yyyy年MM月dd日
 */
+ (NSString *)dateFormatToTdayTimeOrYMDTime:(NSString *)dateStr;

/**
 *  返回包含今天的时间 昨天的时间 星期的时间 年月日的时间的日期
 *
 *  @param dateStr 时间戳
 *  @return NSString
 *  @discussion 如果是今天，e.g HH:mm；如果是昨天，e.g 昨天 HH:mm；如果是一周内，e.g EEEE HH:mm；
 *  其它情况，e.g yyyy年MM月dd日
 */
+ (NSString *)dateFormatToTdayTimeOrYdayTimeOrWkTimeOrYMDTime:(NSString  *)dateStr;

/**
 *  返回包含刚刚 几分钟前 几小时前 昨天 2天前 年月日的时间的日期
 *
 *  @param dateStr 时间戳
 *  @return NSString
 *  @discussion 如果是今天，e.g 刚刚 or 几分钟前 or 几小时前；如果是昨天，e.g 昨天；如果是前天，e.g 2天前；
 *  如果是今年，e.g MM月dd日；其它情况，e.g yyyy年MM月dd日。
 *  @remark 只能计算当前时间以前的日期。将来的时间被视为刚刚。
 */
+ (NSString *)dateFormatToTimeIntervalOrYMDFromHistory:(NSString *)dateStr;

/**
 *  返回包含刚刚 几分钟前 几小时前 昨天 明天 前天 后天 年月日的时间的日期
 *
 *  @param dateStr 时间戳
 *  @return NSString
 *  @discussion 如果是今天，e.g 刚刚 or 几分钟前 or 几小时前；如果是昨天，e.g 昨天；如果是前天，e.g 前天；
 *  如果是明天，e.g 明天；如果是后天，e.g 后天；如果是今年，e.g MM月dd日；其它情况，e.g yyyy年MM月dd日。
 *  @remark 只能计算当前时间以前的日期。将来的时间被视为刚刚。
 */
+ (NSString *)dateFormatToTimeIntervalOrYMDFromHistoryOrFuture:(NSString *)dateStr;

//MARK: 日期比较
/**
 *  判断 date1 是否大于 date2，即 date1 是否晚于 date2
 *
 *  @return BOOL
 */
+ (BOOL)compareDate:(NSDate *)date1
             toDate:(NSDate *)date2;

/**
 *  判断当前日期是否介于 date1 和 date2 之间
 *
 *  @return BOOL
 */
+ (BOOL)isBetweenDate:(NSDate *)date1
              andDate:(NSDate *)date2;

//MARK: 日期间隔
/**
 *  返回距离现在日期间隔
 *
 *  @param dateStr 字符串时间或时间戳
 *  @param dateFormat 日期格式
 *  @retrun NSString
 *  @discussion 可以计算将来的日期距离现在的间隔
 *  @remark 如果是字符串类格式时间，则必填；如果是时间戳，则填 nil 或 @""。
 */
+ (DateInterval)dateInterval:(NSString *)dateStr
            originDateFormat:(NSString *)dateFormat;

/**
 *  返回距离现在日期间隔的总天数
 *
 *  @param dateStr 字符串时间或时间戳
 *  @param dateFormat 日期格式
 *  @retrun NSString
 *  @discussion 可以计算将来的日期距离现在的总天数
 *  @remark 如果是字符串类格式时间，则必填；如果是时间戳，则填 nil 或 @""。
 */
+ (NSInteger)dateIntervalForDays:(NSString *)dateStr
                originDateFormat:(NSString *)dateFormat;

/**
 *  返回年的生日描述
 *
 *  @param dateStr 字符串时间或时间戳
 *  @param dateFormat 日期格式
 *  @retrun NSString
 *  @remark 如果是字符串类格式时间，则必填；如果是时间戳，则填 nil 或 @""。
 */
+ (NSString *)dateIntervalForAgeDescOfYear:(NSString *)dateStr
                          originDateFormat:(NSString *)dateFormat;

/**
 *  返回年月的生日描述
 *
 *  @param dateStr 字符串时间或时间戳
 *  @param dateFormat 日期格式
 *  @retrun NSString
 *  @remark 如果是字符串类格式时间，则必填；如果是时间戳，则填 nil 或 @""。
 */
+ (NSString *)dateIntervalForAgeDescOfYearAndMonth:(NSString *)dateStr
                                  originDateFormat:(NSString *)dateFormat;

@end
