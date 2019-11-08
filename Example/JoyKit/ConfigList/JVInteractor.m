//
//  JVInteractor.m
//  JoyTool
//
//  Created by joymake on 2017/4/12.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JVInteractor.h"
#import "JoyKit.h"

@implementation JVInteractor

//获取section数据源
- (void)getDataSourceSuccess:(LISTBLOCK)list{

    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        int i = 0;
        while (i++<100) {
            NSLog(@"%@", [NSString stringWithFormat:@"apply😄%d",i]);
            [self.dataArrayM addObject:[self getSectionData]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            list?list(self.dataArrayM):nil;
        });
    });
}

//获取section上的row数据源
- (JoySectionBaseModel *)getSectionData{
    JoySectionBaseModel *section =[[JoySectionBaseModel alloc] init];
    section.sectionHeadViewName = @"JVCustHeaderFooterView";
    section.sectionH = 30;
        JoyCellBaseModel *cellModel= (JoyCellBaseModel *)[self joyProtocolObjectFromStr:@"JoyCellBaseModel"];
        cellModel.cellName = @[JoyMiddleLabelCell,JoyLeftMiddleRightLabelCell,JoyLeftLabelRightPlaceHolderLabelCell][arc4random()%3];
        [self setCellWithModel:cellModel];
        [section.rowArrayM addObject:cellModel];

        JoyTextCellBaseModel *textCellModel= (JoyTextCellBaseModel *)[self joyProtocolObjectFromStr:@"JoyTextCellBaseModel"];
        textCellModel.cellName = @[JoyTextCell,JoyTextNoLabelCell,JoyLeftLabelTextViewCell,JoyTextViewCell][arc4random()%4];
//    textCellModel.cellName = @"JoyTextViewCell";

        [self setCellWithModel:textCellModel];
        [section.rowArrayM addObject:textCellModel];

        JoySwitchCellBaseModel *switchCellModel= (JoySwitchCellBaseModel *)[self joyProtocolObjectFromStr:@"JoySwitchCellBaseModel"];
        switchCellModel.cellName = JoySwitchSubTitleCell;
        switchCellModel.subTitle = @"副标题";
        [self setCellWithModel:switchCellModel];
        [section.rowArrayM addObject:switchCellModel];

        JoyImageCellBaseModel *imageCellModel= (JoyImageCellBaseModel *)[self joyProtocolObjectFromStr:@"JoyImageCellBaseModel"];
        imageCellModel.cellName = @[JoyLeftAvatarRightLabelCell,JoyLeftIconCell,JoyLeftLabelRightIconCell,JoyLeftIconTopBottomLabelCell,JoyLeftAvatarRightTopBottomLabel][arc4random()%5];
        [self setImageCellModel:imageCellModel];
        [section.rowArrayM addObject:imageCellModel];
    return section;
}

- (void)setCellWithModel:(JoyCellBaseModel *)cellModel{
    cellModel.title =cellModel.placeHolder= [NSString stringWithFormat:@"这是一个%@cell",cellModel.cellName];
    cellModel.titleColor = @"0x347AEB";
    cellModel.subTitleColor = @"0x222222";
    cellModel.backgroundColor = @"0xee88FF";
    cellModel.accessoryType = arc4random()%4;
            cellModel.canMove = YES;
    cellModel.subTitle = [NSString stringWithFormat:@"model%@",NSStringFromClass(cellModel.class)];
    cellModel.editingStyle = arc4random()%3;
    cellModel.tapAction = @"tapAction";
}

- (void)setImageCellModel:(JoyImageCellBaseModel *)cellModel{
    [self setCellWithModel:cellModel];
    cellModel.viewShape = EImageTypeRound;
    cellModel.placeHolderImageStr = @"joymakeHead.jpg";
//    cellModel.avatarBundleName = JoyToolBundle;
}

@end
