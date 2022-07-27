//
//  HomeVC.m
//  JoyKit_Example
//
//  Created by Joymake on 2019/2/15.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import "HomeVC.h"
#import <JoyKit/JoyKit.h>
#import <AVKit/AVKit.h>

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
                      @{@"title":@"table混合collection",@"tapAction":@"JoyTableCollectionVC"},
                      @{@"title":@"collectionView",@"tapAction":@"CollectionVC"},
                      @{@"title":@"模拟服务器plist配置列表以及点击事件",@"tapAction":@"SCViewController"},
                      @{@"title":@"二维码扫描",@"tapAction":@"QRCodeScanVC"},
                      @{@"title":@"播放器",@"tapAction":@"PlayerListVC"},
                      @{@"title":@"CAAnimation动画",@"tapAction":@"JoyAnimationVC"},
                      @{@"title":@"设备强制横竖屏",@"tapAction":@"JoyDeviceOrientationVC"},
                      @{@"title":@"陀螺仪",@"tapAction":@"JoyCoreMotionVC"},
                      
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
    JoyBaseVC *vc = [[NSClassFromString(tapAction) alloc]init];
    [self goVC:vc];
}
@end
