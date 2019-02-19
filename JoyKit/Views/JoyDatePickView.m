//
//  JoyDatePickView.m
//  Toon
//
//  Created by joymake on 16/1/25.
//  Copyright © 2016年 Joy. All rights reserved.
//
#define KBTN_TITLE_COLOR [UIColor colorWithRed:3/255.f green:122.f/255.f blue:1.f alpha:1.0f]
#define KPICKVIEW_OFFSET_Y 300
#define KSHOW_DURATION 0.3
#define KCOVER_ALPHA 0.3

#import "JoyDatePickView.h"
#import "Joy.h"
#import "UIView+JoyCategory.h"

@interface JoyDatePickView ()
@property (nonatomic,strong)UIView       *coverView;
@property (nonatomic,strong)UIToolbar    *toolBar;
@property (nonatomic,weak) UILabel       *titleLabel;
@property (nonatomic,strong)UIButton     *toolBarLeftBtn;
@property (nonatomic,strong)UIButton     *toolBarRightBtn;
@property (nonatomic,strong)UIDatePicker *pickView;
@property (nonatomic,strong)NSDate       *selectDate;
@end

@implementation JoyDatePickView

- (instancetype)init{
    if(self = [super init]){
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
        [self.coverView addSubview:self.pickView];
        [self.coverView addSubview:self.toolBar];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelClick)];
        [self.coverView addGestureRecognizer:tapGesture];
        self.coverView.hidden = YES;
        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(void)dealloc{
    [self.coverView removeFromSuperview];
    self.selectDate = nil;
}
#pragma clang diagnostic ignored "-Wunused-variable"
- (void)updateConstraints{
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(self.coverView, make.edges.equalTo([UIApplication sharedApplication].keyWindow););
    
    __weak typeof (self.coverView)weakSuper = self.coverView;
    MAS_CONSTRAINT(self.pickView,make.left.equalTo(weakSuper);
                   make.bottom.equalTo(weakSuper);
                   make.right.equalTo(weakSuper);
                   make.height.equalTo(@216););

    MAS_CONSTRAINT(self.toolBar,  make.left.equalTo(weakSuper);
                   make.bottom.equalTo(weakSelf.pickView.mas_top);
                   make.right.equalTo(weakSuper);
                   make.height.equalTo(@44););
    
    [super updateConstraints];
}


- (UIView *)coverView{
    if(!_coverView){
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    }
    return _coverView;
}

#define KMinimumDate @"1900 01 01"
- (UIDatePicker *)pickView{
    if(!_pickView){
        _pickView = [[UIDatePicker alloc]initWithFrame:CGRectZero];
        _pickView.datePickerMode = UIDatePickerModeDate;
        _pickView.backgroundColor = [UIColor whiteColor];
        [_pickView setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [_pickView setMaximumDate:[NSDate date]];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"yyyy MM dd";
        NSDate *date = [dateFormatter dateFromString:KMinimumDate];
        [_pickView setMinimumDate:date];
    }
    return _pickView;
}

- (UIToolbar *)toolBar{
    if(!_toolBar){
        _toolBar = [[UIToolbar alloc]initWithFrame:CGRectZero];
        [_toolBar setBackgroundImage:[UIImage new] forToolbarPosition:0 barMetrics:UIBarMetricsDefault];
        _toolBar.backgroundColor = [UIColor whiteColor];
        UIButton *spaceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 10, 25)];
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc]initWithCustomView:spaceBtn];
        
        self.toolBarLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.toolBarLeftBtn.frame = CGRectMake(0, 5, 30, 25);
        [self.toolBarLeftBtn setTitleColor:UIColorFromRGB(0x347AEB) forState:UIControlStateNormal];
        [self.toolBarLeftBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [self.toolBarLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.toolBarLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        UIBarButtonItem *cancleBarItem = [[UIBarButtonItem alloc]initWithCustomView:self.toolBarLeftBtn];
        
        //        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5,  SCREEN_W-120, 25)];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = UIColorFromRGB(0x666666);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel = titleLabel;
        UIBarButtonItem * titleBar = [[UIBarButtonItem alloc]initWithCustomView:titleLabel];
        
        self.toolBarRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.toolBarRightBtn.frame = CGRectMake(0, 5, 30, 25);
        [self.toolBarRightBtn setTitleColor:UIColorFromRGB(0x347AEB) forState:UIControlStateNormal];
        [self.toolBarRightBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [self.toolBarRightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.toolBarRightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:self.toolBarRightBtn];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceBarItem,cancleBarItem,titleBar,doneBtn,spaceBarItem,nil];
        [_toolBar setItems:buttonsArray];
        
        //分割线
        UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, _toolBar.bottom+44, SCREEN_W, 0.5)];
        shadowView.backgroundColor = UIColorFromRGB(0xEFF4F9);
        [_toolBar addSubview:shadowView];
    }
    
    return _toolBar;
}

