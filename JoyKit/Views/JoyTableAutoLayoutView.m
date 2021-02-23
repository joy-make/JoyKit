//
//  TNAAutoLayoutTableBaseView.m
//  Toon
//
//  Created by joymake on 16/6/20.
//  Copyright © 2016年 Joy. All rights reserved.
//
#define KNoInfoSectionFootH 0.0f
#define KNoInfoSectionH 10
#define KNormalSectionH 40
#import "JoySectionBaseModel.h"
#import "UITableViewCell+JoyCell.h"
#import "JoyTableAutoLayoutView.h"
#import <objc/runtime.h>
#import "JoyCellBaseModel+Action.h"
#import "JoyCellBaseModel+Edit.h"
#import "UITableViewHeaderFooterView+JoyHeaderFooter.h"
#import "UIColor+JoyColor.h"
#import "CAAnimation+HCAnimation.h"

#define SCREEN_HEIGHT_OF_IPHONE6PLUS 736
#define IOS8_OR_LATER ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0)
@interface JoyRefreshHeaderView : UIView
@property (nonatomic,strong)UILabel     * downLoadLabel;
@property (nonatomic,strong)UILabel     * timeLabel;
- (void)startRefreshingSize:(CGSize)animationZoneSize;
- (void)endRefreshing;
@end

@interface JoyRefreshFooterView : UIView
@property (nonatomic,strong)UILabel     * upLoadLabel;
@property (nonatomic,strong)UILabel     * timeLabel;
- (void)startRefreshingSize:(CGSize)animationZoneSize;
- (void)endRefreshing;
@end


@interface JoyTableAutoLayoutView ()<JoyCellDelegate>{
    NSMutableArray *_registHeaderFooterArrayM;
    NSMutableArray *_registCellArrayM;
    BOOL _isHasTableFoot;
}
@property (nonatomic,readonly)BOOL                      editing;
@property (nonatomic,strong)UIView                      *backView;
@property (nonatomic,strong)UIView                      *noDataBackView;
@property (nonatomic,strong)NSMutableArray              *registHeaderFooterArrayM;
@property (nonatomic,assign)bool                        isSectionTable;

@property (nonatomic,assign)bool                        isDownRefreshEnable;
@property (nonatomic,assign)bool                        isUpRefreshEnable;

@property (nonatomic,assign)bool                        isDownLoading;
@property (nonatomic,assign)bool                        isUpLoading;
@property (nonatomic,strong)JoyRefreshHeaderView     * joy_refreshHeaderView;
@property (nonatomic,strong)JoyRefreshFooterView     * joy_refreshFooterView;
@end

const NSString *tableHDelegate =  @"tableHDelegate";
@implementation JoyTableAutoLayoutView
#pragma mark 动态执行代理
CGFloat tableRowH(id self, SEL _cmd, UITableView *tableView,NSIndexPath *indexPath){
    NSMutableArray *array =  objc_getAssociatedObject(self, &tableHDelegate);
    JoySectionBaseModel *sectionModel = [array objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    return model.cellH;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!IOS8_OR_LATER)
        {class_addMethod([self class], @selector(tableView:heightForRowAtIndexPath:), (IMP)tableRowH, "f@:@:@");}
        [self configPara];
        [self addSubview:self.tableView];
        [self addSubViewToSelf];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)configPara{
    _registCellArrayM = [NSMutableArray array];
    _registHeaderFooterArrayM = [NSMutableArray array];
    self.isSectionTable = true;
}

#pragma mark 供子类扩展使用
- (void)addSubViewToSelf{}

#pragma mark getter method
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF2F2F4);
        _tableView.sectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        //        _tableView.estimatedRowHeight = 44;
    }
    return _tableView;
}

#pragma clang diagnostic ignored "-Wunused-variable"
#pragma mark 设置约束
-(void)setConstraint{
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(weakSelf.tableView, make.edges.equalTo(weakSelf););
}

-(void)setBackView:(UIView *)backView{
    _backView = backView;
    self.tableView.backgroundView = backView;
}

-(void)setEditing:(BOOL)editing{
    _editing = editing;
    _tableView.editing = editing;
}

