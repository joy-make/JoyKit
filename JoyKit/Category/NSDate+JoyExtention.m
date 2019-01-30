//
//  NSDate+JoyExtention.m
//  pickView
//
//  Created by Joymake on 2016/8/11.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "NSDate+JoyExtention.h"

@implementation NSDate (JoyExtention)

- (NSDate *)addMinutes:(NSInteger)minutes{
    return [self dateByAddingTimeInterval:minutes*60];
}

- (NSDate *)addHours:(NSInteger)hours{
    return [self dateByAddingTimeInterval:hours*60*60];
}

- (NSDate *)addDays:(NSInteger)days{
    return [self dateByAddingTimeInterval:days*60*60*24];
}

- (NSDate *)addWeeks:(NSInteger)weeks{
    return [self dateByAddingTimeInterval:weeks*60*60*24*7];
}

- (NSDate *)addMonths:(NSInteger)months{

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:months];
    
    [adcomps setDay:0];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:self options:0];
    
    return newdate;
}

- (NSDate *)addYears:(NSInteger)years{
    return [self dateByAddingTimeInterval:years*60*60*24*365];
}

- (NSDate *)addYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:years];
    
    [adcomps setMonth:months];
    
    [adcomps setDay:days];
    
    [adcomps setHour:hours];
    
    [adcomps setMinute:minutes];
    
    [adcomps setSecond:seconds];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:self options:0];
    
    return newdate;
}

-(NSString*)timeStringformat:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:self];
    dateFormatter = nil;
    return dateString;
}

+(NSDate *)getDateFormat:(NSString *)fromat dateStr:(NSString *)dateStr{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:fromat];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:dateStr];
    return date;
}

+(NSInteger)getIntervalFromDate:(NSDate*)from end:(NSDate *)end dateUnit:(NSCalendarUnit)unit{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar
                                    components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                    fromDate:from
                                    toDate:end options:0];
    switch (unit) {
        case NSCalendarUnitYear:
            return components.year;
        case NSCalendarUnitMonth:
            return components.month;
        case NSCalendarUnitDay:
            return components.day;
        case NSCalendarUnitHour:
            return components.hour;
        case NSCalendarUnitMinute:
            return components.minute;
        case NSCalendarUnitSecond:
            return components.second;
        default:
            break;
    }

    NSTimeInterval start = [from timeIntervalSince1970]*1;
    NSTimeInterval endInterval = [end timeIntervalSince1970]*1;
    NSTimeInterval value = endInterval - start;
    return value/60;
}

-(NSDate *)getFirstDayWithUnit:(NSCalendarUnit)unit{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:unit startDate:&firstDay interval:nil forDate:self];
    return firstDay;
}

-(NSDate *)getLastDayWithUnit:(NSCalendarUnit)unit{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:unit startDate:&firstDay interval:nil forDate:self];
    NSUInteger dayNumberOfMonth = unit==NSCalendarUnitWeekday?7:[calendar rangeOfUnit:NSCalendarUnitDay inUnit:unit forDate:self].length;
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:dayNumberOfMonth];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:firstDay options:0];
    return newdate;
}

-(NSArray *)getFirstAndLastDayOfThisYear
{
    //通过2月天数的改变，来确定全年天数
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy"];
    NSString *dateStr = [formatter stringFromDate:self];
    dateStr = [dateStr stringByAppendingString:@"-02-14"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *aDayOfFebruary = [formatter dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitYear startDate:&firstDay interval:nil forDate:self];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfFebruary = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:aDayOfFebruary].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+337+dayNumberOfFebruary-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}

@end
