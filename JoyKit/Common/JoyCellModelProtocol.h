//
//  TNACellModelProtocol.h
//  Toon
//
//  Created by joymake on 2016/12/27.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JoyCellModelProtocol <NSObject>
// 背景色
@property (nonatomic,strong) UIColor                            *backgroundColor;

//标题
@property (nonatomic,copy)    NSString                          *title;

//标题颜色
@property (nonatomic,strong)    UIColor                         *titleColor;

//副标题
@property (nonatomic,copy)    NSString                          *subTitle;

//标题颜色
@property (nonatomic,strong)    UIColor                         *subTitleColor;

//副标题
@property (nonatomic,copy)    NSString                          *topicTitle;

//扩展字段
@property (nonatomic,strong)NSObject                            *expandObj;

//右箭头隐藏与否 yes隐藏 no显示
@property (nonatomic,assign)  UITableViewCellAccessoryType      accessoryType;

//cell的编辑类型
@property (nonatomic,assign) UITableViewCellEditingStyle        editingStyle;

//cell的名字,复用使用
@property (nonatomic,copy)    NSString                          *cellName;

//bundleName xib且非公共cell时,需要传自己的bundle名字
@property (nonatomic,copy)    NSString                          *bundleName;

//二级副标题
@property (nonatomic,copy)    NSString                          *placeHolder;

//cell的高度
@property (nonatomic,assign)  CGFloat                           cellH;

//点击事件的sel name 在子类中实现
@property (nonatomic,copy)    NSString                          *tapAction;

//长按的sel name 在子类中实现
@property (nonatomic,copy)    NSString                          *longPressAction;

//文本类cell text发生变化时传回的key值用于修改对象对应的值
@property (nonatomic,copy)    NSString                          *changeKey;

//值改变事件
@property (nonatomic,copy)    NSString                          *valuechangeAction;

@property (nonatomic,assign)  bool                              disable;

@property (nonatomic,assign) BOOL                               canMove;

@property (nonatomic,assign) BOOL                               selected;
@end
