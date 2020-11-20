//
//  PlayerListVC.m
//  JoyKit_Example
//
//  Created by Joymake on 2020/9/5.
//  Copyright © 2020 joy-make. All rights reserved.
//

#import "PlayerListVC.h"
#import <JoyKit/JoyKit.h>
#import "PlayerCell.h"

@interface PlayerListVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *listView;
@property (nonatomic,weak)AVPlayer *player;
@end

@implementation PlayerListVC

-(JoyTableAutoLayoutView *)listView{
    return _listView = _listView?:[[JoyTableAutoLayoutView alloc]initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *list = [self getDataSource];
    [self setDefaultConstraintWithView:self.listView andTitle:@""];
    __weak __typeof(&*self)weakSelf = self;
    self.listView.setDataSource(list)
    .reloadTable()
    .cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [weakSelf action:tapAction];
    }).tableScroll(^(UIScrollView *scroll){
        NSArray *list = weakSelf.listView.tableView.visibleCells;
        PlayerCell *cell =list.firstObject;
        CGRect newRect = [cell.contentView convertRect:cell.contentView.bounds toView:weakSelf.view];
        if (newRect.origin.y<0) {
            cell = list[1];
        }
        NSIndexPath *path = cell.index;
        NSString *urlStr = (NSString *)[(JoyCellBaseModel *)[weakSelf.listView.dataArrayM objectAtIndex:path.row] expandObj];
        [weakSelf.player pause];
        weakSelf.player = [AVPlayer playerWithURL:[NSURL URLWithString:urlStr]];
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:weakSelf.player];
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [cell.contentView.layer addSublayer:layer];
        layer.frame = cell.contentView.bounds;
        [weakSelf.player play];
        
    });
};

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (NSMutableArray *)getDataSource{
    NSArray *list = @[@"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/18/mp4/190318214226685784.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319104618910544.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319125415785691.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/17/mp4/190317150237409904.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/14/mp4/190314223540373995.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/14/mp4/190314102306987969.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/13/mp4/190313094901111138.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/12/mp4/190312143927981075.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/12/mp4/190312083533415853.mp4",
    @"http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4"];
    NSMutableArray *rowArray = [NSMutableArray array];
    for (int i=0; i<list.count; i++) {
        JoyCellBaseModel *cellModel = [[JoyCellBaseModel alloc]init];
        cellModel.expandObj = list[i];
        cellModel.cellName = @"PlayerCell";
        [rowArray addObject:cellModel];
    }
    return rowArray;
}

- (void)action:(NSString *)tapAction{

}
@end