#pragma mark 准备刷新
- (JoyTableAutoLayoutView *)beginUpdates{
    [self.tableView beginUpdates];
    return self;
}

#pragma mark 结束新列
- (JoyTableAutoLayoutView *)endUpdates{
    [self.tableView endUpdates];
    return self;
}

#pragma mark 刷新table
-(JoyTableAutoLayoutView *)reloadTableView{
    objc_setAssociatedObject(self, &tableHDelegate, self.dataArrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.tableView setBackgroundView: self.dataArrayM.count?self.backView:self.noDataBackView?:self.backView];
    [self.tableView reloadData];
    return self;
}

#pragma mark 刷新table 的section
- (JoyTableAutoLayoutView *)reloadSection:(NSIndexPath *)indexPath{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    return self;
}

#pragma mark 刷新table 的row
- (JoyTableAutoLayoutView *)reloadRow:(NSIndexPath *)indexPath{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    return self;
}

#pragma mark 🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲Table DataSource Protocol🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!self.isSectionTable) {
        return KNoInfoSectionH;
    }
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    [self registTableHeaderFootWithViewName:sectionModel.sectionHeadViewName];
    return sectionModel.sectionH?:([sectionModel.sectionTitle length]?KNormalSectionH:KNoInfoSectionH);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (!self.isSectionTable) {
        return KNoInfoSectionFootH;
    }
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    [self registTableHeaderFootWithViewName:sectionModel.sectionFootViewName];
    return sectionModel.sectionFootH?:([sectionModel.sectionFootTitle length]?KNormalSectionH:KNoInfoSectionFootH);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!self.isSectionTable) {
        return nil;
    }
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    UITableViewHeaderFooterView *headerView = nil;
    if (sectionModel.sectionHeadViewName) {
        [self registTableHeaderFootWithViewName:sectionModel.sectionHeadViewName];
        headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.sectionHeadViewName];
        __weak __typeof (&*self)weakSelf = self;
        headerView.headerViewActionBlock = ^(NSObject * _Nonnull actionObject) {
            [weakSelf headerFooterActionSection:section actionObject:actionObject isHeader:YES];
        };
        [headerView setHeaderFooterWithModel:sectionModel isHeader:YES];
    }else{
        sectionModel.sectionH = sectionModel.sectionH?:sectionModel.sectionTitle?KNormalSectionH:KNoInfoSectionH;
        headerView = (UITableViewHeaderFooterView *)[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, sectionModel.sectionH)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,headerView.frame.size.width, sectionModel.sectionH)];
        titleLabel.text =  sectionModel.sectionTitle;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = UIColorFromRGB(0x999999);
        [titleLabel sizeToFit];
        CGFloat titleLabelW = titleLabel.frame.size.width;
        CGFloat titleLabelH = titleLabel.frame.size.height;
        CGFloat titleLabelX = 9;
        CGFloat titleLabelY = sectionModel.sectionH - (7) - titleLabelH;
        titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
        [headerView addSubview:titleLabel];
    }
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (!self.isSectionTable) {
        return nil;
    }
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    UITableViewHeaderFooterView *headerView = nil;
    if (sectionModel.sectionFootViewName) {
        [self registTableHeaderFootWithViewName:sectionModel.sectionFootViewName];
        headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.sectionFootViewName];
        __weak __typeof (&*self)weakSelf = self;
        headerView.headerViewActionBlock = ^(NSObject * _Nonnull actionObject) {
            [weakSelf headerFooterActionSection:section actionObject:actionObject isHeader:NO];
        };
        [headerView setHeaderFooterWithModel:sectionModel.headObj isHeader:NO];
    }else{
        sectionModel.sectionFootH = sectionModel.sectionFootH?:sectionModel.sectionFootTitle?KNormalSectionH:KNoInfoSectionFootH;
        if (sectionModel.sectionFootH <=KNoInfoSectionFootH) return nil;
        headerView = (UITableViewHeaderFooterView *)[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, sectionModel.sectionFootH)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,headerView.frame.size.width-30, sectionModel.sectionFootH)];
        titleLabel.numberOfLines = 0;
        titleLabel.text =  sectionModel.sectionFootTitle;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = UIColorFromRGB(0x777E8C);
        [titleLabel sizeToFit];
        CGFloat titleLabelW = titleLabel.frame.size.width;
        CGFloat titleLabelH = titleLabel.frame.size.height;
        CGFloat titleLabelX = 15;
        CGFloat titleLabelY = 10;
        titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
        [headerView addSubview:titleLabel];
    }
    return headerView;
}

