//
//  JoyInteractor.m
//  Home
//
//  Created by joy on 2021/8/10.
//

#import "JoyTableCollectionInteractor.h"


@implementation JoyTableCollectionInteractor
-(void)requestDataSource:(VOIDBLOCK)success failure:(ERRORBLOCK)failure{
    //单行单列
    [self.dataArrayM addObject:[self getSingleTableModel]];

    //通知消息
    [self.dataArrayM addObject:[self getNoticesTableModel]];
    
    //多行四列
    [self.dataArrayM addObject:[self getQuadraTableModel]];
    
    //多行五列
    [self.dataArrayM addObject:[self getPentalTableModel]];

    //多行三列
    [self.dataArrayM addObject:[self getTripleTableModel]];

    //单行单列缩小版
    [self.dataArrayM addObject:[self getSingleMiniTableModel]];

    JoyCellBaseModel *moreNewsModel = [[JoyCellBaseModel alloc]init];
    moreNewsModel.title = @"党内要闻";
    moreNewsModel.subTitle = @"更多";
    moreNewsModel.cellName = @"JoyListMoreCell";
    moreNewsModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArrayM addObject:moreNewsModel];

    for (NSString *url in @[@"https://upload-images.jianshu.io/upload_images/1488115-b3ac45b90fff37f5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",@"https://upload-images.jianshu.io/upload_images/1488115-8d4b089fe77df771.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]) {
        JoyImageCellBaseModel *model = [[JoyImageCellBaseModel alloc]init];
        model.cellName = @"JoyListCell";
        model.avatar = url;
        [self.dataArrayM addObject:model];
    }

    [self.dataArrayM addObject:[self getDoubleTableModel]];
    [self.dataArrayM addObject:[self getDoubleLeftRightTableModel]];
    
    //单行双列右icon
    [self.dataArrayM addObject:[self getDoubleNormalTableModel]];
    
    //单行双列左icon
    [self.dataArrayM addObject:[self getDoubleNormalLeftIconTableModel]];
    
    success?success():nil;
}

