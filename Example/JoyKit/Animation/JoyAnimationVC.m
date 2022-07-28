//
//  JoyAnimationVC.m
//  JoyKit_Example
//
//  Created by joy on 2022/7/26.
//  Copyright © 2022 joy-make. All rights reserved.
//

#import "JoyAnimationVC.h"
#import <JoyKit/CAAnimation+HCAnimation.h>
#import "UIView+JoyCategory.h"
#import "CALayer+JoyLayer.h"
#import <JoyKit/JoyKit.h>

@interface JoyAnimationVC ()
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)JoyTableAutoLayoutView *tableView;
@end

@implementation JoyAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"caanimation动画";
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.btn];
    
    NSArray *list = @[@"缩放",@"位移",@"旋转",@"透明度",@"抖动",@"绕某点旋转",@"贝塞尔曲线位移",@"随机转场动画"];
    NSMutableArray *dataArrayM = NSMutableArray.array;
    JoySectionBaseModel *sectiomModel = JoySectionBaseModel.new;
    [dataArrayM addObject:sectiomModel];
    for (NSString *title in list) {
        JoyCellBaseModel *model = JoyCellBaseModel.new;
        model.title = title;
        model.cellName = JoyMiddleLabelCell;
        [sectiomModel.rowArrayM addObject:model];
    }
    
    self.tableView.setDataSource(dataArrayM).cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        switch (indexPath.row) {
            case 0:
                //缩放
                [CAAnimation showScaleAnimationInView:self.btn fromValue:0.5 ScaleValue:12 Repeat:2 Duration:2 autoreverses:YES];
                break;
            case 1:
                //位移
                [CAAnimation showMoveAnimationInView:self.btn Position:CGPointMake(0, 0) Repeat:3 Duration:1];
                break;
            case 2:
                //旋转
                [CAAnimation showRotateAnimationInView:self.btn Degree:2 Direction:AxisY Repeat:3 Duration:1 autoreverses:YES];
                break;
            case 3:
//                透明度
                [CAAnimation showOpacityAnimationInView:self.btn fromAlpha:0.3 Alpha:1 Repeat:3 Duration:1 autoreverses:YES];
                break;
            case 4:
                //抖动
                [CAAnimation showShakeAnimationInView:self.btn Offset:80 Direction:ShakeDerectionAxisX Repeat:3 Duration:1];
                break;
            case 5:
                //绕某点旋转
                [CAAnimation showaRadiousPathAnimationInView:self.btn point:CGPointMake(220, 220) radius:100 startAngle:0 endAlgle:2 Repeat:3 Duration:1];
                break;
            case 6:
                //贝塞尔曲线位移
                [CAAnimation showBezierPathAnimationView:self.btn startPont:CGPointMake(220, 220) endPoint:CGPointMake(320, 520) controlPoint1:CGPointMake(150, 250) controlPoint2:CGPointMake(380, 500) Repeat:3 Duration:1 autoreverses:YES];
                break;
            case 7:
                //转场
                [self.tableView.layer transitionWithAnimType:TransitionAnimTypeRamdom subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:1];
                break;
            default:
                break;
        }
    });
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(200, 500, 40, 40)];
        [_btn setTitle:@"fire" forState:UIControlStateNormal];
        [_btn setBackgroundColor:UIColor.orangeColor];
        [_btn configEmitterLayer:nil];
    }
    return _btn;
}

-(JoyTableAutoLayoutView *)tableView{
    if (!_tableView) {
        _tableView = [[JoyTableAutoLayoutView alloc]initWithFrame:self.view.bounds];
    }
    return _tableView;
}
@end
