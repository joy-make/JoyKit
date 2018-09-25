//
//  JoyCellBaseModel+Type.h
//  testConfigApp_Example
//
//  Created by Joymake on 2018/6/27.
//  Copyright © 2018年 joy-make. All rights reserved.
//

typedef NS_ENUM(NSInteger,KTestModelType) {
    KTestModelTypeLabel,
    KTestModelTypeText,
    KTestModelTypeAvatar,
    KTestModelTypeSwitch
};
#import "JoyCellBaseModel.h"

@interface JoyCellBaseModel (Type)
+(JoyCellBaseModel *)initWithStyle:(KTestModelType)type obj:(id)obj;
@end
