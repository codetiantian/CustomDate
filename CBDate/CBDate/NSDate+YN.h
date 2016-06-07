//
//  NSDate+YN.h
//  YNNursety
//
//  Created by Elaine on 14--27.
//  Copyright (c) 2014年 yinuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YN)
/**
 *  该日期是该年的第几周
 */
- (int)getWeekOfYear;
/**
 *  返回day天后的日期(若day为负数,则为|day|天前的日期)
 *
 *  @param day 正数(几天后) 负数(几天前)
 */
- (NSDate *)dateAfterDay:(int)day;
/**
 *  返回month月后的日期(若month为负数,则为|month|月前的日期)
 *
 *  @param day 正数(几月后) 负数(几月前)
 */
- (NSDate *)dateafterMonth:(int)month;
/**
 *  获取日
 */
- (NSUInteger)getDay;
/**
 *  获取月
 */
- (NSUInteger)getMonth;
/**
 *  获取年
 */
- (NSUInteger)getYear;
/**
 *  获取小时
 */
- (int)getHour;
/**
 *  获取分钟
 */
- (int)getMinute;
/**
 *  获取date小时
 *
 *  @param date 要获得小时的日期
 */
- (int)getHour:(NSDate *)date;
/**
 *  获取date分钟
 *
 *  @param date 要获得分钟的日期
 */
- (int)getMinute:(NSDate *)date;
/**
 *  在当前日期前几天
 */
- (NSUInteger)daysAgo;
/**
 *  午夜时间距今几天
 */
- (NSUInteger)daysAgoAgainstMidnight;
/**
 *  多少天前 Today 、Yesterday or N days ago
 *
 *  @param flag YES 当前时间 NO 午时
 */
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;
/**
 *  返回一周的第几天(周末为第一天)
 */
- (NSUInteger)weekday;

- (NSUInteger)weekdayEast;
/**
 *  通过字符串和格式返回日期
 *
 *  @param string 日期字符串 eg:2014-08-27
 *  @param format 格式化字符串 eg:yyyy-MM-dd
 */
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
/**
 *  通过日期返回固定字符串 如果是今天 返回小时 如果是一周内 返回周几 如果是今年 返回月和日 其他返回年月日
 *
 *  @param date     日期
 *  @param prefixed 是否加前缀 eg: at on ...
 */
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;
/**
 *  以dateStyle、timeStyle格式化日期
 */
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
/**
 *  返回当前周的的开始时间(周日为第一天)
 */
- (NSDate *)beginningOfWeek;
/**
 *  返回当前周的的开始时间(周一为第一天)
 */
- (NSDate *)beginningOfWeekEast;
/**
 *  返回该月的第一天
 */
- (NSDate *)beginningOfMonth;
/**
 *  该月的最后一天
 */
- (NSDate *)endOfMonth;
/**
 *  返回当前周的周末(周六为周末)
 */
- (NSDate *)endOfWeek;
/**
 *  返回当前周的周末(周日为周末)
 */
- (NSDate *)endOfWeekEast;

@end
