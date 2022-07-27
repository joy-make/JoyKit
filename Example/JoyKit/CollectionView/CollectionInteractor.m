//
//  CollectionInteractor.m
//  JoyKit_Example
//
//  Created by Joymake on 2019/1/21.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import "CollectionInteractor.h"
#import "JoyCellBaseModel.h"
#import "JoySectionBaseModel.h"

@implementation CollectionInteractor

-(void)getDataSource:(VOIDBLOCK)success{
    for (int j=0; j<2; j++) {
    int i = 0;
    JoySectionBaseModel *section = [[JoySectionBaseModel alloc]init];
    section.sectionHeadViewName = @"JoyCollectionReusableView";
//    section.sectionFootViewName = @"JoyCollectionReusableView";

    section.sectionTitle = @"测试  ";
    while (i++<22) {
        JoyImageCellBaseModel *model = [[JoyImageCellBaseModel alloc]init];
        model.title = i%8==0?@"  testtesttesttesttesttesttesttest  ":@" test  ";
        model.avatar = @"https://cdn.smart.sqbj.com/icon/portal/gonggao.png";
//        model.cellName = i%6==0?@"JoyCollectionTextCell":@"JoyImageCollectionViewCell";
        model.cellName = @"JoyCollectionTextCell";

        [section.rowArrayM addObject:model];
    }
    [self.dataArrayM addObject:section];
    }
    success?success():nil;
}

@end
