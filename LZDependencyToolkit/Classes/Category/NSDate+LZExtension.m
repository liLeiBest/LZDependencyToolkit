//
//  NSDate+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 16/8/10.
//
//

#import "NSDate+LZExtension.h"

@implementation NSDate (LZExtension)

//MARK: - Function
/** 是否大于等于 iOS8.0 */
BOOL greaterThanOrEqualToiOS8(void) {
    
    static BOOL iOS8;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *version = [UIDevice currentDevice].systemVersion;
        NSComparisonResult result = [version compare:@"8.0" options:NSNumericSearch];
        iOS8 = result != NSOrderedAscending;
    });
    
    return iOS8;
}

/** 返回日历实例 */
NSCalendar * calendar(void) {
    
    static NSCalendar *calendar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (greaterThanOrEqualToiOS8()) {
            
            calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        } else {
            
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        }
    });
    
    return calendar;
}

/** 日期格式化工具实例 */
NSDateFormatter * dateFormatter(void) {
    
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale currentLocale];
        dateFormatter.calendar = calendar();
    });
    
    return dateFormatter;
}

/** 字符串转换为日期 */
static NSString * _date_format = @"yyyy-MM-dd HH:mm:ss.SSS EEEE Z";
NSDate * stringToDate(NSString *dateStr, NSString *dateFormat) {
    
    NSDateFormatter *dateF = dateFormatter();
    dateF.dateFormat = dateFormat;
    NSDate *tempDate = [dateF dateFromString:dateStr];
    if (nil == tempDate || (nil == dateFormat || 0 == dateFormat.length)) {
        
        NSTimeInterval timeStamp = dateStr.doubleValue / 1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        dateF.dateFormat = _date_format;
        NSString *dateString = [dateF stringFromDate:date];
        tempDate = [dateF dateFromString:dateString];
    }
    
    return tempDate;
}

/** 日期转换为字符串 */
NSString * DateToString(NSDate *date, NSString *dateFormat) {
    
    NSDateFormatter *dateF = dateFormatter();
    dateF.dateFormat = dateFormat;
    
    return [dateF stringFromDate:date];
}

/** 返回一个只有年月日的日期 */
NSDate * DateYMD(NSDate *date) {
    
    NSString *dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = DateToString(date, dateFormat);
    NSDate *tempDate = stringToDate(selfStr, dateFormat);
    
    return tempDate;
}

/** 返回指定的日期元素 */
NSDateComponents * dateComponents(NSCalendarUnit unit, NSDate * startingDate ,NSDate * resultDate) {
    
    NSDateComponents *dateComponents = [calendar() components:unit
                                                     fromDate:startingDate
                                                       toDate:resultDate
                                                      options:0];
    
    return dateComponents;
}

//MARK: - Public
//MARK: - 对象方法
/** 是否为今天 */
- (BOOL)isToday {
    
    if (greaterThanOrEqualToiOS8()) {
        
        return [calendar() isDateInToday:self];
    } else {
        
        NSDate *nowDate = DateYMD([NSDate date]);
        NSDate *selfDate = DateYMD(self);
        
        return [selfDate isEqualToDate:nowDate];
    }
}

/** 是否为昨天 */
- (BOOL)isYesterday {
    
    if (greaterThanOrEqualToiOS8()) {
        
        return [calendar() isDateInYesterday:self];
    } else {
        
        NSDate *nowDate = DateYMD([NSDate date]);
        NSDate *selfDate = DateYMD(self);
        NSDateComponents *dateCmps = dateComponents(NSCalendarUnitDay, selfDate, nowDate);
        
        return dateCmps.day == 1;
    }
}

/** 是否为前天 */
- (BOOL)isBeforeYesterday {
    
    NSDate *nowDate = DateYMD([NSDate date]);
    NSDate *selfDate = DateYMD(self);
    NSDateComponents *dateCmps = dateComponents(NSCalendarUnitDay, selfDate, nowDate);
    
    return dateCmps.day == 2;
}

/** 是否为明天 */
- (BOOL)isTomorrow {
    
    if (greaterThanOrEqualToiOS8()) {
        
        return [calendar() isDateInTomorrow:self];
    } else {
        
        NSDate *nowDate = DateYMD([NSDate date]);
        NSDate *selfDate = DateYMD(self);
        NSDateComponents *dateCmps = dateComponents(NSCalendarUnitDay, selfDate, nowDate);
        
        return dateCmps.day == -1;
    }
}

