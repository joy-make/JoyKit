//
//  JoySelectDatePickView.m
//  pickView
//
//  Created by Joymake on 2016/6/25.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "JoySelectDatePickView.h"
#import "Joy.h"
#import "UIView+JoyCategory.h"

@interface JoySelectDatePickView  ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)UIView     *          coverView;
@property (nonatomic,strong)UIToolbar  *          toolBar;
@property (nonatomic,strong)NSDate     *          minDate;
@property (nonatomic,strong)NSDate     *          maxDate;
@property (nonatomic,strong)NSDate     *          selectDate;
@property (nonatomic, strong)NSCalendar*          calendar;
@property (nonatomic,strong)NSArray<NSArray*>*    dataArray;
@property (nonatomic, strong)NSDateFormatter *    formatter;
@property (nonatomic,weak) UILabel           *    titleLabel;
@end

@implementation JoySelectDatePickView


- (instancetype)init
{
    if(self = [super init]){
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
        [self.coverView addSubview:self.pickerView];
        [self.coverView addSubview:self.toolBar];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelClick)];
        [self.coverView addGestureRecognizer:tapGesture];
        [self setConstrainst];
        //        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(void)dealloc{
    [self.coverView removeFromSuperview];
    self.dataArray= nil;
}

#pragma clang diagnostic ignored "-Wunused-variable"
- (void)setConstrainst
{
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(self.coverView, make.edges.equalTo([UIApplication sharedApplication].keyWindow););
    
    __weak typeof (self.coverView)weakSuper = self.coverView;
    MAS_CONSTRAINT(self.pickerView, make.left.equalTo(weakSuper);
                   make.bottom.equalTo(weakSuper);
                   make.right.equalTo(weakSuper);
                   make.height.equalTo(@216);
                   );
    
    MAS_CONSTRAINT(self.toolBar,make.left.equalTo(weakSuper);
                   make.bottom.equalTo(weakSelf.pickerView.mas_top);
                   make.right.equalTo(weakSuper);
                   make.height.equalTo(@44);
                   );
}

- (UIView *)coverView{
    if(!_coverView){
        _coverView = [[UIView alloc]init];    }
    return _coverView;
}
- (UIPickerView *)pickerView{
    if(!_pickerView){
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
    
}
- (UIToolbar *)toolBar{
    if(!_toolBar){
        _toolBar = [[UIToolbar alloc]initWithFrame:CGRectZero];
        [_toolBar setBackgroundImage:[UIImage new] forToolbarPosition:0 barMetrics:UIBarMetricsDefault];
        _toolBar.backgroundColor = [UIColor whiteColor];
        UIButton *spaceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 10, 25)];
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc]initWithCustomView:spaceBtn];
        
        UIButton *calcleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        calcleBtn.frame = CGRectMake(0, 5, 30, 25);
        [calcleBtn setTitleColor:UIColorFromRGB(0x347AEB) forState:UIControlStateNormal];
        [calcleBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [calcleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [calcleBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        UIBarButtonItem *cancleBarItem = [[UIBarButtonItem alloc]initWithCustomView:calcleBtn];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREEN_W-120, 25)];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = UIColorFromRGB(0x666666);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel = titleLabel;
        UIBarButtonItem * titleBar = [[UIBarButtonItem alloc]initWithCustomView:titleLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 5, 30, 25);
        [btn setTitleColor:UIColorFromRGB(0x347AEB) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceBarItem,cancleBarItem,titleBar,doneBtn,spaceBarItem,nil];
        [_toolBar setItems:buttonsArray];
        
        //分割线
        UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, _toolBar.bottom+44, SCREEN_W, 0.5)];
        shadowView.backgroundColor = UIColorFromRGB(0xEFF4F9);
        [_toolBar addSubview:shadowView];    }
    return _toolBar;
}

- (void)cancelClick{
    [self hidePickerView];
    self.CancleBtnClickBlock?self.CancleBtnClickBlock():nil;
}
- (void)sureClick{
    [self hidePickerView];
    int componet =0;
    NSMutableArray *list = [NSMutableArray array];
    while (componet<self.dataArray.count) {
        NSString *rowStr = [[self.dataArray objectAtIndex:componet] objectAtIndex:[self.pickerView selectedRowInComponent:componet]];
        [list addObject:rowStr];
        componet++;
    }
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@-%@",list.firstObject,[list objectAtIndex:1],[list objectAtIndex:2]];
    NSDate * date = [self.formatter dateFromString:dateStr];
    self.EntryBtnClickBlock?self.EntryBtnClickBlock(date):nil;
}

#pragma mark - 显示pickerView
- (void)showPickerView{
    __block CGRect rect = self.coverView.frame;
    rect.origin.y = 300;
    self.coverView.frame =rect;
    self.coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
    rect.origin.y = 0;
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.coverView.frame = rect;
    } completion:^(BOOL finished) {
        weakSelf.coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    }];
}

#pragma mark - 隐藏pickerview
- (void)hidePickerView{
    __block CGRect rect = self.coverView.frame;
    rect.origin.y += 300;
    self.coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.coverView.frame = rect;
    } completion:^(BOOL finished) {
        //        weakSelf.coverView.hidden = YES;
    }];
}

