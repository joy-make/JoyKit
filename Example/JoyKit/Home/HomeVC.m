//
//  HomeVC.m
//  JoyKit_Example
//
//  Created by Joymake on 2019/2/15.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import "HomeVC.h"
#import <JoyKit/JoyKit.h>
@interface HomeVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *layoutView;

@end

@implementation HomeVC

-(JoyTableAutoLayoutView *)layoutView{
    return _layoutView = _layoutView?:[[JoyTableAutoLayoutView alloc]initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *list = [self getDataSource];
    [self setDefaultConstraintWithView:self.layoutView andTitle:@""];
    self.layoutView.setDataSource(list)
    .reloadTable()
    .cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [self action:tapAction];
    });
};

- (NSMutableArray *)getDataSource{
    NSArray *list = @[@{@"title":@"基本列表",@"tapAction":@"JoyViewController"},
                      @{@"title":@"collectionView",@"tapAction":@"CollectionVC"},
                      @{@"title":@"plist配置",@"tapAction":@"SCViewController"}
                      ];
    JoySectionBaseModel *section = [[JoySectionBaseModel alloc]init];
    for (int i=0; i<list.count; i++) {
        JoyCellBaseModel *cellModel = [[JoyCellBaseModel alloc]init];
        cellModel.title = list[i][@"title"];
        cellModel.tapAction = list[i][@"tapAction"];
        cellModel.cellName = JoyMiddleLabelCell;
        [section.rowArrayM addObject:cellModel];
    }
    return [NSMutableArray arrayWithObjects:section, nil];
}

- (void)action:(NSString *)tapAction{
    UIViewController *vc = [[NSClassFromString(tapAction) alloc]init];
    [self goVC:vc];
}
@end
