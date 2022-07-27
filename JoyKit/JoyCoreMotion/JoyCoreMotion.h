//
//  JoyCoreMotion.h
//  LW
//
//  Created by joymake on 2017/5/16.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMDeviceMotion;
@interface JoyCoreMotion : NSObject
@property (nonatomic, copy) void (^screenOrentationBlock)(UIDeviceOrientation orientation,CMDeviceMotion *motion);



+ (instancetype)sharedInstance;

- (void)startMotionManager:(BOOL)isRecordingVideo;

//加速计采样频率 10-20:适合于确定设备当前的方向矢量  30-60:适用于游戏和其他应用程序，使用加速计实时用户输入   70-100:适用于检测高频运动，如检测用户敲击设备或快速摇动设备
- (void)startMotionManager:(BOOL)isRecordingVideo motionUpdateInterval:(CGFloat)interval;

- (void)stopDetect;

@end
