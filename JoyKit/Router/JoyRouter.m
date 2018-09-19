//
//  JoyRouter.m
//  TestScheme2
//
//  Created by Joymake on 2018/9/18.
//  Copyright © 2018年 Joymake. All rights reserved.
//

#import "JoyRouter.h"
#import <UIKit/UIKit.h>

@implementation JoyRouter

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [JoyRouter sharedInstance];
}

+ (instancetype)sharedInstance {
    static JoyRouter *inst;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        inst = [[super allocWithZone:NULL] init];
    });
    return inst;
}

#pragma mark 通信协议实现
-(void)routerModule:(NSString *)module path:(NSString *)path actionType:(JoyRouteActionType)actionType parameter:(NSDictionary *)params block:(JoyRouteBlock)block{
    NSObject <JoyRouteProtocol>*obj = (NSObject <JoyRouteProtocol>*)[self getObjWithClassStr:path];
    if(obj){
        if([obj respondsToSelector:@selector(routeParam:block:)])
            [obj routeParam:params block:block];
        
            switch (actionType) {
            case JoyRouteActionTypePush:
                [[self getNav] pushViewController:(UIViewController *)obj animated:YES];
                break;
                
            case JoyRouteActionTypePresent:
                [[self getNav] presentViewController:(UIViewController *)obj animated:YES completion:nil];
                break;
                
            case JoyRouteActionTypePop:{
                UIViewController *vc = [self getPopToVC:path];
                vc?[[self getNav] popToViewController:vc animated:YES]:[[self getNav] popViewControllerAnimated:YES];
            }
                break;
                
            case JoyRouteActionTypeDismiss:
                [[self getNav] dismissViewControllerAnimated:YES completion:nil];
                break;
            default:
                break;
        }
    }
}

#pragma mark 通过url方式打开app应用指定页面
-(BOOL)openNativeWithUrl:(NSURL *)url{
    if (url.scheme.length && url.host.length) {
        NSMutableDictionary *param = [self resolveUrlQuery:url.query];
        [self routerModule:@"" path:url.host actionType:JoyRouteActionTypePush parameter:param block:^(NSDictionary *params) {
        }];
        return YES;
    }
    return NO;
}

#pragma mark 解析urlQuery参数
- (NSMutableDictionary *)resolveUrlQuery:(NSString *)query{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if(query){
        NSArray *params = [query componentsSeparatedByString:@"&"];
        for (NSString *keyValueStr in params) {
            NSArray *list = [keyValueStr componentsSeparatedByString:@"="];
            if(list.count==2){
                [param setObject:[list.lastObject stringByRemovingPercentEncoding] forKey:list.firstObject];
            }
        }
    }
    return param;
}

-(NSObject *)getObjWithClassStr:(NSString *)classStr{
    NSObject *obj = [[NSClassFromString(classStr) alloc]init];
    return obj;
}

#pragma mark 获取栈内视图控制器
- (UIViewController *)getPopToVC:(NSString *)vcName{
    for (UIViewController *vc in [self getNav].viewControllers) {
        if ([NSStringFromClass(vc.class) isEqualToString:vcName]) {
            return vc;
        }
    }
    return nil;
}

#pragma mark 获取导航栈
- (UINavigationController *)getNav{
    if([[UIApplication sharedApplication].keyWindow.rootViewController isMemberOfClass:UITabBarController.class]){
        return [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    }else if ([[UIApplication sharedApplication].keyWindow.rootViewController isMemberOfClass:UINavigationController.class]){
        return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    }else{
        return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    }
}
@end
