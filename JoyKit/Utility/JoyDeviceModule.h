//
//  JoyDeviceModule.h
//  Property_pro
//
//  Created by Joymake on 2018/1/29.
//  Copyright © 2018年 YH. All rights reserved.
//  系统原生功能的唤起
//  使用方法:如打电话 [JoyDeviceModule callWithPhoneStr:@"10010"];

#import <Foundation/Foundation.h>

@interface JoyDeviceModule : NSObject

/**
 打电话
 @param phone 电话号码
 */
+ (void)callWithPhoneStr:(NSString *)phone;

/**
 发信息
 @param sms 信息接收者
 */
+ (void)smsWithSmsStr:(NSString *)sms;

/**
 发邮件
 @param email 收件箱地址
 */
+ (void)emailWithEmailStr:(NSString *)email;

/**
 自定义设备功能
 @param url 系统url
 */
+ (void)openDeviceFunctionWithUrl:(NSURL *)url;
@end
