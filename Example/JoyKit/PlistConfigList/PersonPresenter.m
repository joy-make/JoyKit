//
//  PersonPresenter.m
//  testConfigApp_Example
//
//  Created by Joymake on 2018/6/25.
//  Copyright © 2018年 joy-make. All rights reserved.
//

#import "PersonPresenter.h"
#import "PersonInteractor.h"
#import <JoyKit/JoyKit.h>

@implementation PersonPresenter

-(void)reloadDataSource{
    __weak __typeof(&*self)weakSelf = self;
    [self.interactor getPersonList:^{
        weakSelf.tableView.setDataSource(weakSelf.interactor.dataArrayM).reloadTable();
    }];
}

-(void)setPickView:(JoyPickerView *)pickView{
    _pickView = pickView;
    __weak __typeof(&*self)weakSelf = self;
    _pickView.EntryBtnClickBlock = ^{
        [weakSelf pickSelectEntryClick];
    };
}

-(void)setDatePickView:(JoyDatePickView *)datePickView{
    _datePickView = datePickView;
    __weak __typeof(&*self)weakSelf = self;
    _datePickView.entryClickBlock = ^(NSString *selectDate) {
        [weakSelf dateSelectEntryClick:selectDate];
    };
}

-(void)setTableView:(JoyTableAutoLayoutView *)tableView{
    _tableView = tableView;
    __weak __typeof(&*self)weakSelf = self;
    _tableView.cellTextEiditEnd(^(NSIndexPath *indexPath, NSString *content, NSString *key) {
        key?[weakSelf.interactor.person setValue:content forKey:key]:nil;
    })
    .cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [weakSelf performTapAction:tapAction];
    })
//    .setTableEdit(YES)
    .cellEiditAction(^(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath) {
        [JoyAlert showWithMessage:@"编辑事件"];
    })
    .cellMoveAction(^(NSIndexPath *sourceIndexPath,NSIndexPath *toIndexPath){
        [JoyAlert showWithMessage:@"挪移事件"];
    })
    .cellTextCharacterHasChanged(^(NSIndexPath *indexPath, NSString *content, NSString *key){
        //字符发生变化
    });
}

-(void)rightNavItemClickAction{
    HIDE_KEYBOARD;
    [self.interactor checkRequired:^(NSString *str) {
        [JoyAlert showWithMessage:str];
    }];
}

#pragma MARK 日期选择
- (void)dateSelectEntryClick:(NSString *)selectDate
{
    JoySectionBaseModel *sectionModel = self.interactor.dataArrayM[self.tableView.currentSelectIndexPath.section];
    JoyTextCellBaseModel *model = sectionModel.rowArrayM[self.tableView.currentSelectIndexPath.row];
    model.subTitle = selectDate;
    [self.interactor.person setValue:selectDate forKey:model.changeKey];
    [self.tableView reloadRow:self.tableView.currentSelectIndexPath];
}

#pragma mark 选择类型回调事件
-(void)pickSelectEntryClick{
    JoySectionBaseModel *sectionModel = self.interactor.dataArrayM[self.tableView.currentSelectIndexPath.section];
    JoyTextCellBaseModel *model = sectionModel.rowArrayM[self.tableView.currentSelectIndexPath.row];
    NSInteger selectRow = [self.pickView.pickerView selectedRowInComponent:0];
    if([model.changeKey isEqualToString:@"sex"]){
        model.subTitle = self.interactor.sexList.firstObject[selectRow];
    }else{
        model.subTitle = self.interactor.likeList.firstObject[selectRow];
    }
    [self.interactor.person setValue:model.subTitle forKey:model.changeKey];
    [self.tableView reloadRow:self.tableView.currentSelectIndexPath];
}

#pragma mark 选择性别
- (void)selectSex{
    [self.pickView reloadPickViewWithDataSource:self.interactor.sexList];
    [self.pickView showPickView];
}

#pragma mark 选择爱好
-(void)selectLike{
    [self.pickView reloadPickViewWithDataSource:self.interactor.likeList];
    [self.pickView showPickView];
}

#pragma mark 选择生日
-(void)selectBirthday{
    [self.datePickView showPickView];
}

#pragma mark 长按
-(void)longPressAction{
    [JoyAlert showWithMessage:[NSString stringWithFormat:@"长按了第%d列cell",self.tableView.currentSelectIndexPath.row]];
}

- (void)selectAvatar{
    [JoyAlert showWithMessage:@"选取头像"];
}

-(void)dealloc{
    
}
@end