#pragma mark - pickerviewdataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self.dataArray objectAtIndex:component] count];
}
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return [UIScreen mainScreen].bounds.size.width/self.dataArray.count;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    int selectYear = [(NSString *)[[self.dataArray objectAtIndex:0] objectAtIndex:[pickerView selectedRowInComponent:0]] intValue];
    int selectMonth = 0;
    if(component==0){
        selectMonth = [(NSString *)[[self.dataArray objectAtIndex:1] firstObject] intValue];
        [self generateDataSourceWithYear:selectYear month:selectMonth];
        [pickerView reloadComponent:1];
        selectMonth = [(NSString *)[[self.dataArray objectAtIndex:1] objectAtIndex:[pickerView selectedRowInComponent:1]] intValue];
        [self generateDataSourceWithYear:selectYear month:selectMonth];
        [pickerView reloadComponent:2];
    }else if(component==1){
        selectMonth = [(NSString *)[[self.dataArray objectAtIndex:component] objectAtIndex:row] intValue];
        [self generateDataSourceWithYear:selectYear month:selectMonth];
        [pickerView reloadComponent:2];
    }
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[[self.dataArray objectAtIndex:component] objectAtIndex:row] stringByAppendingString:component==0?@"年":component==1?@"月":@"日"];
}

- (void)showPickView{
    [self showPickerView];
    [self.pickerView reloadAllComponents];
}

#pragma mark 设置标题
-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

#pragma mark 设置起始截止日期
-(void)setMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate{
    self.minDate = minDate;
    self.maxDate =maxDate;
    long minYear = [self.calendar component:NSCalendarUnitYear fromDate:self.minDate];
    long minMonth = [self.calendar component:NSCalendarUnitMonth fromDate:self.minDate];
    [self generateDataSourceWithYear:minYear month:minMonth];
}

#pragma mark 生成数据源
- (void)generateDataSourceWithYear:(long)selectYear month:(long)selectMonth{
    long minYear = [self.calendar component:NSCalendarUnitYear fromDate:self.minDate];
    long maxYear = [self.calendar component:NSCalendarUnitYear fromDate:self.maxDate];
    
    long minMonth = [self.calendar component:NSCalendarUnitMonth fromDate:self.minDate];
    long maxMonth = [self.calendar component:NSCalendarUnitMonth fromDate:self.maxDate];
    
    long minDay = [self.calendar component:NSCalendarUnitDay fromDate:self.minDate];
    long maxDay = [self.calendar component:NSCalendarUnitDay fromDate:self.maxDate];
    
    NSMutableArray *yearList = [NSMutableArray array];
    NSMutableArray *monthList = [NSMutableArray array];
    NSMutableArray *dayList = [NSMutableArray array];
    
    long year = minYear;
    while (year<=maxYear) {
        [yearList addObject:[NSString stringWithFormat:@"%ld",year]];
        year++;
    }
    
    //起始年则取设置的最小月，否则取1月
    long listStartMonth = minYear==selectYear ?minMonth:1;
    //结束年则取设置的最大月，否则取12月
    long listEndMonth = maxYear==selectYear?maxMonth:12;
    while (listStartMonth<=listEndMonth) {
        [monthList addObject:[NSString stringWithFormat:@"%ld",listStartMonth]];
        listStartMonth++;
    }
    
    //起始年月则取设置的最小日，否则取1号
    long listStartDay = (selectYear==minYear  && selectMonth ==minMonth)?minDay:1;
    long listEndDay =  (selectYear==maxYear && selectMonth == maxMonth)?maxDay:[self getDayLength:selectYear month:selectMonth];
    
    while (listStartDay<=listEndDay) {
        [dayList addObject:[NSString stringWithFormat:@"%ld",listStartDay]];
        listStartDay++;
    }
    self.dataArray = [NSMutableArray arrayWithObjects:yearList,monthList,dayList,nil];
}

#pragma mark 获取某月的最大日期数量
- (long)getDayLength:(long)year month:(long)month{
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"]; // 年-月
    NSString * dateStr = [NSString stringWithFormat:@"%ld-%ld",year,month];
    NSDate * date = [formatter dateFromString:dateStr];
    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay
                                        inUnit: NSCalendarUnitMonth
                                       forDate:date];
    return (long)range.length;
}

-(void)selectDate:(NSDate *)selectDate animated:(BOOL)animated{
    if([selectDate compare:self.minDate]==NSOrderedDescending || [selectDate compare:self.maxDate]==NSOrderedAscending || [selectDate compare:self.minDate] ==NSOrderedSame || [selectDate compare:self.maxDate] ==NSOrderedSame ){
        self.selectDate = selectDate;
        NSDateComponents *components = [self.calendar
                                        components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                        fromDate:self.selectDate];
        [self generateDataSourceWithYear:components.year month:components.month];
        [self showPickView];
        NSString *yearStr = [NSString stringWithFormat:@"%ld",components.year];
        NSString *monthStr = [NSString stringWithFormat:@"%ld",components.month];
        NSString *dayStr = [NSString stringWithFormat:@"%ld",components.day];
        if ([self.dataArray.firstObject containsObject:yearStr]) {
            NSInteger index =  [self.dataArray.firstObject indexOfObject:yearStr];
            [self.pickerView selectRow:index inComponent:0 animated:animated];
        }
        if ([[self.dataArray objectAtIndex:1] containsObject:monthStr]) {
            NSInteger index =  [[self.dataArray objectAtIndex:1] indexOfObject:monthStr];
            [self.pickerView selectRow:index inComponent:1 animated:animated];
        }
        if ([[self.dataArray objectAtIndex:2] containsObject:dayStr]) {
            NSInteger index =  [[self.dataArray objectAtIndex:2] indexOfObject:dayStr];
            [self.pickerView selectRow:index inComponent:2 animated:animated];
        }
    }
}

-(NSCalendar *)calendar{
    return _calendar = _calendar?:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
}

-(NSDateFormatter *)formatter{
    if(!_formatter){
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyy-MM-dd"]; // 年-月
    }
    return _formatter;
}


@end
