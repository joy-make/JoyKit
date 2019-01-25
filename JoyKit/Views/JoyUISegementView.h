//
//  JoyUISegementView.h
//  CustomSegMent
//
//  Created by joymake on 16/7/7.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "UIView+JoyCategory.h"

typedef void (^SegmentChangedBlock)(NSInteger selectIndex);

@interface JoyUISegementView : UIView
@property (nonatomic,readonly)JoyUISegementView    *(^setSegmentItems)(NSArray *segmentItems);
@property (nonatomic,readonly)JoyUISegementView    *(^setSeparateColor)(UIColor *separateColor);
@property (nonatomic,readonly)JoyUISegementView    *(^setSelectColor)(UIColor *selectColor);
@property (nonatomic,readonly)JoyUISegementView    *(^setDeselectColor)(UIColor *deselectColor);
@property (nonatomic,readonly)JoyUISegementView    *(^setBottomSliderColor)(UIColor *bottomSliderColor);
@property (nonatomic,readonly)JoyUISegementView    *(^setIsDefaultNoSelect)(BOOL isDefaultNoSelect);
@property (nonatomic,readonly)JoyUISegementView    *(^segmentValuechangedBlock)(SegmentChangedBlock setmentChanged);
@property (nonatomic,assign)NSInteger selectIndex;
@end
