//
//  JoyPickerView.m
//  Toon
//
//  Created by joymake on 16/1/4.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyPickerView.h"
#import "Joy.h"

@interface JoyPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)UIView     *          coverView;
@property (nonatomic,strong)UIToolbar  *          toolBar;
@property (nonatomic,weak) UILabel     *          titleLabel;
@property (nonatomic,strong)UIButton   *          toolBarLeftBtn;
@property (nonatomic,strong)UIButton   *          toolBarRightBtn;
@property (nonatomic,strong)NSArray<NSArray*>     *dataArray;

@end

@implementation JoyPickerView
- (instancetype)init
{
    if(self = [super init]){
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
        
        [self.coverView addSubview:self.pickerView];
        
        [self.coverView addSubview:self.toolBar];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelClick)];
        [self.coverView addGestureRecognizer:tapGesture];
        self.coverView.hidden = YES;
        
        [self setConstrainst];
        
        [self setNeedsUpdateConstraints];
        
    }
    return self;
}

-(void)dealloc{
    [self.coverView removeFromSuperview];
    self.dataArray= nil;
}

- (void)reloadPickViewWithDataSource:(NSArray *)sourceArray{
    self.dataArray = sourceArray;
    [self.pickerView reloadAllComponents];
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
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    }
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

- (void)cancelClick{
    [self hidePickerView];
    self.CancleBtnClickBlock?self.CancleBtnClickBlock():nil;
}
- (void)sureClick{
    [self hidePickerView];
    NSMutableArray <JoyPickSelectedModel *>*selectedDataArrayM = [NSMutableArray array];
    for (int i=0; i<self.dataArray.count; i++) {
        JoyPickSelectedModel *model = [[JoyPickSelectedModel alloc]init];
        model.component = i;
        model.row = [self.pickerView selectedRowInComponent:i];
        NSArray *componentArray = [self.dataArray objectAtIndex:i];
        model.value = componentArray.count>model.row?[componentArray objectAtIndex:model.row]:nil;
        [selectedDataArrayM addObject:model];
    }
    self.EntryBtnClickBlock?self.EntryBtnClickBlock(selectedDataArrayM):nil;
}

#pragma mark - 显示pickerView
- (void)showPickerView{
    __block CGRect rect = self.coverView.frame;
    rect.origin.y = 300;
    self.coverView.frame =rect;
    self.coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
    rect.origin.y = 0;
    self.coverView.hidden = NO;
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
        weakSelf.coverView.hidden = YES;
    }];
}

#pragma mark 选中某一个component的某一个row
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    [self.pickerView selectRow:row inComponent:component animated:animated];
}

#pragma mark 根据component(key)对应的value进行查找 可全给或者给部分，根据componet确定
- (void)selectStrWithDict:(NSDictionary *)selectDict animated:(BOOL)animated{
    __weak __typeof(&*self)weakSelf = self;
    NSArray *selectComponentArray = selectDict.allKeys;
    NSAssert(selectComponentArray.count<=self.dataArray.count, @"giveSource not math dataSource");
    [selectComponentArray enumerateObjectsUsingBlock:^(NSString *componentIndex, NSUInteger idx, BOOL * _Nonnull stop) {
        NSAssert([componentIndex isKindOfClass:[NSString class]],@"请确认所给key为string类型的数字" );
        NSArray *rowArray = weakSelf.dataArray[[componentIndex integerValue]];
        NSString *selectValue = [selectDict valueForKey:componentIndex];
        NSAssert([rowArray containsObject:selectValue],@"所给datasource中没有包含本selectvalue,请确认");
        if(![rowArray containsObject:selectValue]){
            NSLog(@"所给datasource中没有包含本selectvalue,请确认");
        }else{
            NSInteger row = [rowArray indexOfObject:[selectDict valueForKey:componentIndex]];
            [weakSelf.pickerView selectRow:row inComponent:[componentIndex integerValue] animated:animated];
        }
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
    self.pickSelectBlock?self.pickSelectBlock(component,row):nil;
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.dataArray objectAtIndex:component] objectAtIndex:row];
}

- (void)showPickView{
    [self showPickerView];
    [self.pickerView reloadAllComponents];
}
- (void)hidePickView{
    self.coverView.hidden =YES;
}

@end

@implementation JoyPickSelectedModel

@end
