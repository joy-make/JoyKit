//
//  TNAAutoLayoutTableBaseView.h
//  Toon
//
//  Created by joymake on 16/6/20.
//  Copyright © 2016年 Joy. All rights reserved.
//  autolayout table

//autolayout基类，勿改，若需修改，请建子类修改


#import "UIView+JoyCategory.h"
#import "Joy.h"

@class JoyTableAutoLayoutView;

typedef void (^CellDisplayBlock)(UITableView *tableView,UITableViewCell *cell,NSIndexPath *indexPath);
typedef void (^CellSelectBlock)(NSIndexPath *indexPath,NSString *tapAction);
typedef void (^CellEditingBlock)(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath);
typedef void (^CellMoveBlock)(NSIndexPath *sourceIndexPath,NSIndexPath *toIndexPath);
typedef void (^CellTextChanged)(NSIndexPath *indexPath,NSString *content,NSString *key);
typedef void (^ScrollBlock)(UIScrollView *scrollView);
typedef void (^CellCollectionBlock)(NSIndexPath *indexPath,NSIndexPath *collectionIndexPath);
typedef void (^HeaderFooterActionBlock)(NSInteger section,NSObject *actionObject,BOOL isHeaderAction);
typedef void (^JoyRefreshBlock)(void);


@class JoySectionBaseModel;
@interface JoyTableAutoLayoutView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView                             *tableView;
@property (nonatomic,strong)NSMutableArray<JoySectionBaseModel *>   *dataArrayM;
@property (nonatomic,strong)NSIndexPath                             *oldSelectIndexPath;
@property (nonatomic,strong)NSIndexPath                             *currentSelectIndexPath;

//**********************************链式配置,以支持链式调用*************************************************
#pragma mark  让Table确认是否可编辑
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setTableEdit)(BOOL canEdit);                                         //设置table是否可编辑
#pragma mark  给Table数据源
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setDataSource)(NSMutableArray<JoySectionBaseModel *> *dataArrayM);   //设置数据源
#pragma mark  给背景视图TableBackView
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setTableBackView)(UIView *backView);                                 //设置背景图
#pragma mark  给背景视图设置无数据源BackView
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setTableBackNoDataView)(UIView *noDataView);                         //设置无数据视图
#pragma mark  给头视图TableHeadView
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setTableHeadView)(UIView *headView);                                 //设置头视图
#pragma mark  给尾视图TableFootView
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setTableFootView)(UIView *footView);                                 //设置尾视图
#pragma mark  刷新整个Table
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^reloadTable)(void);                                                  //刷新table

//**************cell显示
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellWillDisplayBlock)(CellDisplayBlock block);                       //cell即将展示
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellEndDisplayBlock)(CellDisplayBlock block);                        //cell结束展示

//**************编辑Action
#pragma mark  Cell 选中
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellDidSelect)(CellSelectBlock cellSelectBlock);                    //cell点击事件
#pragma mark  Cell 编辑
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellEiditAction)(CellEditingBlock cellEditingBlock);                //cell编辑事件回调
#pragma mark  Cell 挪动从from 挪到to
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellMoveAction)(CellMoveBlock cellMoveBlock);                       //cell是否可挪移
#pragma mark  Cell上文本编辑结束
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellTextEiditEnd)(CellTextChanged block);        //cell上文本编辑结束
#pragma mark  Cell上文本字符编辑发生变化
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellTextCharacterHasChanged)(CellTextChanged block);//cell上文本发生变化
#pragma mark  Cell 选中
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^headerFooterAction)(HeaderFooterActionBlock headerFooterAction);     //头部、底部事件（自定义）

//**************编辑Action结束

#pragma mark Table滚动
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^tableScroll)(ScrollBlock scrollBlock);                               //table滚动
#pragma mark Table滚动拖拽停止
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^tableScrollDidEndDraging)(ScrollBlock scrollBlock);                               //table滚动
#pragma mark Table滚动减速停止
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^tableScrollDidEndDecelerating)(ScrollBlock scrollBlock);      //table滚动
#pragma mark tableCollection
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^collectionDidSelect)(CellCollectionBlock collectionDidSelectBlock);  //collection选中
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^collectionDeSelect)(CellCollectionBlock collectionDeSelectBlock);    //collection反选
#pragma mark table刷新
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^joyHeaderRefreshblock)(JoyRefreshBlock refreshBlock);                //下拉刷新
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^joyFooterRefreshblock)(JoyRefreshBlock refreshBlock);                //上拉刷新
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^joyEndHeaderRefreshblock)(void);                                     //结束下拉刷新
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^joyEndFooterRefreshblock)(void);                                     //结束上拉刷新

//**********************************链式配置,以支持链式调用*************************************************

#pragma mark 刷新section
- (JoyTableAutoLayoutView *)reloadSection:(NSIndexPath *)indexPath;

#pragma mark 刷新列
- (JoyTableAutoLayoutView *)reloadRow:(NSIndexPath *)indexPath;

#pragma mark 设置约束 子类调super时用
- (void)setConstraint;

#pragma mark 准备刷新
- (JoyTableAutoLayoutView *)beginUpdates;

#pragma mark 结束新列
- (JoyTableAutoLayoutView *)endUpdates;

@end

//设置cellH，不使用establishHeight推算行高
@interface JoyTableBaseView : JoyTableAutoLayoutView

@end

