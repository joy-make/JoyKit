# JoyKit

[![CI Status](http://img.shields.io/travis/joy-make/JoyKit.svg?style=flat)](https://travis-ci.org/joy-make/JoyKit)
[![Version](https://img.shields.io/cocoapods/v/JoyKit.svg?style=flat)](http://cocoapods.org/pods/JoyKit)
[![License](https://img.shields.io/cocoapods/l/JoyKit.svg?style=flat)](http://cocoapods.org/pods/JoyKit)
[![Platform](https://img.shields.io/cocoapods/p/JoyKit.svg?style=flat)](http://cocoapods.org/pods/JoyKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JoyKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JoyKit'
```

## Author

joy-make, wanggp@sqbj.com
### [功能描述地址:🦆](https://www.jianshu.com/p/7bd5e43c50b3)
```
JoyKit 是笔者开发并使用了三年多的UI快速开发组件、早早就开源了不过一直懒得写文档、最近准备补一下文档、提供功能如下
```
```
1.Views(模型驱动、链式调用的TableView、CollectionView)
```
```
2.Router(模块解耦的Router路由模块、支持页面跳转、数据通讯、数据回调)
```
```
3.Views(数据驱动支持自定义工具栏的PickView、DatePickView、SegmentView)
```
```
4.Utility(打电话、发短信、发邮件、超链接的工具模块)
```
```
5.JoyQRCode(二维码扫描模块)
```
```
6.JoyMediaRecordPlay(小视频录制、播放模块)
```
```
7. JoyLocation(链式调用的定位模块(基于原生的纯定位不带UI)
```
```
8.JoyCoreMotion(运动数据、陀螺仪模块)
```
```
9.viper设计模式的基础功能模块(VC、Interactor、Presenter、Router、Model)
```
```
10.CellsLibruary(常用的15种支持自定义的列表cell)
```
```
11.Category(常用category模块 快速播放音频文件、7种CAAnimation动画、基于CALayer的转场动画、NSArray/NSDictionary防Crash以及数十种功能扩展、NSDate常用计算功能扩展、NSObject方法替换及方法映射、NSString常用功能扩展、UIButton自定义点击区域扩展、UIColor各种色纸转换方式扩展、UIImage截屏/二维码生成/裁剪/变色/存相册等快捷扩展、UITextField设置最大字数以及超限提示语、UIView常用位移/生成图片等、UIWindow亮屏监听等)
```
```
12.常用宏定义、常用类型的Block定义
```
[功能一讲解(通过本地或服务端json配置页面UI)]()
![json配置TableUI](https://upload-images.jianshu.io/upload_images/1488115-55b7a60c0bc42901.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

##### PersonInteractor数据源(读取json数据源生成Table可识别的数据源(),json文件可配置cell样式、cell内、cell的事件)

```
@interface PersonInteractor : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;
- (void)getPersonList:(VOIDBLOCK)success;
@end
```
```

@implementation JoyInteractorBase
-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
```
```
- (void)getConfigData{
    JoySectionBaseModel *sectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:nil sectionH:0 sectionTitle:@""];
    NSArray *data = (NSArray *)[[self readLocalFileWithName:@"personDetail"] objectForKey:@"style"];
    for (NSDictionary *dict in data) {
        JoyCellBaseModel *cellModel = [JoyCellBaseModel initWithStyle:[dict[@"style"] integerValue] obj:dict];
        if(cellModel.changeKey){
            [cellModel isMemberOfClass:JoyCellBaseModel.class]? cellModel.subTitle = [self.person valueForKey:cellModel.changeKey]:nil;
            [cellModel isMemberOfClass:JoyTextCellBaseModel.class]? cellModel.subTitle = [self.person valueForKey:cellModel.changeKey]:nil;
            [cellModel isMemberOfClass:JoySwitchCellBaseModel.class]?((JoySwitchCellBaseModel*)cellModel).on = [[self.person valueForKey:cellModel.changeKey] boolValue]:nil;
            [cellModel isMemberOfClass:JoyImageCellBaseModel.class]?((JoyImageCellBaseModel*)cellModel).avatar = [self.person valueForKey:cellModel.changeKey]:nil;
        }
        cellModel.titleColor = @"#347AEB";
        cellModel.subTitleColor = @"#CCCCCC";
        [self.dataArrayM addObject:cellModel];
    }
}
```
```
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end

```

##### VC代码
```
@interface SCViewController ()
@property (nonatomic,strong)JoyTableAutoLayoutView *tableView;
@property (nonatomic,strong)PersonInteractor *interactor;
@end
```
```
@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubViews];
    [self reloadDataSource];
}

- (void)addSubViews{
    [self setDefaultConstraintWithView:self.tableView andTitle:@"测试"];//setDefaultConstraintWithView自带约束不需要设置tableView的frame
}
```
```
-(void)reloadDataSource{
  获取Interactor中的数据源dataArrayM
  self.tableView.setDataSource(self.interactor.dataArrayM).reloadTable()即可刷新页面了
  若需要实现cell上的事件可以使用Table的链式回调self.tableView.setDataSource(self.interactor.dataArrayM).reloadTable();
}
```
```
-(JoyTableAutoLayoutView *)tableView{
    return _tableView = _tableView?:[[JoyTableAutoLayoutView alloc]init];
}
```
```
-(PersonInteractor *)interactor{
    return _interactor = _interactor?:[[PersonInteractor alloc]init];
}
```

  若需要实现cell上的事件可以使用Table的链式回调
```
self.tableView.cellTextEiditEnd(^(NSIndexPath *indexPath, NSString *content, NSString *key) {
        key?[weakSelf.interactor.person setValue:content forKey:key]:nil;
    })
    .cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [weakSelf performTapAction:tapAction];//如json中配置某一行tapAction为@“goNextPage”,那么直接在.m中实现-(void) goNextPage 即可
    })
    .cellEiditAction(^(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath) {
        [JoyAlert showWithMessage:@"编辑事件"];
    })
    .cellMoveAction(^(NSIndexPath *sourceIndexPath,NSIndexPath *toIndexPath){
        [JoyAlert showWithMessage:@"挪移事件"];
    })
    .cellTextCharacterHasChanged(^(NSIndexPath *indexPath, NSString *content, NSString *key){
        //文本字符发生变化、开关按钮等
      如person对象的key为age
         [self. person setValue: content  forKey: key]
    });;
```

##### [功能二讲解(自定义cell怎么和JoyTableAutoLayoutView配套使用)]()
待补充
##### [功能三讲解(JoyRouter路由)]()
待补充
##### [功能.......讲解(......)]()
待补充
## License

JoyKit is available under the MIT license. See the LICENSE file for more info.