- (void)headerFooterActionSection:(NSInteger )section actionObject:(NSObject *)actionObject isHeader:(BOOL)isHeader{
    HeaderFooterActionBlock headerFooterAction = objc_getAssociatedObject(self, @selector(headerFooterAction));
    headerFooterAction?headerFooterAction(section,actionObject,isHeader):nil;
}

//ios7系统需要计算cell的h
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JoyCellBaseModel * model;
    if (!self.isSectionTable) {
        model = (JoyCellBaseModel * )[self.dataArrayM objectAtIndex:indexPath.row];
    }else{
        JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
        model  = sectionModel.rowArrayM[indexPath.row];
    }
    return model.cellH?:44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.isSectionTable?self.dataArrayM.count:1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.isSectionTable) {
        return self.dataArrayM.count;
    }
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    return sectionModel.rowArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JoyCellBaseModel * model;
    if (!self.isSectionTable) {
        model = (JoyCellBaseModel *)[self.dataArrayM objectAtIndex:indexPath.row];
    }else{
        JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
        model  = sectionModel.rowArrayM[indexPath.row];
    }
    [self registTableCellWithCellModel:model];
    UITableViewCell <JoyCellProtocol>*cell = [tableView dequeueReusableCellWithIdentifier:model.cellName];
    __weak __typeof (&*self)weakSelf = self;
    model.cellBlock =^(id obj,ERefreshScheme scheme){
        [weakSelf.tableView beginUpdates];
        [weakSelf reloadWithScheme:scheme andIndexPath:indexPath andObj:obj];
        [weakSelf.tableView endUpdates];
    };
    cell.delegate = self;
    
    cell.index = indexPath;
    
    if ([cell respondsToSelector:@selector(setCellWithModel:)]) {
        [cell setCellWithModel:model];
    }
    
    model.backgroundColor? cell.backgroundColor = KJoyHexColor(model.backgroundColor,1):nil;
    
    cell.beginUpdatesBlock =^(){
        [weakSelf beginUpdates];
    };
    
    cell.endUpdatesBlock =^(){
        [weakSelf endUpdates];
    };
    
    cell.scrollBlock = ^(NSIndexPath *indexPath,UITableViewScrollPosition scrollPosition,BOOL animated){
        [weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    };
    
    cell.collectionDeleteBlock = ^(NSIndexPath *collectionIndexPath) {
        [weakSelf collectionDeSelect:indexPath collectionIndexPath:collectionIndexPath];
    };
    
    cell.collectionDidSelectBlock = ^(NSIndexPath *collectionIndexPath) {
        [weakSelf collectionDidSelect:indexPath collectionIndexPath:collectionIndexPath];
    };
    
    cell.longPressBlock = ^{
        [weakSelf cellDidSelectWithIndexPath:indexPath action:model.longPressAction];
    };
    
    cell.accessoryType = model.accessoryType;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.userInteractionEnabled = !model.disable;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self cellDidSelectWithIndexPath:indexPath action:nil];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JoySectionBaseModel *sectionModel = self.isSectionTable?[self.dataArrayM objectAtIndex:indexPath.section]:nil;
    JoyCellBaseModel *model = self.isSectionTable?[sectionModel.rowArrayM objectAtIndex:indexPath.row]:[self.dataArrayM objectAtIndex:indexPath.row];
    if(sectionModel.sectionLeadingOffSet || model.rowLeadingOffSet)
    {
        [cell respondsToSelector:@selector(setSeparatorInset:)]?[cell setSeparatorInset:UIEdgeInsetsMake(0, sectionModel.sectionLeadingOffSet?:model.rowLeadingOffSet, 0, 0)]:nil;
        if (@available(iOS 8.0, *)) {
            [cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]?[cell setPreservesSuperviewLayoutMargins:NO]:nil;
        }
    }
    else
    {
        [cell respondsToSelector:@selector(setSeparatorInset:)]?[cell setSeparatorInset:UIEdgeInsetsMake(0, KNoInfoSectionH, 0, 0)]:nil;
        if (@available(iOS 8.0, *)) {
            [cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]?[cell setPreservesSuperviewLayoutMargins:NO]:nil;
        }
    }
}