//单行两列
-(JoyTableCollectionCellBaseModel *)getDoubleLeftRightTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoyLeftSingleRightDoubleCell";
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar =@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng662bf1b7bed2197c5c9ab3561cd2f6a122fefbdb3ceaf3e86c0585c1ed9a21ba";
        collectionModel.placeHolderImageStr = @"template_cover_3.png";
        collectionModel.title = @"节日慰问";
        collectionModel.subTitle = @"节日慰问节日慰问";
        collectionModel.cellName = @"JoyTopIconTitleSubTitleCollectionCell";
    collectionModel.backgroundColor = @"#FB5053";
        [sectionModel.rowArrayM addObject:collectionModel];
    
    for (NSString *title in @[@"政策制度",@"人员培训"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar = @[@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng79b3ec785d9682cc11cde7f3de04c30533c9f54c435a6b32c701c6d05b5baaab",@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng897ca72c960dd6c5c771ea1cada2814ca7c87082a13dc6e3c842df0b517efdb4"][arc4random()%2];
        collectionModel.placeHolderImageStr = @"template_cover_3.png";
        collectionModel.title = title;
        collectionModel.subTitle = @"政策制度政策制度";
        collectionModel.backgroundColor = @[@"#24CCAA",@"#2AA9F7"][arc4random()%2];
        collectionModel.cellName = @"JoyLeftIconRightDoubleTitleCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    
    JoyImageCellBaseModel *collectionModel2 = [[JoyImageCellBaseModel alloc]init];
    collectionModel2.avatar =@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng662bf1b7bed2197c5c9ab3561cd2f6a122fefbdb3ceaf3e86c0585c1ed9a21ba";
    collectionModel2.placeHolderImageStr = @"template_cover_3.png";
    collectionModel2.title = @"节日慰问";
    collectionModel2.subTitle = @"节日慰问节日慰问";
    collectionModel2.cellName = @"JoyTopIconTitleSubTitleCollectionCell";
    collectionModel2.backgroundColor = @"#AA5053";
    [sectionModel.rowArrayM addObject:collectionModel2];
    
    for (NSString *title in @[@"政策制度",@"人员培训"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar = @[@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng79b3ec785d9682cc11cde7f3de04c30533c9f54c435a6b32c701c6d05b5baaab",@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng897ca72c960dd6c5c771ea1cada2814ca7c87082a13dc6e3c842df0b517efdb4"][arc4random()%2];
        collectionModel.placeHolderImageStr = @"template_cover_3.png";
        collectionModel.title = title;
        collectionModel.subTitle = @"政策制度政策制度";
        collectionModel.backgroundColor = @[@"#33CCAA",@"#10A9F7"][arc4random()%2];
        collectionModel.cellName = @"JoyLeftIconRightDoubleTitleCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

//单行单列
-(JoyTableCollectionCellBaseModel *)getSingleTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoySigleTableCell";
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    for (NSString *avatar in @[@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPnga622b648d20ceb7a40251fc1d46f3fe2fd68d75cae1c4543660f6f121b38f07e",
        @"https://tse1-mm.cn.bing.net/th/id/R-C.552a01c08c5aa7156488e0afd6cb641f?rik=maEiUgEUjiR8%2bA&riu=http%3a%2f%2fwww.jnwhsj.com%2fuploadfile%2f2020%2f1225%2f20201225014901646.jpg&ehk=GQTLlJ84kYGtTdeDW6uKIV9unM3TXGNUVgPjEL29pTQ%3d&risl=&pid=ImgRaw&r=0"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar = avatar;
        collectionModel.placeHolderImageStr = @"template_cover_4.png";
        collectionModel.cellName = @"JoySigleCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

//消息通知
-(JoyTableCollectionCellBaseModel *)getNoticesTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoyLeftImageRightCollectionTableCell";
    tableModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    for (NSString *title in @[@"坚持两手抓 夺取双胜利向党和人民交出国",@"节日慰问"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.title = title;
        collectionModel.cellName = @"JoyNoticesCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

//单行四列
-(JoyTableCollectionCellBaseModel *)getQuadraTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoyQuadraTableCell";
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    for (NSString *title in @[@"党费缴纳",@"入党时间",@"节日慰问",@"会议查询",@"党费缴纳",@"入党时间",@"党费缴纳",@"入党时间"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar = @"https://img.zcool.cn/community/01e6d55bfd3bfca80121ab5dbcec6b.jpg@1280w_1l_2o_100sh.jpg";
        collectionModel.placeHolderImageStr = @"template_cover_4.png";
        collectionModel.title = title;
        collectionModel.cellName = @"JoyQuadraCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

//单行五列
-(JoyTableCollectionCellBaseModel *)getPentalTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoyPentaTableCell";
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    for (NSString *title in @[@"党费缴纳",@"入党时间",@"节日慰问",@"会议查询",@"党费缴纳"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar = @"https://img.zcool.cn/community/01e6d55bfd3bfca80121ab5dbcec6b.jpg@1280w_1l_2o_100sh.jpg";
        collectionModel.placeHolderImageStr = @"template_cover_4.png";
        collectionModel.title = title;
        collectionModel.cellName = @"JoyPentalCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

//单行三列
-(JoyTableCollectionCellBaseModel *)getTripleTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoyTripleTableCell";
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    for (NSString *title in @[@"入党指南",@"提交材料",@"申请消息"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar = @"https://tse1-mm.cn.bing.net/th/id/R-C.1461d7e7c564598275379a61d39105e5?rik=u30C9sGj8bT27Q&riu=http%3a%2f%2fimg7.banyuetan.org%2fgroup1%2fM00%2f00%2f20%2fCn4AP1s8HSiANL3QAABrOl9Qrsc306.jpg&ehk=297GLh3bwe8kYD%2bLz92gLqGtg8T0OAueJ2gEadJ60Z4%3d&risl=&pid=ImgRaw&r=0";
        collectionModel.placeHolderImageStr = @"template_cover_3.png";
        collectionModel.title = title;
        collectionModel.cellName = @"JoyTripleCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

//单行单列缩小版
-(JoyTableCollectionCellBaseModel *)getSingleMiniTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoySigleMiniTableCell";
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    for (int i=0; i<3; i++) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar = @"https://upload-images.jianshu.io/upload_images/1488115-abc32cd68f2ee6f8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
        collectionModel.placeHolderImageStr = @"banner";
        collectionModel.cellName = @"JoySigleMiniCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

//单行两列
-(JoyTableCollectionCellBaseModel *)getDoubleTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoyDoubleTableCell";
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    for (NSString *title in @[@"中印通过党际渠道举办抗疫经验视频交…",@"宋涛：搞污名化只会阻 碍国际抗疫合作",@"宋涛：搞污名化只会阻 碍国际抗疫合作",@"宋涛：搞污名化只会阻 碍国际抗疫合作",@"宋涛：搞污名化只会阻 碍国际抗疫合作",@"宋涛：搞污名化只会阻 碍国际抗疫合作",@"宋涛：搞污名化只会阻 碍国际抗疫合作"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar = @[@"https://tse1-mm.cn.bing.net/th/id/R-C.7455e5d3e3e915d06b16b49b3ee81af3?rik=13HhpoaRTSJyFA&riu=http%3a%2f%2fimg4.cache.netease.com%2fphoto%2f0001%2f2013-08-12%2f962KBQAL4T8E0001.jpg&ehk=lzd057qBFBBBPUJK5dxKACo%2fw3ar8sr6VUdf3tstZ%2fo%3d&risl=&pid=ImgRaw&r=0",@"https://upload-images.jianshu.io/upload_images/1488115-f7ea704f97d8289e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"][arc4random()%2] ;
        collectionModel.placeHolderImageStr = @"template_cover_3.png";
        collectionModel.title = title;
        collectionModel.cellName = @"JoyDoubleCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

//单行两列
-(JoyTableCollectionCellBaseModel *)getDoubleNormalTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoyDoubleNormalTableCell";
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    for (NSString *title in @[@"政策制度",@"人员培训"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar =@[@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng79b3ec785d9682cc11cde7f3de04c30533c9f54c435a6b32c701c6d05b5baaab",@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng897ca72c960dd6c5c771ea1cada2814ca7c87082a13dc6e3c842df0b517efdb4"][arc4random()%2];
        collectionModel.title = title;
        collectionModel.subTitle = @"政策制度政策制度";
        collectionModel.backgroundColor = @[@"#24CCAA",@"#2AA9F7"][arc4random()%2];
        collectionModel.cellName = @"JoyDoubleTitleRightIconlCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

//单行两列
-(JoyTableCollectionCellBaseModel *)getDoubleNormalLeftIconTableModel{
    JoyTableCollectionCellBaseModel *tableModel = [[JoyTableCollectionCellBaseModel alloc]init];
    tableModel.cellName = @"JoyDoubleNormalTableCell";
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    for (NSString *title in @[@"政策制度",@"人员培训"]) {
        JoyImageCellBaseModel *collectionModel = [[JoyImageCellBaseModel alloc]init];
        collectionModel.avatar = @[@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng79b3ec785d9682cc11cde7f3de04c30533c9f54c435a6b32c701c6d05b5baaab",@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng897ca72c960dd6c5c771ea1cada2814ca7c87082a13dc6e3c842df0b517efdb4"][arc4random()%2];
        collectionModel.title = title;
        collectionModel.subTitle = @"政策制度政策制度";
        collectionModel.backgroundColor = @[@"#24DDAA",@"#44A9F7",@"#748744",@"#583952"][arc4random()%4];
        collectionModel.cellName = @"JoyLeftIconRightDoubleTitleCollectionCell";
        [sectionModel.rowArrayM addObject:collectionModel];
    }
    [tableModel.itemList addObject:sectionModel];
    return tableModel;;
}

@end