/** 是否为后天 */
- (BOOL)isAfterTomorrow {
    
    NSDate *nowDate = DateYMD([NSDate date]);
    NSDate *selfDate = DateYMD(self);
    NSDateComponents *dateCmps = dateComponents(NSCalendarUnitDay, selfDate, nowDate);
    
    return dateCmps.day == -2;
}

/** 是否为周未 */
- (BOOL)isWeekend {
    
    if (!greaterThanOrEqualToiOS8()) {
        
        return [calendar() isDateInWeekend:self];
    } else {
        
        WeekType weekday = [self weekday];
        if (weekday == WeekTypeSaturday || weekday == WeekTypeSunday) {
            
            return YES;
        } else {
            
            return NO;
        }
    }
}

/** 星期几 */
- (WeekType)weekday {
    
    NSDateComponents *dateCmps = [calendar() components:NSCalendarUnitWeekday fromDate:self];
    switch (dateCmps.weekday) {
        case 1:
            return WeekTypeSunday;
            break;
        case 2:
            return WeekTypeMonday;
            break;
        case 3:
            return WeekTypeTuesday;
            break;
        case 4:
            return WeekTypeWednesday;
            break;
        case 5:
            return WeekTypeThursday;
            break;
        case 6:
            return WeekTypeFriday;
            break;
        case 7:
            return WeekTypeSaturday;
            break;
        default:
            return WeekTypeUnknow;
            break;
    }
}

/** 是否为今年 */
- (BOOL)isThisYear {
    
    if (greaterThanOrEqualToiOS8()) {
        
        return [calendar() isDate:self
                      equalToDate:[NSDate date]
                toUnitGranularity:NSCalendarUnitYear];
    }
    
    NSDateComponents *selfCmps = [calendar() components:NSCalendarUnitYear
                                               fromDate:self];
    NSDateComponents *curCmps = [calendar() components:NSCalendarUnitYear
                                              fromDate:[NSDate date]];
    
    return curCmps.year == selfCmps.year;
}

/** 返回指定的日期组件 */
- (NSDateComponents *)dateComponentsTillNow:(NSCalendarUnit)unit {
    
    return dateComponents(unit, self, [NSDate date]);
}

/** 日期格式化为年月日 e.g 2000-01-01 */
- (NSString *)dateFormatToYMD {
    
    return [self dateFormatToYMDWithSepartorType:DateSepartorTypeDefault];
}

/** 根据分隔线类型格式化年月日日期 */
- (NSString *)dateFormatToYMDWithSepartorType:(DateSepartorType)separtorType {
    
    NSString *formatter;
    switch (separtorType) {
        case DateSepartorTypeDefault:
            formatter = @"yyyy-MM-dd";
            break;
        case DateSepartorTypeChinese:
            formatter = @"yyyy年MM月dd日";
            break;
        case DateSepartorTypeSlash:
            formatter = @"yyyy/MM/dd";
            break;
        case DateSepartorTypeNone:
            formatter = @"yyyyMMdd";
            break;
        default:
            formatter = @"yyyy-MM-dd";
            break;
    }
    
    return [self dateFormat:formatter];
}

/** 根据分隔线类型格式化日期 */
- (NSString *)dateFormatWithSepartorType:(DateSepartorType)separtorType {
    
    NSString *formatter;
    switch (separtorType) {
        case DateSepartorTypeDefault:
            formatter = @"yyyy-MM-dd HH:mm:ss";
            break;
        case DateSepartorTypeChinese:
            formatter = @"yyyy年MM月dd日 HH时MM分ss秒";
            break;
        case DateSepartorTypeSlash:
            formatter = @"yyyy/MM/dd HH/mm/ss";
            break;
        case DateSepartorTypeNone:
            formatter = @"yyyyMMddHHMMss";
            break;
        default:
            formatter = @"yyyy-MM-dd HH:mm:ss";
            break;
    }
    
    return [self dateFormat:formatter];
}

/** 根据指定格式格式化日期 */
- (NSString *)dateFormat:(NSString *)format {
    
    return DateToString(self, format);
}