#pragma mark ⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️Table's Action Delegate Protocol⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentSelectIndexPath = nil;
}

#pragma mark 是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    JoyCellBaseModel * model = [self getCellModelWithIndexPath:indexPath];
    return model.editingStyle != UITableViewCellEditingStyleNone;
}

#pragma mark 是否可挪移
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    JoyCellBaseModel * model = [self getCellModelWithIndexPath:indexPath];
    return [model respondsToSelector:@selector(canMove)]?model.canMove:NO;
}

#pragma mark 挪移action
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    CellMoveBlock cellMoveActionBlock = objc_getAssociatedObject(self, @selector(cellMoveAction));
    cellMoveActionBlock?cellMoveActionBlock(sourceIndexPath, destinationIndexPath):nil;
}

- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath{
    return@"删除";
}
#pragma mark 编辑类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    JoyCellBaseModel * model = [self getCellModelWithIndexPath:indexPath];
    return model.editingStyle;
}

#pragma mark 编辑action
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    CellEditingBlock cellEiditActionBlock = objc_getAssociatedObject(self, @selector(cellEiditAction));
    cellEiditActionBlock?cellEiditActionBlock(editingStyle,indexPath):nil;
}

#pragma mark 😊😊😊😊😊😊😊😊😊😊😊😊Cell‘s Delegate Protocol(text action)😊😊😊😊😊😊😊😊😊😊😊😊😊😊
-(void)textChanged:(NSIndexPath *)selectIndex andText:(NSString *)content andChangedKey:(NSString *)changeTextKey{
    CellTextEndChanged cellTextEiditEndBlock = objc_getAssociatedObject(self, @selector(cellTextEiditEnd));
    cellTextEiditEndBlock?cellTextEiditEndBlock(selectIndex, content,changeTextKey):nil;
}

- (void)textHasChanged:(NSIndexPath *)selectIndex andText:(NSString *)content andChangedKey:(NSString *)changeTextKey{
    CellTextCharacterHasChanged cellTextCharacterHasChangedBlock = objc_getAssociatedObject(self, @selector(cellTextCharacterHasChanged));
    cellTextCharacterHasChangedBlock?cellTextCharacterHasChangedBlock(selectIndex, content,changeTextKey):nil;
}

-(void)textshouldBeginEditWithTextContainter:(id)textContainer andIndexPath:(NSIndexPath *)indexPath{
    self.currentSelectIndexPath = indexPath;
    CGFloat footH = SCREEN_H>= SCREEN_HEIGHT_OF_IPHONE6PLUS?190:120;
    CGFloat contentInsetBottom = SCREEN_H>= SCREEN_HEIGHT_OF_IPHONE6PLUS?340:280;
    _isHasTableFoot?:[self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, footH)]];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, contentInsetBottom, 0);
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)textshouldEndEditWithTextContainter:(id)textContainer andIndexPath:(NSIndexPath *)indexPath{
    
}

//模拟selectAction
-(void)cellDidSelectWithIndexPath:(NSIndexPath *)indexPath action:(NSString *)action{
    self.oldSelectIndexPath = self.currentSelectIndexPath;
    [self hideKeyBoard];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    JoyCellBaseModel * model = [self getCellModelWithIndexPath:indexPath];
    if (!model.disable) {
        self.currentSelectIndexPath = indexPath;
        CellSelectBlock cellSelectBlock = objc_getAssociatedObject(self, @selector(cellDidSelect));
        cellSelectBlock?cellSelectBlock(indexPath,action?:model.tapAction):nil;
        [model action:action];
    }
}

