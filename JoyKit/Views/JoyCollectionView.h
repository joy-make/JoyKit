//
//  JoyCollectionView.h
//  Toon
//
//  Created by joymake on 16/7/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "UIView+JoyCategory.h"
#import "Joy.h"
@class JoyCollectionView;

typedef void (^CollectionCellSelectBlock)(NSIndexPath *indexPath,NSString *tapAction);

typedef void (^CollectionCellEditingBlock)(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath);

typedef void (^CollectionCellMoveBlock)(NSIndexPath *sourceIndexPath,NSIndexPath *toIndexPath);

typedef void (^CellTextChanged)(NSIndexPath *indexPath,NSString *content,NSString *key);

typedef void (^CollectionScrollBlock)(UIScrollView *scrollView);

typedef void (^CollectionHeaderFooterActionBlock)(NSInteger section,NSObject *actionObject,BOOL isHeaderAction);

typedef struct ScrollType{
    BOOL        isInfinite;     //是否无限多
    NSInteger   scrollInterval;  //滚动间隔时间
}CollectionScrolltype;

@class JoySectionBaseModel;
@interface JoyCollectionView : UIView
@property(nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSIndexPath                             *oldSelectIndexPath;

@property (nonatomic,strong)NSIndexPath                             *currentSelectIndexPath;

//**********************************链式配置,以支持链式调用*************************************************

#pragma mark  让Collection确认是否可编辑
@property (nonatomic,readonly)JoyCollectionView    *(^setCollectionEdit)(BOOL canEdit);
#pragma mark  让Collection无限滚动
@property (nonatomic,readonly)JoyCollectionView    *(^setCollectionInfinite)(BOOL isInfinite,NSInteger ScrollInterval);
#pragma mark  给Collection数据源
@property (nonatomic,readonly)JoyCollectionView    *(^setDataSource)(NSMutableArray<JoySectionBaseModel *> *dataArrayM);
#pragma mark  给背景视图CollectionBackView
@property (nonatomic,readonly)JoyCollectionView    *(^setCollectionBackView)(UIView *backView);
#pragma mark  给背景视图设置无数据源BackView
@property (nonatomic,readonly)JoyCollectionView    *(^setCollectionBackNoDataView)(UIView *noDataView);
#pragma mark  刷新整个Collection
@property (nonatomic,readonly)JoyCollectionView    *(^reloadCollection)(void);


//**************编辑Action
#pragma mark  Cell 选中
@property (nonatomic,readonly)JoyCollectionView    *(^cellDidSelect)(CollectionCellSelectBlock cellSelectBlock);
#pragma mark  Cell 编辑
@property (nonatomic,readonly)JoyCollectionView    *(^cellEiditAction)(CollectionCellEditingBlock cellEditingBlock);
#pragma mark  Cell 挪动从from 挪到to
@property (nonatomic,readonly)JoyCollectionView    *(^cellMoveAction)(CollectionCellMoveBlock cellMoveBlock);
#pragma mark  Cell上文本编辑结束
@property (nonatomic,readonly)JoyCollectionView    *(^cellTextEiditEnd)(CellTextChanged cellTextEiditEndBlock);
#pragma mark  Cell上文本字符编辑发生变化
@property (nonatomic,readonly)JoyCollectionView    *(^cellTextCharacterHasChanged)(CellTextChanged cellTextCharacterHasChangedBlock);
#pragma mark  Cell 选中
@property (nonatomic,readonly)JoyCollectionView    *(^headerFooterAction)(CollectionHeaderFooterActionBlock headerFooterAction);

//**************编辑Action结束
#pragma mark Table滚动
@property (nonatomic,readonly)JoyCollectionView    *(^collectionScroll)(CollectionScrollBlock scrollBlock);

//**********************************链式配置,以支持链式调用*************************************************

#pragma mark 刷新section
- (JoyCollectionView *)reloadSection:(NSIndexPath *)indexPath;

#pragma mark 刷新列
- (JoyCollectionView *)reloadItem:(NSIndexPath *)indexPath;

#pragma mark 设置约束 子类调super时用
- (void)setConstraint;

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)flowLayout;

-(CGFloat)setData:(NSMutableArray *)dataArray;
@end
