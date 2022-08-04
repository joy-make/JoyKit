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
                      @{@"title":@"json配置UI以及点击事件",@"tapAction":@"SCViewController"},
                      @{@"title":@"二维码扫描",@"tapAction":@"JoyQRCodeScanVC"},
                      @{@"title":@"AVFoundation短视频录制、播放预览、存储相册",@"tapAction":@"JoyVideoRecordVC"},
                      @{@"title":@"播放器",@"tapAction":@"PlayerListVC"},
                      @{@"title":@"CAAnimation动画",@"tapAction":@"JoyAnimationVC"},
                      @{@"title":@"设备强制横竖屏",@"tapAction":@"JoyDeviceOrientationVC"},
                      @{@"title":@"陀螺仪水平仪",@"tapAction":@"JoyCoreMotionVC"},
                      @{@"title":@"字符串生成条形码和二维码并存储相册",@"tapAction":@"JoyQRCodeGenerateVC"},
                      ];
    JoySectionBaseModel *section = [[JoySectionBaseModel alloc]init];
    for (int i=0; i<list.count; i++) {
        JoyCellBaseModel *cellModel = [[JoyCellBaseModel alloc]init];
        cellModel.title = list[i][@"title"];
        cellModel.titleColor = [NSString stringWithFormat:@"%x",arc4random()%0xFFFFFF];
        cellModel.tapAction = list[i][@"tapAction"];
        cellModel.cellName = JoyMiddleLabelCell;
        [section.rowArrayM addObject:cellModel];
    }
    return [NSMutableArray arrayWithObjects:section, nil];
}

- (void)action:(NSString *)tapAction{
    if ([tapAction isEqualToString:@"JoyQRCodeScanVC"])
        [self qrScanAction];
    else
        [self goVC:NSClassFromString(tapAction).new];
}



-(void)qrScanAction{
#if TARGET_IPHONE_SIMULATOR  //模拟器
    [JoyAlert showWithMessage:@"模拟器无法启用扫码功能,请切换真机后再试"];
#elif TARGET_OS_IPHONE      //真机
    JoyQRCodeScanVC *vc = [[JoyQRCodeScanVC alloc]init];
    [vc setScanSize:CGSizeMake(300, 300) cornerRadius:20 color:[UIColor greenColor]];
    [self presentViewController:vc animated:true completion:nil];
    __weak __typeof(&*self)weakSelf = self;
    [vc startScan:^(NSString *str) {
        [[JoyAlert shareAlert]showalertWithMessage:str alertBlock:nil];;
    } backBlock:^{
        [weakSelf dismissViewControllerAnimated:true completion:nil];
    }];
#endif
//    播放视频
//    __weak typeof(self)weakSelf = self;
//    NSString *mergeUrlStr = [JoyMediaRecordPlay generateFilePathWithType:@"mp4"];
//    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"video0" ofType:@"MP4"];
//    NSURL *recordUrl = [NSURL fileURLWithPath:urlStr];
//    [JoyMediaRecordPlay mergeAndExportVideosAtFileURLs:recordUrl newUrl:mergeUrlStr widthHeightScale:SCREEN_W/SCREEN_H presetName:AVAssetExportPresetMediumQuality mergeSucess:^{
//        JoyPlayerView * playView= [[JoyPlayerView alloc]initWithFrame:self.view.bounds];
//        playView.backgroundColor = JOY_blackColor;
//        [[UIApplication sharedApplication].keyWindow addSubview:playView];
//        playView.playUrl = [NSURL fileURLWithPath:mergeUrlStr];
//    }];

}
@end