- (JoyCellBaseModel *)getCellModelWithIndexPath:(NSIndexPath *)indexPath{
    JoyCellBaseModel * model;
    if(!self.isSectionTable){
        model = (JoyCellBaseModel * )[self.dataArrayM objectAtIndex:indexPath.row];
    }else{
        JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
        model  = sectionModel.rowArrayM[indexPath.row];
    }
    return model;
}

#pragma mark collectionCell点击事件
- (void)collectionDidSelect:(NSIndexPath *)tableIndexPath collectionIndexPath:(NSIndexPath *)collectionIndexPath{
    CellCollectionBlock collectionDidSelectBlock = objc_getAssociatedObject(self, @selector(collectionDidSelect));
    collectionDidSelectBlock?collectionDidSelectBlock(tableIndexPath, collectionIndexPath):nil;
}

- (void)collectionDeSelect:(NSIndexPath *)tableIndexPath collectionIndexPath:(NSIndexPath *)collectionIndexPath{
    CellCollectionBlock collectionDeSelectBlock = objc_getAssociatedObject(self, @selector(collectionDeSelect));
    collectionDeSelectBlock?collectionDeSelectBlock(tableIndexPath, collectionIndexPath):nil;
}

#pragma mark ⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️ scrollDelegate protocol⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.tableView) {
        [self hideKeyBoard];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    ScrollBlock tableScrollBlock = objc_getAssociatedObject(self, @selector(tableScroll));
    tableScrollBlock?tableScrollBlock(scrollView):nil;
    
    if(!self.isDownLoading && self.isDownRefreshEnable){
        self.joy_refreshHeaderView.downLoadLabel.hidden =self.joy_refreshHeaderView.timeLabel.hidden = false;
        if (scrollView.contentOffset.y<-80) {
            self.isDownLoading = YES;
            self.joy_refreshHeaderView.downLoadLabel.text = @"↑";
        }else{
            self.joy_refreshHeaderView.downLoadLabel.text = @"↓";
            self.joy_refreshHeaderView.y = - scrollView.contentOffset.y-self.joy_refreshHeaderView.height;
        }
        self.joy_refreshFooterView.hidden = self.joy_refreshHeaderView.y<0?NO:YES;
    }else{
        self.joy_refreshHeaderView.y = - scrollView.contentOffset.y-self.joy_refreshHeaderView.height;
        self.joy_refreshFooterView.hidden = self.joy_refreshHeaderView.y<0?NO:YES;
    }
    
    if(self.isUpRefreshEnable){
        if(!self.isUpLoading &&scrollView.contentOffset.y>0){
            self.joy_refreshFooterView.y = scrollView.bottom-(scrollView.contentOffset.y - scrollView.contentSize.height+scrollView.bounds.size.height);
            self.joy_refreshFooterView.hidden = scrollView.contentOffset.y<=0?YES:NO;
            if ((scrollView.contentOffset.y - scrollView.contentSize.height+scrollView.bounds.size.height)>self.joy_refreshFooterView.height) {
                self.joy_refreshFooterView.upLoadLabel.text = @"↓";//↑
                self.isUpLoading = YES;
            }else{
                self.joy_refreshFooterView.upLoadLabel.text = @"↑";//↑
            }
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    ScrollBlock tableScrollBlock = objc_getAssociatedObject(self, @selector(tableScroll));
//    tableScrollBlock?tableScrollBlock(scrollView):nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.isDownLoading && self.isDownRefreshEnable){
        [self.joy_refreshHeaderView startRefreshingSize:self.tableView.size];
        self.tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            JoyRefreshBlock headerRefreshBlock = objc_getAssociatedObject(self, @selector(joyHeaderRefreshblock));
            headerRefreshBlock?headerRefreshBlock():nil;
        });
    }
    
    if(self.isUpLoading && self.isUpRefreshEnable){
        [self.joy_refreshFooterView startRefreshingSize:self.tableView.size];
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, scrollView.height>scrollView.contentSize.height?(scrollView.height - scrollView.contentSize.height+30):80, 0);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            JoyRefreshBlock footerRefreshBlock = objc_getAssociatedObject(self, @selector(joyFooterRefreshblock));
            footerRefreshBlock?footerRefreshBlock():nil;
        });
    }
}

