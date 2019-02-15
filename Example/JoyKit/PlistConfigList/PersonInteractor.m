//
//  PersonInteractor.m
//  testConfigApp_Example
//
//  Created by Joymake on 2018/6/25.
//  Copyright © 2018年 joy-make. All rights reserved.
//

#import "PersonInteractor.h"
#import <JoyKit/Joy.h>
#import <MJExtension/MJExtension.h>
#import <JoyKit/JoyCellBaseModel.h>
#import <JoyKit/JoySectionBaseModel.h>
#import "JoyCellBaseModel+Type.h"

@implementation PersonInteractor

-(void)getPersonList:(VOIDBLOCK)success{
    [self getServiceData];
    [self getConfigData];
    success?success():nil;
}

- (void)getConfigData{
    JoySectionBaseModel *sectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:nil sectionH:0 sectionTitle:@""];

    NSArray *data = (NSArray *)[[self readLocalFileWithName:@"personDetail"] objectForKey:@"style"];
    for (NSDictionary *dict in data) {
        JoyCellBaseModel *cellModel = [JoyCellBaseModel initWithStyle:[dict[@"style"] integerValue] obj:dict];
        if(cellModel.changeKey){
            [cellModel isMemberOfClass:JoyCellBaseModel.class]? cellModel.subTitle = [self.person valueForKey:cellModel.changeKey]:nil;
            [cellModel isMemberOfClass:JoyTextCellBaseModel.class]? cellModel.subTitle = [self.person valueForKey:cellModel.changeKey]:nil;
            [cellModel isMemberOfClass:JoySwitchCellBaseModel.class]?((JoySwitchCellBaseModel*)cellModel).on = [[self.person valueForKey:cellModel.changeKey] boolValue]:nil;
            [cellModel isMemberOfClass:JoyImageCellBaseModel.class]?((JoyImageCellBaseModel*)cellModel).avatar = [self.person valueForKey:cellModel.changeKey]:nil;
        }
        cellModel.titleColor = @"#347AEB";
        cellModel.subTitleColor = @"#CCCCCC";
        [self.dataArrayM addObject:cellModel];
    }
}

- (void)getServiceData{
    NSDictionary *data = [[self readLocalFileWithName:@"personDetail"] objectForKey:@"data"];
    self.person = [Person mj_objectWithKeyValues:data];
}

-(void)checkRequired:(STRINGBLOCK)topicStr{
    if (!self.person.name.length) {
        topicStr(@"请输入姓名");
    }else if (!self.person.phone.length) {
        topicStr(@"请输入手机号码");
    }else if (!self.person.email.length) {
        topicStr(@"请输入邮箱地址");
    }
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}

-(NSArray *)sexList{
    return @[@[@"男",@"女"]];
}

-(NSArray *)likeList{
    return @[@[@"骑行",@"爬山",@"音乐",@"竞技游戏",@"美食",@"舞蹈",@"阅读"]];
}

- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

-(void)dealloc{
    
}
@end
