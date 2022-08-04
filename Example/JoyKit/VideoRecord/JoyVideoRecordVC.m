//
//  JoyVideoRecordVC.m
//  JoyKit_Example
//
//  Created by joy on 2022/7/29.
//  Copyright © 2022 joy-make. All rights reserved.
//

#import "JoyVideoRecordVC.h"
#import "JoyRecordView.h"

@interface JoyVideoRecordVC ()
@property (nonatomic,strong)JoyRecordView *recoreView;

@end

@implementation JoyVideoRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.recoreView];
    MAS_CONSTRAINT(self.recoreView, make.edges.mas_equalTo(self.view););
}

-(JoyRecordView *)recoreView{
    return _recoreView = _recoreView?:JoyRecordView.new;
}
@end
