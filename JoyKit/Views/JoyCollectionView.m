//
//  JoyCollectionView.m
//  Toon
//
//  Created by joymake on 16/7/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define CELL_W  (SCREEN_W- 5*min_cellInset)/4
#define CELL_H  (CELL_W * 95/64 +10)
#import "JoyCollectionView.h"
#import "JoyImageCollectionViewCell.h"
#import "JoySectionBaseModel.h"
#import "JoyCellBaseModel.h"
#import "JoyCellBaseModel+Action.h"
#import "Joy.h"
#import "UICollectionReusableView+JoyHeaderFooter.h"

const int min_cellSpace = 5;
const int min_cellInset = 15;

@interface JoyCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *_registCellArrayM;
    NSMutableArray *_registSectionHeaderM;
    NSMutableArray *_registSectionFooterM;
}
@property (nonatomic,strong)NSMutableArray *dataArrayM;
@property (nonatomic,strong)UICollectionViewFlowLayout *selectStaffLayout;
@property (nonatomic,strong)UIView                      *backView;
@property (nonatomic,strong)UIView                      *noDataBackView;
@property (nonatomic,readonly)BOOL                      editing;
@end

@implementation JoyCollectionView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initRegistArray];
        [self addSubview:self.collectionView];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initRegistArray];
        [self addSubview:self.collectionView];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)flowLayout{
    if (self = [super initWithFrame:frame]) {
        [self initRegistArray];
        self.selectStaffLayout = flowLayout;
        [self addSubview:self.collectionView];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)initRegistArray{
    _registCellArrayM = [NSMutableArray array];
    _registSectionHeaderM = [NSMutableArray array];
    _registSectionFooterM = [NSMutableArray array];
}


#pragma clang diagnostic ignored "-Wunused-variable"

- (void)setConstraint{
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(self.collectionView, make.leading.equalTo(weakSelf.mas_leading);
                   make.trailing.equalTo(weakSelf.mas_trailing);
                   make.top.equalTo(weakSelf.mas_top);
                   make.bottom.equalTo(weakSelf.mas_bottom););
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView=  [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 0) collectionViewLayout:self.selectStaffLayout];
        [_collectionView registerClass:NSClassFromString(@"JoyImageCollectionViewCell") forCellWithReuseIdentifier:@"JoyImageCollectionViewCell"];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];

        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)selectStaffLayout{
    if (!_selectStaffLayout) {
        _selectStaffLayout = [[UICollectionViewFlowLayout alloc]init];
        _selectStaffLayout.itemSize = CGSizeMake(CELL_W, CELL_H);//cell的大小
        _selectStaffLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滑动方式
        _selectStaffLayout.minimumLineSpacing = 0;//每行的间距
        _selectStaffLayout.minimumInteritemSpacing = 0;//每行cell内部的间距
        _selectStaffLayout.sectionInset = UIEdgeInsetsMake(min_cellSpace, min_cellInset, min_cellSpace, min_cellInset);
    }
    return _selectStaffLayout;
}

-(CGFloat)setData:(NSMutableArray *)dataArrayM{
    _dataArrayM = dataArrayM;
    [self.collectionView reloadData];
    return _selectStaffLayout.collectionViewContentSize.height +min_cellSpace;
}

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.collectionView];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel *model = [sectionModel.rowArrayM objectAtIndex:indexPath.row];
    if (![_registCellArrayM containsObject:model.cellName]) {
        [_collectionView registerClass:NSClassFromString(model.cellName) forCellWithReuseIdentifier:model.cellName];
        [_registCellArrayM addObject:model.cellName];
    }
    JoyImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:model.cellName forIndexPath:indexPath];
    [cell setCellWithModel:model];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self cellDidSelectWithIndexPath:indexPath action:nil];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    return sectionModel.rowArrayM.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArrayM.count;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectinModel = self.dataArrayM[indexPath.section];

    if (![_registSectionHeaderM containsObject:sectinModel.sectionHeadViewName] && sectinModel.sectionHeadViewName){
        [_collectionView registerClass:NSClassFromString(sectinModel.sectionHeadViewName) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectinModel.sectionHeadViewName];
        [_registSectionHeaderM addObject:sectinModel.sectionHeadViewName];
    }
    if (![_registSectionFooterM containsObject:sectinModel.sectionFootViewName] &&sectinModel.sectionFootViewName){
        [_collectionView registerClass:NSClassFromString(sectinModel.sectionFootViewName) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectinModel.sectionFootViewName];
        [_registSectionFooterM addObject:sectinModel.sectionFootViewName];
    }
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader] &&sectinModel.sectionHeadViewName)
    {
        UICollectionReusableView <JoyCollectionHeaderFooterProtocol>*headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectinModel.sectionHeadViewName forIndexPath:indexPath];
        __weak __typeof (&*self)weakSelf = self;
        headerView.headerViewActionBlock = ^(NSObject * _Nonnull actionObject) {
            [weakSelf headerFooterActionSection:indexPath.section actionObject:actionObject isHeader:YES];
        };
        if ([headerView respondsToSelector:@selector(setHeaderFooterWithModel:isHeader:)]) {
            [headerView setHeaderFooterWithModel:sectinModel isHeader:YES];
        }
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter] &&sectinModel.sectionFootViewName){
        UICollectionReusableView <JoyCollectionHeaderFooterProtocol>*footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectinModel.sectionFootViewName forIndexPath:indexPath];
        __weak __typeof (&*self)weakSelf = self;
        footerView.headerViewActionBlock = ^(NSObject * _Nonnull actionObject) {
            [weakSelf headerFooterActionSection:indexPath.section actionObject:actionObject isHeader:NO];
        };

        if ([footerView respondsToSelector:@selector(setHeaderFooterWithModel:isHeader:)]) {
            [footerView setHeaderFooterWithModel:sectinModel isHeader:NO];
        }
        return footerView;
    }else{
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        return reusableView;
    }
}

