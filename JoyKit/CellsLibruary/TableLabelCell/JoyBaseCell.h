//
//  JoyBaseCell.h
//  Toon
//
//  Created by joymake on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

//十六进制颜色赋值
static const float KCellTopOffset =10;
static const float KCellLeadingOffset =15;
static const float KCellTrailingOffset =15;

#import "UIView+JoyCategory.h"
#import "JoyCellBaseModel.h"
#import "UIImageView+JoyCategory.h"
#import "UITableViewCell+JoyCell.h"
/**
 基类cell
 */

@interface JoyBaseCell : UITableViewCell<JoyCellProtocol>
@property (assign, nonatomic) NSInteger maxNum;

@end
