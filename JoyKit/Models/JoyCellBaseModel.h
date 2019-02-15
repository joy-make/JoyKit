//
//  JoyCellBaseModel
//  Toon
//
//  Created by joymake on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.

//  禁止随意扩充此类⚠️
//  禁止随意扩充此类⚠️
//  禁止随意扩充此类⚠️
//  禁止随意扩充此类⚠️
//  所有业务类字段和方法请在子类中实现⚠️

#import <Foundation/Foundation.h>
#import "JoyCellModelProtocol.h"

@interface JoyCellBaseModel : NSObject<JoyCellModelProtocol>
@end

#pragma mark 文本类型model
@interface JoyTextCellBaseModel : JoyCellBaseModel<JoyTextCellModelProtocol>
@end

#pragma mark 图片类型model
@interface JoyImageCellBaseModel : JoyCellBaseModel<JoyImageCellModelProtocol>
@end

#pragma mark 开关类型model
@interface JoySwitchCellBaseModel : JoyCellBaseModel
@property (nonatomic,assign) BOOL  on;
@end

@interface JoyTableCollectionCellBaseModel: JoyCellBaseModel
@property (nonatomic,strong)NSMutableArray *itemList;
@end


