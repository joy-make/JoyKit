//
//  JoyDeviceOrientationVC.m
//  JoyKit_Example
//
//  Created by joy on 2022/7/27.
//  Copyright © 2022 joy-make. All rights reserved.
//

#import "JoyDeviceOrientationVC.h"
#import <UIDevice+JoyCategory.h>

@interface JoyDeviceOrientationVC ()

@end

@implementation JoyDeviceOrientationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"强制设备旋转";
    self.view.backgroundColor = UIColor.orangeColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [btn setFrame:CGRectMake(150, 200, 100, 100)];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnAction:(UIButton *)btn{
    [UIDevice changeDeviceOrientation:btn.selected?UIInterfaceOrientationPortrait:UIInterfaceOrientationLandscapeLeft];
    btn.selected = !btn.selected;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}


@end
