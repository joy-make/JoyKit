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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 200, 80)];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderWidth = 1;
    label.layer.cornerRadius = 5;
    label.layer.borderColor = UIColor.orangeColor.CGColor;
    label.layer.masksToBounds = true;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = UIColor.darkTextColor;
    label.numberOfLines = 3;
    [self.view addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 420, 200, 200)];
    imageView.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/1488115-aa118ca3e324244f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/620"]]];
    [self.view addSubview:imageView];
    
    UIView *whiteBackView = [[UIView alloc]initWithFrame:CGRectMake(100, 80, 200, 200)];
    whiteBackView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
    whiteBackView.layer.cornerRadius =10;
    
    [self.view addSubview:whiteBackView];
    
    UIView *centerCirecleView = [[UIView alloc]initWithFrame:CGRectMake(90, 90, 20, 20)];
    centerCirecleView.layer.cornerRadius = 10;
    centerCirecleView.layer.borderColor = UIColor.orangeColor.CGColor;
    centerCirecleView.layer.borderWidth = 1;
    [whiteBackView addSubview:centerCirecleView];

    UIView *puppleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    puppleView.layer.cornerRadius = 10;
    puppleView.backgroundColor = UIColor.greenColor;
    [whiteBackView addSubview:puppleView];

    [JoyCoreMotion sharedInstance].screenOrentationBlock = ^(UIDeviceOrientation orientation,CMDeviceMotion *motion) {
        label.text = [NSString stringWithFormat:@"X偏移:%f \nY偏移:%f \nZ偏移:%f",motion.gravity.x,motion.gravity.y,motion.gravity.z];
        puppleView.center = CGPointMake(-100*(motion.gravity.x-1), 100*(motion.gravity.y+1));
    };
    
    [[JoyCoreMotion sharedInstance] startMotionManager:YES motionUpdateInterval:1/20];
}

-(void)dealloc{
    [[JoyCoreMotion sharedInstance] stopDetect];
}


@end
