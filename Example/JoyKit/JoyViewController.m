//
//  JoyViewController.m
//  JoyKit
//
//  Created by joy-make on 01/15/2018.
//  Copyright (c) 2018 joy-make. All rights reserved.
//

#import "JoyViewController.h"
#import "JVPresenter.h"
#import "JVInteractor.h"

@interface JoyViewController ()
@property (nonatomic,strong)JoyTableAutoLayoutView *layoutView;
@property (nonatomic,strong)JVInteractor *interactor;
@property (nonatomic,strong)JVPresenter  *presenter;
@end

@implementation JoyViewController

-(JoyTableAutoLayoutView *)layoutView{
    return _layoutView = _layoutView?:[[JoyTableAutoLayoutView alloc]initWithFrame:CGRectZero];
}

-(JVInteractor *)interactor{
    return _interactor = _interactor?:[[JVInteractor alloc]init];
}

-(JVPresenter *)presenter{
    if (!_presenter)
    {
        _presenter = [[JVPresenter alloc]initWithView:self.view];
        _presenter.layoutView = self.layoutView;
        _presenter.interactor = self.interactor;
    }
    return _presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultConstraintWithView:self.layoutView andTitle:@"10000条随机数据测试"];
    [self setRightNavItemWithTitle:@"edit"];
    [self.presenter reloadDataSource];
}

-(void)leftNavItemClickAction{
    [super leftNavItemClickAction];
    [JoyAlert showWithMessage:@"你要往哪儿跳,默认返回上一级页面"];
}

-(void)rightNavItemClickAction{
    [super rightNavItemClickAction];
    [self.presenter rightNavItemClickAction];
}
@end
