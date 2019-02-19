//
//  JoyPickerView.h
//  Toon
//
//  Created by joymake on 16/1/4.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "UIView+JoyCategory.h"

@class JoyPickSelectedModel;
@interface JoyPickerView : UIView
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,copy)void (^CancleBtnClickBlock)(void);
@property (nonatomic,copy)void (^EntryBtnClickBlock)(NSMutableArray <JoyPickSelectedModel *>*selectedDataArrayM);
@property (nonatomic,copy)void (^pickSelectBlock)(NSInteger coponent,NSInteger row);

//数组套数组格式,多section
- (void)reloadPickViewWithDataSource:(NSArray <NSArray *>*)sourceArray;

- (void)showPickView;

- (void)hidePickView;

- (void)setTitle:(NSString *)title textColor:(UIColor *)textColor;

- (void)setToolbarLeftTitle:(NSString *)title textColor:(UIColor *)textColor;

- (void)setToolbarRightTitle:(NSString *)title textColor:(UIColor *)textColor;

#pragma mark 选中某一个component的某一个row
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;

#pragma mark 根据component(key)对应的value进行查找 可全给或者给部分，根据componet确定
- (void)selectStrWithDict:(NSDictionary *)selectDict animated:(BOOL)animated;

@end

@interface JoyPickSelectedModel :NSObject
@property (nonatomic,assign)NSInteger component;
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,copy)NSString    *value;
@end
