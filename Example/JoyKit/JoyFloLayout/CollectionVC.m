//
//  CollectionVC.m
//  JoyKit_Example
//
//  Created by Joymake on 2019/1/21.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import "CollectionVC.h"
#import "JoyCollectionView.h"
#import <Masonry/Masonry.h>
#import "CollectionInteractor.h"
#import "JoyCollectionFlowLayout.h"
#import "UIColor+JoyColor.h"
#import "JoyPickerView.h"
#import <JoySectionBaseModel.h>
#import <JoyCellBaseModel.h>

@interface CollectionVC ()
@property (nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)CollectionInteractor *interactor;
@property (nonatomic,strong)JoyCollectionFlowLayout *flowLayout;
@property (nonatomic,strong)JoyPickerView *joyPickerView;
@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.joyPickerView setToolbarLeftTitle:@"cancle" textColor:[UIColor redColor]];
    [self.joyPickerView setToolbarRightTitle:@"enter" textColor:[UIColor greenColor]];
    [self.joyPickerView setTitle:@"测试" textColor:[UIColor purpleColor]];
    [self.joyPickerView reloadPickViewWithDataSource:@[@[@"1",@"2",@"3"],@[@"4",@"5",@"6"],@[@"7"]]];
    self.joyPickerView.EntryBtnClickBlock = ^(NSMutableArray<JoyPickSelectedModel *> *selectedDataArrayM) {
        NSLog(@"");
    } ;
    
    __weak __typeof(&*self)weakSelf = self;
    [self.interactor getDataSource:^{
        self.collectionView.setDataSource(self.interactor.dataArrayM).reloadCollection().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            JoySectionBaseModel *sectionModel = [self.interactor.dataArrayM objectAtIndex:indexPath.section];
            JoyImageCellBaseModel *model =[sectionModel.rowArrayM objectAtIndex:indexPath.row];
            [self.joyPickerView setTitle:model.title textColor:[UIColor purpleColor]];
            [self.joyPickerView showPickView];
        }).collectionScroll(^(UIScrollView *scrollView) {
            NSLog(@"");
        });
    }];
}


-(JoyCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero  layout:self.flowLayout];
    }
    return _collectionView;
}

-(JoyCollectionFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[JoyCollectionFlowLayout alloc]initWithType:AlignWithCenter];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        _flowLayout.estimatedItemSize = CGSizeMake(20, 100);
        _flowLayout.headerReferenceSize = CGSizeMake(0, 40);
//        _flowLayout.footerReferenceSize = CGSizeMake(0, 40);
    }
    return _flowLayout;
}

-(CollectionInteractor *)interactor{
    return _interactor = _interactor?:[[CollectionInteractor alloc]init];
}

-(JoyPickerView *)joyPickerView{
    return _joyPickerView = _joyPickerView?:[[JoyPickerView alloc]init];
}
@end