-(void)setEditing:(BOOL)editing{
    _editing = editing;
}

#pragma mark 刷新table 的section
- (JoyCollectionView *)reloadSection:(NSIndexPath *)indexPath{
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    return self;
}

#pragma mark 刷新table 的row
- (JoyCollectionView *)reloadItem:(NSIndexPath *)indexPath{
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    return self;
}

#pragma mark 刷新table
-(JoyCollectionView *)reloadCollectionView{
    [self.collectionView setBackgroundView: self.dataArrayM.count?self.backView:self.noDataBackView?:self.backView];
    [self.collectionView reloadData];
    return self;
}


//模拟selectAction
-(void)cellDidSelectWithIndexPath:(NSIndexPath *)indexPath action:(NSString *)action{
    self.oldSelectIndexPath = self.currentSelectIndexPath;
    [self hideKeyBoard];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    if (!model.disable) {
        self.currentSelectIndexPath = indexPath;
        CollectionCellSelectBlock cellSelectBlock = objc_getAssociatedObject(self, @selector(cellDidSelect));
        cellSelectBlock?cellSelectBlock(indexPath,action?:model.tapAction):nil;
        [model action:action];
    }
}

- (void)headerFooterActionSection:(NSInteger )section actionObject:(NSObject *)actionObject isHeader:(BOOL)isHeader{
    CollectionHeaderFooterActionBlock headerFooterAction = objc_getAssociatedObject(self, @selector(headerFooterAction));
    headerFooterAction?headerFooterAction(section,actionObject,isHeader):nil;
}

#pragma mark ⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️ scrollDelegate protocol⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.collectionView) {
        [self hideKeyBoard];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CollectionScrollBlock collectionScrollBlock = objc_getAssociatedObject(self, @selector(collectionScroll));
    collectionScrollBlock?collectionScrollBlock(scrollView):nil;
}

#pragma mark 手势触摸
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideKeyBoard];
}

- (void)hideKeyBoard{
    self.collectionView.contentInset = UIEdgeInsetsZero;
    HIDE_KEYBOARD;
}


#pragma mark 回刷数据 cellmodel使用
- (void)reloadWithScheme:(ERefreshScheme)scheme andIndexPath:(NSIndexPath *)indexPath andObj:(id)obj{
    switch (scheme) {
        case ERefreshSchemeRow:
            [self reloadItem:indexPath];
            break;
        case ERefreshSchemeSection:
            [self reloadSection:indexPath];
            break;
        case ERefreshSchemeTable:
            [self reloadCollectionView];
            break;
        case ERefreshSchemeView:
        default:
            break;
    }
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
//    model.changeKey?[self textChanged:indexPath andText:obj andChangedKey:model.changeKey]:nil;
}

#pragma mark getMethod
//让Table确认是否可编辑
-(JoyCollectionView *(^)(BOOL))setTableEdit{
    __weak __typeof(&*self)weakSelf = self;
    return ^(BOOL canEdit){
        weakSelf.editing = canEdit;
        return weakSelf;
    };
}

//给Table数据源
-(JoyCollectionView *(^)(NSMutableArray<JoySectionBaseModel *> *))setDataSource{
    __weak __typeof(&*self)weakSelf = self;
    return ^(NSMutableArray *dataArrayM){
        weakSelf.dataArrayM = dataArrayM;
        return weakSelf;
    };
}

//给背景视图TableBackView
-(JoyCollectionView *(^)(UIView *))setTableBackView{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIView *backView){
        weakSelf.backView = backView;
        return weakSelf;
    };
}

//
-(JoyCollectionView *(^)(UIView *))setTableBackNoDataView{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIView *noDataBackView){
        weakSelf.noDataBackView = noDataBackView;
        return weakSelf;
    };
}

//刷新整个Table
-(JoyCollectionView *(^)(void))reloadCollection{
    __weak __typeof(&*self)weakSelf = self;
    return ^(){
        [weakSelf reloadCollectionView];
        return weakSelf;
    };
}

-(JoyCollectionView *(^)(CollectionScrollBlock))collectionScroll{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CollectionScrollBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell 被点击
-(JoyCollectionView *(^)(CollectionCellSelectBlock))cellDidSelect{
    
    __weak __typeof(&*self)weakSelf = self;
    return ^(CollectionCellSelectBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell编辑事件
-(JoyCollectionView *(^)(CollectionCellEditingBlock))cellEiditAction{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CollectionCellEditingBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell 挪移事件
-(JoyCollectionView *(^)(CollectionCellMoveBlock))cellMoveAction{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CollectionCellMoveBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell文本编辑结束
-(JoyCollectionView *(^)(CollectionCellTextEndChanged))cellTextEiditEnd{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CollectionCellTextEndChanged block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell 文字编辑发生变化
-(JoyCollectionView *(^)(CollectionCellTextCharacterHasChanged))cellTextCharacterHasChanged{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CollectionCellTextCharacterHasChanged block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

-(JoyCollectionView *(^)(CollectionHeaderFooterActionBlock))headerFooterAction{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CollectionHeaderFooterActionBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

-(void)dealloc{
    self.dataArrayM = nil;
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    [self removeFromSuperview];
}

@end
