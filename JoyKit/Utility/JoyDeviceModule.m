//
//  JoyDeviceModule.m
//  Property_pro
//
//  Created by Joymake on 2018/1/29.
//  Copyright © 2018年 YH. All rights reserved.
//

#import "JoyDeviceModule.h"

@implementation JoyDeviceModule
#pragma mark 打电话
+ (void)callWithPhoneStr:(NSString *)phone{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phone]];
    [JoyDeviceModule openDeviceFunctionWithUrl:url];
}

#pragma mark 发短信
+(void)smsWithSmsStr:(NSString *)sms{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"smsto:%@",sms]];
    [JoyDeviceModule openDeviceFunctionWithUrl:url];
}

#pragma mark 发邮件
+(void)emailWithEmailStr:(NSString *)email{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@",email]];
    [JoyDeviceModule openDeviceFunctionWithUrl:url];
}

#pragma mark 浏览器
+(void)safariWithHttpStr:(NSString *)httpStr{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@",httpStr]];
    [JoyDeviceModule openDeviceFunctionWithUrl:url];
}

#pragma mark 打开设备功能
+ (void)openDeviceFunctionWithUrl:(NSURL *)url{
    static UIWebView *webView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webView = [UIWebView new];
    });
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
