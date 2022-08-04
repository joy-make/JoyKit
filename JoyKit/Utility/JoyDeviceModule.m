//
//  JoyDeviceModule.m
//  Property_pro
//
//  Created by Joymake on 2018/1/29.
//  Copyright © 2018年 YH. All rights reserved.
//

#import "JoyDeviceModule.h"
#import <WebKit/WebKit.h>

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
#pragma clang diagnostic push
//#pragma clang diagnostic ignored  "-Wincompatible-pointer-types"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
static WKWebView *webView;

+ (void)openDeviceFunctionWithUrl:(NSURL *)url{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webView = [WKWebView new];
    });
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}
#pragma clang diagnostic pop

@end
