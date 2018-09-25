//
//  PersonPresenter.h
//  testConfigApp_Example
//
//  Created by Joymake on 2018/6/25.
//  Copyright © 2018年 joy-make. All rights reserved.
//

#import "JoyPresenterBase.h"

@class JoyTableAutoLayoutView,PersonInteractor,JoyPickerView,JoyDatePickView;
@interface PersonPresenter : JoyPresenterBase
@property (nonatomic,strong)JoyTableAutoLayoutView *tableView;
@property (nonatomic,strong)PersonInteractor *interactor;
@property (nonatomic,strong)JoyPickerView *pickView;
@property (nonatomic,strong)JoyDatePickView *datePickView;
@end
