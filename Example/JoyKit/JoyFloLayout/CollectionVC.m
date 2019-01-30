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

@interface CollectionVC ()
@property (nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)CollectionInteractor *interactor;
@property (nonatomic,strong)JoyCollectionFlowLayout *flowLayout;

@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.interactor getDataSource:^{
        self.collectionView.setDataSource(self.interactor.dataArrayM).reloadCollection().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            
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
@end
