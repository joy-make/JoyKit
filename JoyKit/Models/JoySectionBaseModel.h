//
//  JoySectionBaseModel
//  Toon
//
//  Created by joymake on 16/3/23.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^HeaderFooterBlock)(id obj);

typedef void(^HeaderFooterAToBCellBlock)(id obj);

@interface JoySectionBaseModel : NSObject

@property (nonatomic,strong)NSMutableArray *rowArrayM;

@property (nonatomic,assign)CGFloat sectionH;

@property (nonatomic,assign)CGFloat sectionFootH;

@property (nonatomic,copy) NSString *sectionTitle;

@property (nonatomic,copy) NSString *sectionSubTitle;

@property (nonatomic,copy) NSString *sectionFootTitle;

@property (nonatomic,copy) NSString *sectionKey;

@property (nonatomic,assign) CGFloat sectionLeadingOffSet;

@property (nonatomic,copy) NSString *sectionHeadViewName;

@property (nonatomic,copy) NSString *sectionFootViewName;

@property (nonatomic,strong) NSObject *headObj;

@property (nonatomic,strong) NSObject *footObj;

//headerFooter事件事件回调时实现model的回调函数，执行此函数
@property (nonatomic,copy)HeaderFooterBlock                             headerFooterBlock;

//headerFooter正向传值,以减少没必要的cell刷新
@property (nonatomic,copy)HeaderFooterAToBCellBlock                     headerFooterAToBBlock;

+ (instancetype)sectionWithHeaderModel:(id)sectionHeaderModel footerModel:(id)sectionFooterModel cellModels:(NSArray *)cellModels sectionH:(CGFloat)sectionH sectionTitle:(NSString *)sectionTitle;
@end
