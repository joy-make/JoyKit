//
//  JoyLocationManager.h
//  LW
//
//  Created by joymake on 2017/6/9.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Joy.h"
@interface JoyLocationManager : NSObject
//检测授权并设置更新模式
@property (nonatomic,readonly)JoyLocationManager        *(^checkAuthorization)(BOOL backGroundModel);
@property (nonatomic,readonly)JoyLocationManager        *(^startLocation)(void);
@property (nonatomic,readonly)JoyLocationManager        *(^stopLocation)(void);
@property (nonatomic,copy)JoyLocationManager            *(^locationSuccess)(IDBLOCK block);
@property (nonatomic,copy)JoyLocationManager            *(^locationError)(ERRORBLOCK block);
@property (nonatomic,copy)JoyLocationManager            *(^reverseGEOCodeLocation)(IDBLOCK block);
@property (nonatomic,readonly)JoyLocationManager        *(^startUpdateHeading)(void);
@property (nonatomic,copy)JoyLocationManager            *(^headUpdateSuccess)(FLOATBLOCK block);
@property (nonatomic,readonly)JoyLocationManager        *(^stopUpdateHeading)(void);
@end
