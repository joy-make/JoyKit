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
- (NSDate *)addMinutes:(NSInteger)minutes;

//计算hours后的时间
- (NSDate *)addHours:(NSInteger)hours;

//计算days后的时间
- (NSDate *)addDays:(NSInteger)days;

//计算weeks后的时间
- (NSDate *)addWeeks:(NSInteger)weeks;

//计算months后的时间
- (NSDate *)addMonths:(NSInteger)months;

//计算years后的时间
- (NSDate *)addYears:(NSInteger)years;

//计算years+months+days+hours+minutes+seconds后的时间
- (NSDate *)addYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

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
+ (NSInteger)getIntervalFromDate:(NSDate*)from end:(NSDate *)end dateUnit:(NSCalendarUnit)unit;

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
