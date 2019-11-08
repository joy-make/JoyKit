//
//  JoyInteractorBase.h
//  Toon
//
//  Created by joymake on 16/8/23.
//  Copyright © 2016年 Joy. All rights reserved.
//


#define KHeadSectionH 10
#define KNormalSectionH 40
#define KSepatatorInsetLeading 90

#import <Foundation/Foundation.h>
#import "Joy.h"

@protocol JoyInteractorProtocol <NSObject>

#pragma mark 请求数据
- (void)requestDataSource;

#pragma mark 请求数据带成功回调
- (void)requestDataSource:(VOIDBLOCK)success;

#pragma mark 请求数据带成功回调和失败回调
- (void)requestDataSource:(VOIDBLOCK)success failure:(ERRORBLOCK)failure;

@end

@interface JoyInteractorBase : NSObject<JoyInteractorProtocol>

@property (nonatomic,strong)NSMutableArray *dataArrayM;

@end


