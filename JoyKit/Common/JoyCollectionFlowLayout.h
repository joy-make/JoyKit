//
//  JoyCollectionFlowLayout.h
//  JoyKit_Example
//
//  Created by Joymake on 2019/1/21.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,AlignType){
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};

@interface JoyCollectionFlowLayout : UICollectionViewFlowLayout
//cell对齐方式
@property (nonatomic,assign)AlignType cellType;

-(instancetype)initWithType:(AlignType)cellType;
//全能初始化方法 其他方式初始化最终都会�走到这里

@end

NS_ASSUME_NONNULL_END
