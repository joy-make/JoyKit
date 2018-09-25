//
//  JoyCellBaseModel+Type.m
//  testConfigApp_Example
//
//  Created by Joymake on 2018/6/27.
//  Copyright © 2018年 joy-make. All rights reserved.
//

#import "JoyCellBaseModel+Type.h"
#import <JoyKit/JoyKit.h>
#import <MJExtension/MJExtension.h>
#import <JoyKit/JoyCellBaseModel.h>

@implementation JoyCellBaseModel (Type)
+(JoyCellBaseModel *)initWithStyle:(KTestModelType)type obj:(id)obj{
    switch (type) {
        case KTestModelTypeLabel:
            return [JoyCellBaseModel mj_objectWithKeyValues:obj];
        case KTestModelTypeText:
            return [JoyTextCellBaseModel mj_objectWithKeyValues:obj];
        case KTestModelTypeAvatar:
            return [JoyImageCellBaseModel mj_objectWithKeyValues:obj];
        case KTestModelTypeSwitch:
            return [JoySwitchCellBaseModel mj_objectWithKeyValues:obj];
        default:
            return [JoyCellBaseModel mj_objectWithKeyValues:obj];
    }
}
@end