- (void)endHeaderRefreshing{
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:1 animations:^{
        weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [weakSelf.joy_refreshHeaderView endRefreshing];;//↑
        weakSelf.isDownLoading = NO;
    }];
}

- (void)endFooterRefreshing{
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:1 animations:^{
        weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [weakSelf.joy_refreshFooterView endRefreshing];//↑
        weakSelf.isUpLoading = NO;
    }];
}

- (void)hideKeyBoard{
    _isHasTableFoot?:[self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 20)]];
    self.tableView.contentInset = UIEdgeInsetsZero;
    HIDE_KEYBOARD;
}

#pragma mark 手势触摸
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideKeyBoard];
}

#pragma mark 回刷数据 cellmodel使用
- (void)reloadWithScheme:(ERefreshScheme)scheme andIndexPath:(NSIndexPath *)indexPath andObj:(id)obj{
    switch (scheme) {
        case ERefreshSchemeRow:
            [self reloadRow:indexPath];
            break;
        case ERefreshSchemeSection:
            [self reloadSection:indexPath];
            break;
        case ERefreshSchemeTable:
            [self reloadTableView];
            break;
        case ERefreshSchemeView:
        default:
            break;
    }
    JoyCellBaseModel * model = [self getCellModelWithIndexPath:indexPath];
    
    model.changeKey?[self textChanged:indexPath andText:obj andChangedKey:model.changeKey]:nil;
}

#pragma mark table 头和尾
- (void)setTableHeaderView:(UIView *)headView{
    [self.tableView setTableHeaderView:headView];
}

- (void)setTableFootView:(UIView *)footView{
    [self.tableView setTableFooterView:footView];
    _isHasTableFoot = footView.frame.size.height>20;
}

- (void)registTableCellWithCellModel:(JoyCellBaseModel *)cellModel{
    if (![_registCellArrayM containsObject:cellModel.cellName])
    {
        cellModel.cellType == ECellCodeType?[_tableView registerClass:NSClassFromString(cellModel.cellName) forCellReuseIdentifier:cellModel.cellName]:
        [_tableView registerNib:[UINib nibWithNibName:cellModel.cellName bundle:JOY_GETBUNDLE(cellModel.bundleName)] forCellReuseIdentifier:cellModel.cellName];
        [_registCellArrayM addObject:cellModel.cellName];
    }
}

- (void)registTableHeaderFootWithViewName:(NSString *)headerFooterViewName{
    if (![_registHeaderFooterArrayM containsObject:headerFooterViewName]&&headerFooterViewName)
    {
        [_tableView registerClass:NSClassFromString(headerFooterViewName) forHeaderFooterViewReuseIdentifier:headerFooterViewName];
        [_registHeaderFooterArrayM addObject:headerFooterViewName];
    }
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM =_dataArrayM?:[NSMutableArray arrayWithCapacity:0];
}

#pragma mark getMethod
//让Table确认是否可编辑
-(JoyTableAutoLayoutView *(^)(BOOL))setTableEdit{
    __weak __typeof(&*self)weakSelf = self;
    return ^(BOOL canEdit){
        weakSelf.editing = canEdit;
        return weakSelf;
    };
}

//给Table数据源
-(JoyTableAutoLayoutView *(^)(NSMutableArray<JoySectionBaseModel *> *))setDataSource{
    __weak __typeof(&*self)weakSelf = self;
    return ^(NSMutableArray *dataArrayM){
        weakSelf.dataArrayM = dataArrayM;
        return weakSelf;
    };
}

//给背景视图TableBackView
-(JoyTableAutoLayoutView *(^)(UIView *))setTableBackView{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIView *backView){
        weakSelf.backView = backView;
        return weakSelf;
    };
}

//
-(JoyTableAutoLayoutView *(^)(UIView *))setTableBackNoDataView{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIView *noDataBackView){
        weakSelf.noDataBackView = noDataBackView;
        return weakSelf;
    };
}