- (void)cancelClick{
    [self hidePickerView:nil];
}

- (void)sureClick{
    [self hidePickerView:^{
        //    NSDateFormatter * dateFormater = [NSDateFormatter for];
        //    [[NSDateFormatter getDateFormatterWithFormatter:@"yyyy-MM-dd"];
        NSDateFormatter * dateFormater = [[NSDateFormatter alloc]init];
        dateFormater.dateFormat = @"yyyy-MM-dd";
        if ([self.pickView.date timeIntervalSinceDate:self.selectDate]) {
            NSString *selectDate = [dateFormater stringFromDate:self.pickView.date];
            self.entryClickBlock?self.entryClickBlock(selectDate):nil;
        }else{
            NSString *selectDate = [dateFormater stringFromDate:self.selectDate];
            self.entryClickBlock?self.entryClickBlock(selectDate):nil;
        }
    }];
}

-(void)setTitle:(NSString *)title{
    [self setTitle:title textColor:nil];
}

-(void)setTitle:(NSString *)title textColor:(UIColor *)textColor{
    self.titleLabel.text = title;
    if(textColor) self.titleLabel.textColor = textColor;
}

-(void)setToolbarLeftTitle:(NSString *)title textColor:(UIColor *)textColor{
    [self.toolBarLeftBtn setTitleColor:textColor forState:UIControlStateNormal];
    [self.toolBarLeftBtn setTitle:title forState:UIControlStateNormal];
}

-(void)setToolbarRightTitle:(NSString *)title textColor:(UIColor *)textColor{
    [self.toolBarRightBtn setTitleColor:textColor forState:UIControlStateNormal];
    [self.toolBarRightBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setDate:(NSDate *)date{
    self.selectDate = date;
    [self.pickView setDate:date];
}

- (void)setMinDate:(NSDate *)minimumDate{
    [self.pickView setMinimumDate:minimumDate];
}

- (void)setMaxDate:(NSDate *)maximumDate{
    [self.pickView setMaximumDate:maximumDate];
}

#pragma mark - 显示pickerView
- (void)showPickerView{
    CGRect rect = self.coverView.frame;
    rect.origin.y = KPICKVIEW_OFFSET_Y;
    self.coverView.frame =rect;
    self.coverView.backgroundColor = [UIColor colorWithWhite:KCOVER_ALPHA alpha:0];
    rect.origin.y = 0;
    self.coverView.hidden = NO;
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:KSHOW_DURATION animations:^{
        weakSelf.coverView.frame = rect;
    } completion:^(BOOL finished) {
        weakSelf.coverView.backgroundColor = [UIColor colorWithWhite:KCOVER_ALPHA alpha:KCOVER_ALPHA];
    }];
}

#pragma mark - 隐藏pickerview
- (void)hidePickerView:(VOIDBLOCK)finishe{
    CGRect rect = self.coverView.frame;
    rect.origin.y += KPICKVIEW_OFFSET_Y;
    self.coverView.backgroundColor = [UIColor colorWithWhite:KCOVER_ALPHA alpha:0];
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:KSHOW_DURATION animations:^{
        weakSelf.coverView.frame = rect;
    } completion:^(BOOL finished) {
        weakSelf.coverView.hidden = YES;
        finishe?finishe():nil;
    }];
}

- (void)showPickView{
    [self showPickerView];
}

- (void)hidePickView{
    self.coverView.hidden =YES;
}
@end
