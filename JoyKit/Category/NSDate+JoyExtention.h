//
//  NSDate+JoyExtention.h
//  pickView
//
//  Created by Joymake on 2016/8/11.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JoyExtention)

//计算minutes后的时间
- (NSDate *)addMinutes:(long long)minutes;

//计算hours后的时间
- (NSDate *)addHours:(long long)hours;

//计算days后的时间
- (NSDate *)addDays:(long long)days;

//计算weeks后的时间
- (NSDate *)addWeeks:(long long)weeks;

//计算months后的时间
- (NSDate *)addMonths:(long long)months;

//计算years后的时间
- (NSDate *)addYears:(long long)years;

//计算years+months+days+hours+minutes+seconds后的时间
- (NSDate *)addYears:(long long)years months:(long long)months days:(long long)days hours:(long long)hours minutes:(long long)minutes seconds:(long long)seconds;

//按指定格式转化日期为字符串
- (NSString*)timeStringformat:(NSString*)format;

/**
 获取指定格式日期
 @author  Joymake
 @param fromat @"yyyy-MM-dd HH:mm:ss"
 @param dateStr @"2014-00-22 04:23:22"
 @return 日期
 */
+(NSDate *)getDateFormat:(NSString *)fromat dateStr:(NSString *)dateStr;

/**
 获取两个时间段的间隔
 @author  Joymake
 @param from 起始日期
 @param end 结束日期
 @param unit 时间单位 NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
 @return 间隔（分）
 */
+ (long long)getIntervalFromDate:(NSDate*)from end:(NSDate *)end dateUnit:(NSCalendarUnit)unit;

/**
 获取当前日期单位的首日
 @param unit NSCalendarUnitYear|NSCalendarUnitMonth
 @return 首日
 */
- (NSDate *)getFirstDayWithUnit:(NSCalendarUnit)unit;

/**
 获取当前日期单位的末日
 @param unit NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeek
 @return 首日
 */
- (NSDate *)getLastDayWithUnit:(NSCalendarUnit)unit;

@end