//给头视图TableHeadView
-(JoyTableAutoLayoutView *(^)(UIView *))setTableHeadView{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIView *headView){
        [weakSelf setTableHeaderView:headView];
        return weakSelf;
    };
}

//给尾视图TableFootView
-(JoyTableAutoLayoutView *(^)(UIView *))setTableFootView{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIView *headView){
        [weakSelf setTableFootView:headView];
        return weakSelf;
    };
}

//刷新整个Table
-(JoyTableAutoLayoutView *(^)(void))reloadTable{
    __weak __typeof(&*self)weakSelf = self;
    return ^(){
        if (weakSelf.dataArrayM.count) {
            weakSelf.isSectionTable = [weakSelf.dataArrayM.firstObject isKindOfClass:JoySectionBaseModel.class];
        }
        [weakSelf reloadTableView];
        return weakSelf;
    };
}

-(JoyTableAutoLayoutView *(^)(ScrollBlock))tableScroll{
    __weak __typeof(&*self)weakSelf = self;
    return ^(ScrollBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell 被点击
-(JoyTableAutoLayoutView *(^)(CellSelectBlock))cellDidSelect{
    
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellSelectBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell编辑事件
-(JoyTableAutoLayoutView *(^)(CellEditingBlock))cellEiditAction{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellEditingBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell 挪移事件
-(JoyTableAutoLayoutView *(^)(CellMoveBlock))cellMoveAction{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellMoveBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell文本编辑结束
-(JoyTableAutoLayoutView *(^)(CellTextEndChanged))cellTextEiditEnd{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellTextEndChanged block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell 文字编辑发生变化
-(JoyTableAutoLayoutView *(^)(CellTextCharacterHasChanged))cellTextCharacterHasChanged{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellTextCharacterHasChanged block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

-(JoyTableAutoLayoutView *(^)(HeaderFooterActionBlock))headerFooterAction{
    __weak __typeof(&*self)weakSelf = self;
    return ^(HeaderFooterActionBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//collectionCell点击
-(JoyTableAutoLayoutView *(^)(CellCollectionBlock))collectionDidSelect{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellCollectionBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

-(JoyTableAutoLayoutView *(^)(CellCollectionBlock))collectionDeSelect{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellCollectionBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

-(JoyTableAutoLayoutView *(^)(JoyRefreshBlock))joyHeaderRefreshblock{
    self.isDownRefreshEnable = YES;
    if (![self.subviews containsObject:self.joy_refreshHeaderView]) {
        [self addSubview:self.joy_refreshHeaderView];
    }
    __weak __typeof(&*self)weakSelf = self;
    return ^(JoyRefreshBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

-(JoyTableAutoLayoutView *(^)(JoyRefreshBlock))joyFooterRefreshblock{
    self.isUpRefreshEnable = YES;
    if (![self.subviews containsObject:self.joy_refreshFooterView]) {
        [self addSubview:self.joy_refreshFooterView];
    }
    __weak __typeof(&*self)weakSelf = self;
    return ^(JoyRefreshBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

-(JoyTableAutoLayoutView *(^)(void))joyEndHeaderRefreshblock{
    [self endHeaderRefreshing];
    __weak __typeof(&*self)weakSelf = self;
    return ^(void){
        return weakSelf;
    };
}

-(JoyTableAutoLayoutView *(^)(void))joyEndFooterRefreshblock{
    [self endFooterRefreshing];
    __weak __typeof(&*self)weakSelf = self;
    return ^(void){
        return weakSelf;
    };
}

-(JoyRefreshHeaderView *)joy_refreshHeaderView{
    if (!_joy_refreshHeaderView) {
        _joy_refreshHeaderView = [[JoyRefreshHeaderView alloc] initWithFrame:CGRectMake(0, -60, SCREEN_W, 60)];
    }
    return _joy_refreshHeaderView;
}

-(JoyRefreshFooterView *)joy_refreshFooterView{
    if (!_joy_refreshFooterView) {
        _joy_refreshFooterView = [[JoyRefreshFooterView alloc] initWithFrame:CGRectMake(0, -60, SCREEN_W, 80)];
    }
    return _joy_refreshFooterView;
}

-(void)dealloc{
    self.dataArrayM = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self removeFromSuperview];
}

@end

@implementation JoyTableBaseView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self.dataArrayM[indexPath.section] rowArrayM][indexPath.row] cellH];
}

@end

#pragma mark 刷新头
@implementation JoyRefreshHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.timeLabel];
        [self addSubview:self.downLoadLabel];
    }
    return self;
}

-(UILabel *)downLoadLabel{
    if (!_downLoadLabel){
        _downLoadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        _downLoadLabel.font = [UIFont systemFontOfSize:25];
        _downLoadLabel.textAlignment = NSTextAlignmentCenter;
        _downLoadLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
    }
    return _downLoadLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel){
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 200, 60)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (void)startRefreshingSize:(CGSize)animationZoneSize{
    self.downLoadLabel.text = @"🌍";//↑
    [CAAnimation showRotateAnimationInView:self.downLoadLabel Degree:M_PI*8 Direction:AxisZ Repeat:0 Duration:1 autoreverses:YES];
    [CAAnimation showBezierPathAnimationView:self.downLoadLabel startPont:CGPointMake(0, self.downLoadLabel.bottom) endPoint:CGPointMake(SCREEN_W, self.downLoadLabel.bottom) controlPoint1:CGPointMake(SCREEN_W/3, -100) controlPoint2:CGPointMake(2*SCREEN_W/3, 100) Repeat:0 Duration:1 autoreverses:YES];
    [CAAnimation showScaleAnimationInView:self.downLoadLabel fromValue:1 ScaleValue:1.7 Repeat:0 Duration:0.5 autoreverses:YES];
}

- (void)endRefreshing{
    self.downLoadLabel.text = @"↓";//↑
    self.timeLabel.text = [self timeStringformat:@"yyyy-MM-dd hh:mm:ss" date:[NSDate date]];
    [CAAnimation clearAnimationInView:self.downLoadLabel];
    self.downLoadLabel.hidden =self.timeLabel.hidden = true;

}

-(NSString*)timeStringformat:(NSString*)format date:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:date];
    dateFormatter = nil;
    return dateString;
}

@end


#pragma mark 刷新尾
@implementation JoyRefreshFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.timeLabel];
        [self addSubview:self.upLoadLabel];
    }
    return self;
}

-(UILabel *)upLoadLabel{
    if (!_upLoadLabel){
        _upLoadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 60, 60)];
        _upLoadLabel.font = [UIFont systemFontOfSize:25];
        _upLoadLabel.textAlignment = NSTextAlignmentCenter;
        _upLoadLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
    }
    return _upLoadLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel){
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 200, 60)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (void)startRefreshingSize:(CGSize)animationZoneSize{
    self.upLoadLabel.text = @"⚽️";//↑
    [CAAnimation showRotateAnimationInView:self.upLoadLabel Degree:M_PI*8 Direction:AxisZ Repeat:0 Duration:1 autoreverses:YES];
    [CAAnimation showBezierPathAnimationView:self.upLoadLabel startPont:CGPointMake(0, self.upLoadLabel.bottom) endPoint:CGPointMake(SCREEN_W, self.upLoadLabel.bottom) controlPoint1:CGPointMake(SCREEN_W/3, -100) controlPoint2:CGPointMake(2*SCREEN_W/3, 60) Repeat:0 Duration:1 autoreverses:YES];
    [CAAnimation showScaleAnimationInView:self.upLoadLabel fromValue:1 ScaleValue:1.7 Repeat:0 Duration:0.5 autoreverses:YES];
}

- (void)endRefreshing{
    self.upLoadLabel.text = @"↑";//↑
    self.timeLabel.text = [self timeStringformat:@"yyyy-MM-dd hh:mm:ss" date:[NSDate date]];
    [CAAnimation clearAnimationInView:self.upLoadLabel];
    self.upLoadLabel.hidden =self.timeLabel.hidden = true;
}

-(NSString*)timeStringformat:(NSString*)format date:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:date];
    dateFormatter = nil;
    return dateString;
}

@end
