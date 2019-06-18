//
//  JoyRouter.h
//  TestScheme2
//
//  Created by Joymake on 2018/9/18.
//  Copyright © 2018年 Joymake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JoyRouterHeader.h"

typedef void (^JoyRouteBlock) (NSDictionary *params,NSError *error);

@protocol JoyRouteProtocol

/**
 协议传参和block回调
 @param param 入参
 @param block 回调
 */
- (void)routeParam:(NSDictionary *)param block:(JoyRouteBlock )block;

@end

@interface JoyRouter : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,readonly)NSString *scheme;

/**
 配置scheme
 @param scheme scheme
 */
- (void)configScheme:(NSString *)scheme;

/**
 通信方法
 @param module 业务模块名
 @param path 业务模块内业务路径
 @param actionType 通信方式
 @param params 入参
 @param block 回调
 */
- (void)routerModule:(NSString *)module path:(NSString *)path actionType:(JoyRouteActionType)actionType parameter:(NSDictionary *)params block:(JoyRouteBlock)block;

/**
 url通信
 @param url 协议数据。joy://person/detail?title=test&name=tixi
 */
- (BOOL)openNativeWithUrl:(NSURL *)url;

/**
 url通信(带回调功能)
 @param url 协议数据。joy://person/detail?title=test&name=tixi
 @param actionType 通信方式
 @param block 回调
 */
- (BOOL)openNativeWithUrl:(NSURL *)url actionType:(JoyRouteActionType)actionType block:(JoyRouteBlock)block;

/**
 获取当前app Root
 @return Root
 */
- (UINavigationController *)getNav;

@end