/** 根据时间转换成时间戳 */
- (NSString *)timeStamp {
    
    NSString *dateStr = DateToString(self, _date_format);
    NSDate *date = stringToDate(dateStr, _date_format);
    NSTimeInterval timeStamp = [date timeIntervalSince1970] * 1000;
    NSString *timeStampStr = [NSString stringWithFormat:@"%.1f", timeStamp];
    NSRange range = [timeStampStr rangeOfString:@"."];
    if (range.location != NSNotFound) timeStampStr = [timeStampStr substringToIndex:range.location];
    
    return timeStampStr;
}

//MARK: - 类方法
//MARK: 日期格式化
/** 获取当前时间戳 */
+ (NSString *)currentTimeStamp {
    
    return [[NSDate date] timeStamp];;
}

/** 根据指定格式的时间转换为时间戳 */
+ (NSString *)timeStamp:(NSString *)dateStr
             dateFormat:(NSString *)dateFormat {
    
    NSDate *date = stringToDate(dateStr, dateFormat);
    NSString *timeStamp = [date timeStamp];
    
    return timeStamp;
}

/** 根据指定的日期格式将字符串转换为日期 */
+ (NSDate *)dateFormatToDate:(NSString *)dateStr
                     formats:(NSArray<NSString *> *)formats {
    
    __block NSDate *tmpDate = nil;
    [formats enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        tmpDate = stringToDate(dateStr, obj);
        if (nil != tmpDate) {
            *stop = YES;
        }
    }];
    
    return tmpDate;
}

/** 日期格式转换 */
+ (NSString *)dateFormatConvert:(NSString *)dateStr
               originDateFormat:(NSString *)originDateFormat
               resultDateFormat:(NSString *)resultDateFormat {
    
    NSDate *date = stringToDate(dateStr, originDateFormat);
    NSString *dateString = [date dateFormat:resultDateFormat];
    
    return dateString;
}

/** 返回包含年月或年月日的日期 */
+ (NSString *)dateFormatToMDOrYMD:(NSString *)dateStr {
    
    NSDate *realDate = stringToDate(dateStr, nil);
    
    NSString *timeDesc;
    if ([realDate isThisYear]) {
        
        timeDesc = DateToString(realDate, @"MM月dd日");
    } else {
        
        timeDesc = DateToString(realDate, @"yyyy年MM月dd日");
    }
    
    return timeDesc;
}

/** 返回包含今天或明天或年月日的日期 */
+ (NSString *)dateFormatToTdayOrYdayOrYMD:(NSString *)dateStr {
    
    NSDate *realDate = stringToDate(dateStr, nil);
    
    NSString *timeDesc;
    if ([realDate isThisYear]) {
        
        if ([realDate isToday]) {
            
            timeDesc = @"今天";
        } else if ([realDate isYesterday]) {
            
            timeDesc = @"昨天";
        } else {
            
            timeDesc = DateToString(realDate, @"MM月dd日");
        }
    } else {
        
        timeDesc = DateToString(realDate, @"yyyy年MM月dd日");
    }
    
    return timeDesc;
}

/** 返回包含今天的时间或等昨天的时间或年月日的时间的日期 */
+ (NSString *)dateFormatToTdayTimeOrYdayTimeOrYMDTime:(NSString *)dateStr {
    
    NSDate *realDate = stringToDate(dateStr, nil);
    
    NSString *timeDesc;
    if ([realDate isThisYear]) {
        
        if ([realDate isToday]) {
            
            timeDesc = DateToString(realDate, @"HH:mm");
        } else if ([realDate isYesterday]) {
            
            timeDesc = DateToString(realDate, @"昨天 HH:mm");
        } else {
            
            timeDesc = DateToString(realDate, @"MM月dd日 HH:mm");
        }
    } else {
        
        timeDesc = DateToString(realDate, @"yyyy年MM月dd日 HH:mm");
    }
    
    return timeDesc;
}

