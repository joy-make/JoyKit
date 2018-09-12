//
//  JoySelectDatePickView.h
//  pickView
//
//  Created by Joymake on 2016/6/25.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JoyDateType) {
    JoyDateYearDay,             //年月日
    JoyDateYearHour,            //年月日时
    JoyDateYearMinute           //年月日时分
};

@interface JoySelectDatePickView : UIView

@property (nonatomic,assign) NSTextAlignment textAlignment;

@property (nonatomic,copy)void (^CancleBtnClickBlock)(void);

@property (nonatomic,copy)void (^EntryBtnClickBlock)(NSDate *date);

@property (nonatomic, readonly) NSDateFormatter *formatter;

@property (nonatomic,readonly)UIPickerView *pickerView;

//设置工具条左标题
- (void)setToolbarLeftTitle:(NSString *)title;

//设置工具条右标题
- (void)setToolbarRightTitle:(NSString *)title;

//设置工具条标题
- (void)setTitle:(NSString *)title;

//设置日期类型格式
- (void)setDateType:(JoyDateType)dateType;

//设置日期上下限
- (void)setMinDate:(NSDate *)minDate maxDate:(NSDate *)date;

//选中日期
- (void)selectDate:(NSDate *)selectDate animated:(BOOL)animated;

- (void)showPickView;

@end
