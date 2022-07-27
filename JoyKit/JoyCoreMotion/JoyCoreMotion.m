//
//  JoyCoreMotion.m
//  LW
//
//  Created by joymake on 2017/5/16.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyCoreMotion.h"
#import <CoreMotion/CoreMotion.h>

@interface JoyCoreMotion ()
@property (nonatomic, strong) CMMotionManager * motionManager;
@property (nonatomic, assign) BOOL isRecordingVideo;
@end

@implementation JoyCoreMotion
+ (instancetype)sharedInstance
{
    static JoyCoreMotion *joyCoremotion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{joyCoremotion = [[[self class] alloc]init];});
    return joyCoremotion;
}

-(CMMotionManager *)motionManager{
    return _motionManager = _motionManager?:[[CMMotionManager alloc] init];
}

- (void)startMotionManager:(BOOL)isRecordingVideo{
    [self startMotionManager:isRecordingVideo motionUpdateInterval:1/15.0];
}

//加速计采样频率 10-20:适合于确定设备当前的方向矢量  30-60:适用于游戏和其他应用程序，使用加速计实时用户输入   70-100:适用于检测高频运动，如检测用户敲击设备或快速摇动设备
- (void)startMotionManager:(BOOL)isRecordingVideo motionUpdateInterval:(CGFloat)interval{
    self.isRecordingVideo = isRecordingVideo;
    self.motionManager.deviceMotionUpdateInterval = interval?:1/15.0;
    _motionManager.deviceMotionAvailable?  [self startDeviceMitionUpdate]:[self setMotionManager:nil];
}

- (void)startDeviceMitionUpdate{
    __weak __typeof (&*self)weakSelf = self;
    [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler: ^(CMDeviceMotion *motion, NSError *error){
        [weakSelf performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
    }];

}

- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion{
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    double z = deviceMotion.gravity.z;
    
    int orientation = 0;
    if (self.isRecordingVideo)
    {
        if (fabs(y) >= fabs(x))
        {orientation = y>= 0? UIDeviceOrientationPortraitUpsideDown:UIDeviceOrientationPortrait;}
        else
        {orientation = x>=0?  UIDeviceOrientationLandscapeRight:UIDeviceOrientationLandscapeLeft;}
        self.screenOrentationBlock?self.screenOrentationBlock(orientation,deviceMotion):nil;
    }
    else
    {
        if (fabs(z) < 0.6)
        {
        if (fabs(y) >= fabs(x))
        {orientation = y >= 0? UIDeviceOrientationPortraitUpsideDown:UIDeviceOrientationPortrait;}
        else
        {orientation = x >= 0? UIDeviceOrientationLandscapeRight:UIDeviceOrientationLandscapeLeft;}
        self.screenOrentationBlock?self.screenOrentationBlock(orientation,deviceMotion):nil;
        }
    }
}

- (void)stopDetect{
    [_motionManager stopDeviceMotionUpdates];
    _motionManager = nil;
}

@end