/** 返回包含今天的时间或昨天或年月日的日期 */
+ (NSString *)dateFormatToTdayTimeOrYdayOrYMD:(NSString *)dateStr {
    
    NSDate *realDate = stringToDate(dateStr, nil);
    
    NSString *timeDesc;
    if ([realDate isThisYear]) {
        
        if ([realDate isToday]) {
            
            timeDesc = DateToString(realDate, @"HH:mm");
        } else if ([realDate isYesterday]) {
            
            timeDesc = @"昨天";
        } else {
            
            timeDesc = DateToString(realDate, @"MM月dd日");
        }
    } else {
        
        timeDesc = DateToString(realDate, @"yyyy年MM月dd日");
    }
    
    return timeDesc;
}

/** 返回包含今天的时间或年月日的时间的日期 */
+ (NSString *)dateFormatToTdayTimeOrYMDTime:(NSString *)dateStr {
    
    NSDate *realDate = stringToDate(dateStr, nil);
    
    NSString *timeDesc;
    if ([realDate isThisYear]) {
        
        if ([realDate isToday]) {
            
            timeDesc = DateToString(realDate, @"HH:mm");
        } else {
            
            timeDesc = DateToString(realDate, @"MM月dd日 HH:mm");
        }
    } else {
        
        timeDesc = DateToString(realDate, @"yyyy年MM月dd日 HH:mm");
    }
    
    return timeDesc;
}

/** 返回包含今天的时间 昨天的时间 星期的时间 年月日的时间的日期 */
+ (NSString *)dateFormatToTdayTimeOrYdayTimeOrWkTimeOrYMDTime:(NSString  *)dateStr {
    
    NSDate *realDate = stringToDate(dateStr, nil);
    
    NSCalendarUnit unit = NSCalendarUnitDay;
    NSDateComponents *dateCmps = dateComponents(unit, realDate, [NSDate date]);
    NSString *timeDesc;
    if (dateCmps.day == 0) {
        
        timeDesc = DateToString(realDate, @"HH:mm");
    } else if (dateCmps.day == 1) {
        
        timeDesc = DateToString(realDate, @"昨天 HH:mm");
    } else if (dateCmps.day < 7)  {
        
        timeDesc = DateToString(realDate, @"EEEE HH:mm");
    } else {
        
        timeDesc = DateToString(realDate, @"yyyy年MM月dd日 HH:mm");
    }
    
    return timeDesc;
}

/** 返回包含刚刚 几分钟前 几小时前 昨天 2天前 年月日的时间的日期 */
+ (NSString *)dateFormatToTimeIntervalOrYMDFromHistory:(NSString *)dateStr {
    
    NSDate *realDate = stringToDate(dateStr, nil);
    NSDate *curDate = [NSDate date];
    
    NSComparisonResult result = [realDate compare:curDate];
    if (result == NSOrderedDescending) {
        
        return @"刚刚";
    }
    
    NSString *timeDesc;
    if ([realDate isThisYear]) {
        
        NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateCmps = dateComponents(unit, realDate, curDate);
        NSInteger day = dateCmps.day;
        
        if (day == 0) {
            
            NSInteger hour = dateCmps.hour, minute = dateCmps.minute;
            if (hour > 0) {
                
                timeDesc = [NSString stringWithFormat:@"%li小时前", (long)hour];
            } else if (minute > 0) {
                
                timeDesc = [NSString stringWithFormat:@"%li分钟前", (long)minute];
            } else {
                
                return @"刚刚";
            }
        } else if (day == 1) {
            
            timeDesc = @"昨天";
        } else if (day == 2) {
            
            timeDesc = @"2天前";
        } else {
            
            timeDesc = DateToString(realDate, @"MM月dd日");
        }
    } else {
        
        timeDesc = DateToString(realDate, @"yyyy年MM月dd日");
    }
    
    return timeDesc;
}

