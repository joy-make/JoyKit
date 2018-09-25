//
//  JVPresenter.h
//  JoyTool
//
//  Created by joymake on 2017/4/12.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyKit.h"

@class JVInteractor,JoyTableAutoLayoutView;
@interface JVPresenter : JoyPresenterBase
@property (nonatomic,strong)JoyTableAutoLayoutView *layoutView;
@property (nonatomic,strong)JVInteractor *interactor;
@end
