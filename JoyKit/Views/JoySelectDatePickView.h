//
//  JoySelectDatePickView.h
//  pickView
//
//  Created by Joymake on 2016/6/25.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoySelectDatePickView : UIView

@property (nonatomic,assign) NSTextAlignment textAlignment;

@property (nonatomic,copy)void (^CancleBtnClickBlock)(void);

@property (nonatomic,copy)void (^EntryBtnClickBlock)(NSDate *date);

@property (nonatomic, readonly) NSDateFormatter *formatter;

@property (nonatomic,readonly)UIPickerView *pickerView;

- (void)setTitle:(NSString *)title;

//设置日期上下限
- (void)setMinDate:(NSDate *)minDate maxDate:(NSDate *)date;

//选中日期
- (void)selectDate:(NSDate *)selectDate animated:(BOOL)animated;

- (void)showPickView;

@end