/** 返回包含刚刚 几分钟前 几小时前 昨天 明天 前天 后天 年月日的时间的日期 */
+ (NSString *)dateFormatToTimeIntervalOrYMDFromHistoryOrFuture:(NSString *)dateStr {
    
    NSDate *realDate = stringToDate(dateStr, nil);
    
    NSString *timeDesc;
    if ([realDate isThisYear]) {
        
        NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateCmps = dateComponents(unit, realDate, [NSDate date]);
        NSInteger day = dateCmps.day;
        if (labs(day) == 0) {
            
            NSInteger hour = dateCmps.hour, minute = dateCmps.minute;
            NSInteger absH = labs(hour), absM = labs(minute);
            if (absH > 0) {
                
                NSString *suffix = hour > 0 ? @"前" : @"后";
                timeDesc = [NSString stringWithFormat:@"%li小时%@", (long)absH, suffix];
            } else if (absM > 0) {
                
                NSString *suffix = minute > 0 ? @"前" : @"后";
                timeDesc = [NSString stringWithFormat:@"%ld分钟%@", (long)absM, suffix];
            } else {
                
                timeDesc = @"刚刚";
            }
        } else if (labs(day) == 1) {
            
            NSString *suffix = day > 0 ? @"昨" : @"明";
            timeDesc = [NSString stringWithFormat:@"%@天", suffix];
            
        } else if (labs(day) == 2) {
            
            NSString *suffix = day > 0 ? @"前" : @"后";
            timeDesc = [NSString stringWithFormat:@"%@天", suffix];
        } else {
            
            timeDesc = DateToString(realDate, @"MM月dd日");
        }
    } else {
        
        timeDesc = DateToString(realDate, @"yyyy年MM月dd日");
    }
    
    return timeDesc;
}

//MARK: 日期比较
/** 判断 date1 是否大于 date2，即 date1 是否晚于 date2 */
+ (BOOL)compareDate:(NSDate *)date1
             toDate:(NSDate *)date2 {
    
    NSComparisonResult comparisonResult;
    if (!greaterThanOrEqualToiOS8()) {
        
        NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        comparisonResult = [calendar() compareDate:date1 toDate:date2 toUnitGranularity:unit];
    } else {
        
        comparisonResult = [date1 compare:date2];
    }
    
    return comparisonResult == NSOrderedDescending;
}

/** 判断当前日期是否介于 date1 和 date2 之间 */
+ (BOOL)isBetweenDate:(NSDate *)date1
              andDate:(NSDate *)date2 {
    
    NSDate *nowDate = [NSDate date];
    BOOL compareResult = ([nowDate compare:date1] != NSOrderedAscending && [nowDate compare:date2] != NSOrderedDescending) ||
    ([nowDate compare:date2] != NSOrderedAscending && [nowDate compare:date1] != NSOrderedDescending);
    
    return compareResult;
}

//MARK: 日期间隔
/** 返回距离现在日期间隔 */
+ (DateInterval)dateInterval:(NSString *)dateStr
            originDateFormat:(NSString *)dateFormat {
    
    NSDate *fromDate = stringToDate(dateStr, dateFormat);
    NSDate *toDate = [NSDate date];
    fromDate = fromDate ? fromDate : toDate;
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateCmps = dateComponents(unit, fromDate, toDate);
    DateInterval date = {labs(dateCmps.year), labs(dateCmps.month), labs(dateCmps.day), labs(dateCmps.hour), labs(dateCmps.minute), labs(dateCmps.second)};
    
    return date;
}

/** 返回距离现在日期间隔的总天数 */
+ (NSInteger)dateIntervalForDays:(NSString *)dateStr
                originDateFormat:(NSString *)dateFormat {
    
    NSDate *fromDate = stringToDate(dateStr, dateFormat);
    NSDate *toDate = [NSDate date];
    fromDate = fromDate ? fromDate : toDate;
    NSCalendarUnit unit = NSCalendarUnitDay;
    NSDateComponents *dateCmps = dateComponents(unit, fromDate, toDate);
    
    return labs(dateCmps.day);
}

/** 返回年的生日描述 */
+ (NSString *)dateIntervalForAgeDescOfYear:(NSString *)dateStr
                          originDateFormat:(NSString *)dateFormat {
    
    DateInterval dateInterval = [self dateInterval:dateStr originDateFormat:dateFormat];
    NSString *ageString = [NSString stringWithFormat:@"%li岁", (long)dateInterval.year];
    
    return ageString;
}

/** 返回年月的生日描述 */
+ (NSString *)dateIntervalForAgeDescOfYearAndMonth:(NSString *)dateStr
                                  originDateFormat:(NSString *)dateFormat {
    
    DateInterval dateInterval = [self dateInterval:dateStr originDateFormat:dateFormat];
    NSString *ageString = [NSString stringWithFormat:@"%li岁%li个月", (long)dateInterval.year, (long)dateInterval.month];
    
    return ageString;
}

@end
