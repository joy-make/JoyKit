//
//  JoyCoreMotionVC.m
//  JoyKit_Example
//
//  Created by joy on 2022/7/27.
//  Copyright © 2022 joy-make. All rights reserved.
//

#import "JoyCoreMotionVC.h"
#import <JoyCoreMotion.h>
#import <CoreMotion/CoreMotion.h>

@interface JoyCoreMotionVC ()

@end

@implementation JoyCoreMotionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    self.title = @"陀螺仪";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 200, 60)];
    label.layer.borderWidth = 1;
    label.layer.cornerRadius = 5;
    label.layer.borderColor = UIColor.orangeColor.CGColor;
    label.layer.masksToBounds = true;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = UIColor.darkTextColor;
    label.numberOfLines = 3;
    [self.view addSubview:label];
    [JoyCoreMotion sharedInstance].screenOrentationBlock = ^(UIDeviceOrientation orientation,CMDeviceMotion *motion) {
        label.text = [NSString stringWithFormat:@"orientationX:%f \norientationY:%f \norientationZ:%f",motion.gravity.x,motion.gravity.y,motion.gravity.z];
    };

    [[JoyCoreMotion sharedInstance] startMotionManager:YES motionUpdateInterval:1/50];

}


@end
