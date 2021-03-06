//
//  JoyRouter.m
//  TestScheme2
//
//  Created by Joymake on 2018/9/18.
//  Copyright © 2018年 Joymake. All rights reserved.
//

#import "JoyRouter.h"
#import <UIKit/UIKit.h>
#import "JoyRouterUtil.h"

@interface JoyRouter()
@property (nonatomic,strong)JoyRouterUtil *routerUtil;
@property (nonatomic,copy)NSString *scheme;
@end

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

-(void)configScheme:(NSString *)scheme{
    _scheme = scheme;
}

#pragma mark 通信协议实现
-(void)routerModule:(NSString *)module path:(NSString *)path actionType:(JoyRouteActionType)actionType parameter:(NSDictionary *)params block:(JoyRouteBlock)block{
    NSString *excutor = [self.routerUtil getExcutorWithModule:module path:path];
    NSObject <JoyRouteProtocol>*obj = (NSObject <JoyRouteProtocol>*)[self getObjWithClassStr:excutor];
    if(obj){
        if([obj respondsToSelector:@selector(routeParam:block:)])
            [obj routeParam:params block:block];
            switch (actionType) {
            case JoyRouteActionTypePush:
                {
                    UIViewController *vc = (UIViewController *)obj;
                    vc.hidesBottomBarWhenPushed = YES;
                    [[self getNav] pushViewController:(UIViewController *)obj animated:YES];
                }
                break;
                
            case JoyRouteActionTypePresent:
                [[self getNav] presentViewController:(UIViewController *)obj animated:YES completion:nil];
                break;
                
            case JoyRouteActionTypePop:{
                UIViewController *vc = [self getPopToVC:NSStringFromClass(obj.class)];
                vc?[[self getNav] popToViewController:vc animated:YES]:[[self getNav] popViewControllerAnimated:YES];
            }
                break;
                
            case JoyRouteActionTypeDismiss:
                [[self getNav] dismissViewControllerAnimated:YES completion:nil];
                break;
            case JoyRouteActionTypeSetRooter:
                [UIApplication sharedApplication].keyWindow.rootViewController = (UIViewController *)obj;
                break;
            case  JoyRouteActionTypeSetNavRooter:
                [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:(UIViewController *)obj];
                break;
            default:
                break;
        }
    }else{
        NSError *error = [NSError errorWithDomain:self.scheme code:0 userInfo:@{@"message":@"未找到指定页面"}];
        block?block(nil,error):nil;
    }
}

#pragma mark 通过url方式打开app应用指定页面
-(BOOL)openNativeWithUrl:(NSURL *)url{
    if (url.scheme.length && url.host.length && [url.scheme isEqualToString:self.scheme]) {
        NSMutableDictionary *param = [self.routerUtil resolveUrlQuery:url];
        NSString *module = [self.routerUtil getModuleStrFromUrl:url];
        NSString *path = [self.routerUtil getPathStrFromUrl:url];
        JoyRouteActionType actionType = [self.routerUtil getActionTypeWithModule:module path:path];
        [self routerModule:module path:path actionType:actionType parameter:param block:nil];
        return (module && path);
    }
    return NO;
}

-(BOOL)openNativeWithUrl:(NSURL *)url actionType:(JoyRouteActionType)actionType block:(JoyRouteBlock)block{
    if (url.scheme.length && url.host.length && [url.scheme isEqualToString:self.scheme]) {
        NSMutableDictionary *param = [self.routerUtil resolveUrlQuery:url];
        NSString *module = [self.routerUtil getModuleStrFromUrl:url];
        NSString *path = [self.routerUtil getPathStrFromUrl:url];
        [self routerModule:module path:path actionType:actionType parameter:param block:block];
        return (module && path);
    }
    return NO;
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
    if([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:UITabBarController.class]){
        return [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    }else if ([[UIApplication sharedApplication].keyWindow.rootViewController isMemberOfClass:UINavigationController.class]){
        return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    }else{
        return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    }
}

-(JoyRouterUtil *)routerUtil{
    return _routerUtil = _routerUtil?:[[JoyRouterUtil alloc]init];
}
@end
