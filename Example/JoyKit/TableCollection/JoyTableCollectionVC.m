//
//  JoyVC.m
//  Home
//
//  Created by joy on 2021/8/10.
//

#import "JoyTableCollectionVC.h"
#import <JoyKit/JoyKit.h>
#import "JoyTableCollectionInteractor.h"
#import <Masonry/Masonry.h>

@interface JoyTableCollectionVC ()
@property(nonatomic,strong)JoyTableAutoLayoutView *tableView;
@property(nonatomic,strong)JoyTableCollectionInteractor *interactor;
@property (nonatomic, strong) UIButton *searchBtn;

@end

@implementation JoyTableCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    [self setConstraints];
    [self requestData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.reloadTable();
}

-(void)addSubViews{
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
}

-(void)setConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)requestData{
    __weak __typeof(self)weakSelf = self;
    [self.interactor requestDataSource:^{
        [weakSelf reloadData];
    } failure:^(NSError *error) {
            
    }];
}

-(void)reloadData{
    __weak __typeof(&*self)weakSelf = self;
    self.tableView.setDataSource(self.interactor.dataArrayM).reloadTable().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {

    }).collectionDidSelect(^(NSIndexPath *indexPath, NSIndexPath *collectionIndexPath) {
        JoyTableCollectionCellBaseModel *model = [self.interactor.dataArrayM objectAtIndex:indexPath.row];
        JoySectionBaseModel *collectionSectionModel = [model.itemList objectAtIndex:collectionIndexPath.section];
        JoyImageCellBaseModel *collectionRowModel = [collectionSectionModel.rowArrayM objectAtIndex:collectionIndexPath.row];
    });
}

-(JoyTableAutoLayoutView *)tableView{
    if(!_tableView){
        _tableView = [[JoyTableAutoLayoutView alloc]initWithFrame:CGRectZero];
        _tableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = _tableView.tableView.backgroundColor = UIColor.whiteColor;
        _tableView.setTableFootView([[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 100)]);
        
    }
    return _tableView;
}

-(JoyTableCollectionInteractor *)interactor{
    return _interactor = _interactor?:[[JoyTableCollectionInteractor alloc]init];
}
@end
