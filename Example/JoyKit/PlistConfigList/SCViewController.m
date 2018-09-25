//
//  SCViewController.m
//  testConfigApp
//
//  Created by joy-make on 06/25/2018.
//  Copyright (c) 2018 joy-make. All rights reserved.
//

#import "SCViewController.h"
#import <JoyTableAutoLayoutView.h>
#import "PersonInteractor.h"
#import "PersonPresenter.h"
#import <JoyKit/JoyKit.h>

@interface SCViewController ()
@property (nonatomic,strong)JoyTableAutoLayoutView *tableView;
@property (nonatomic,strong)PersonInteractor *interactor;
@property (nonatomic,strong)PersonPresenter *presenter;
@property (nonatomic,strong)JoyPickerView *pickView;
@property (nonatomic,strong)JoyDatePickView *datePickView;

@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubViews];
    [self setRightNavItem];
    [self.presenter reloadDataSource];
}

- (void)setRightNavItem{
    [self setRightNavItemWithTitle:@"提交检测"];
}

- (void)addSubViews{
    [self setDefaultConstraintWithView:self.tableView andTitle:@"测试"];
    [self.view addSubview:self.pickView];
    [self.view addSubview:self.datePickView];
}

-(void)rightNavItemClickAction{
    [self.presenter rightNavItemClickAction];
}

-(PersonInteractor *)interactor{
    return _interactor = _interactor?:[[PersonInteractor alloc]init];
}

-(PersonPresenter *)presenter{
    if (!_presenter) {
        _presenter = [[PersonPresenter alloc]initWithView:self.view];
        _presenter.interactor = self.interactor;
        _presenter.tableView = self.tableView;
        _presenter.pickView = self.pickView;
        _presenter.datePickView = self.datePickView;
    }
    return _presenter;
}

-(JoyTableAutoLayoutView *)tableView{
    return _tableView = _tableView?:[[JoyTableAutoLayoutView alloc]init];
}

-(JoyPickerView *)pickView{
    return _pickView = _pickView?:[[JoyPickerView alloc]init];
}

-(JoyDatePickView *)datePickView{
    return _datePickView = _datePickView?:[[JoyDatePickView alloc]init];
}
@end
