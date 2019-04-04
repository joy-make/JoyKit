//
//  JoyCellBaseModel
//  Toon
//
//  Created by joymake on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyCellBaseModel.h"

@interface JoyCellBaseModel ()
@property (nonatomic,copy) NSMutableDictionary                  *obj;
@end


@implementation JoyCellBaseModel
+ (NSArray *)mj_ignoredPropertyNames{
    return @[];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}

-(id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"找不到%@对应的字段",key);
    return nil;
}

-(void)setCellType:(ECellType)cellType{
    [self.obj setObject:@(cellType) forKey:@"cellType"];
}

-(ECellType)cellType{
    NSNumber *number = [self.obj objectForKey:@"cellType"];
    return number?[number integerValue]:0;
}

-(void)setBackgroundColor:(NSString *)backgroundColor{
    [self.obj setObject:backgroundColor forKey:@"backgroundColor"];
}

-(NSString *)backgroundColor{
    return [self.obj objectForKey:@"backgroundColor"];
}

-(void)setTitle:(NSString *)title{
    [self.obj setObject:title forKey:@"title"];
}

-(NSString *)title{
    return [self.obj objectForKey:@"title"];
}

-(NSMutableDictionary *)obj{
    return _obj = _obj?:[NSMutableDictionary dictionary];
}

//标题颜色
-(void)setTitleColor:(NSString *)titleColor{
    [self.obj setObject:titleColor forKey:@"titleColor"];
}

-(NSString *)titleColor{
    return [self.obj objectForKey:@"titleColor"];
};

//副标题
-(void)setSubTitle:(NSString *)subTitle{
    [self.obj setObject:subTitle forKey:@"subTitle"];
}

-(NSString *)subTitle{
    return [self.obj objectForKey:@"subTitle"];
};

//标题颜色
-(void)setSubTitleColor:(NSString *)subTitleColor{
    [self.obj setObject:subTitleColor forKey:@"subTitleColor"];
}

-(NSString *)subTitleColor{
    return [self.obj objectForKey:@"subTitleColor"];
};

//副标题
-(void)setTopicTitle:(NSString *)topicTitle{
    [self.obj setObject:topicTitle forKey:@"topicTitle"];
}

-(NSString *)topicTitle{
    return [self.obj objectForKey:@"topicTitle"];
};

//扩展字段
-(void)setExpandObj:(NSObject *)expandObj{
    [self.obj setObject:expandObj forKey:@"expandObj"];
}

-(NSObject *)expandObj{
    return [self.obj objectForKey:@"expandObj"];
};

//右箭头隐藏与否 yes隐藏 no显示
-(void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType{
    [self.obj setObject:@(accessoryType) forKey:@"accessoryType"];
}

-(UITableViewCellAccessoryType )accessoryType{
    NSNumber *number = [self.obj objectForKey:@"accessoryType"];
    return number?[number integerValue]:UITableViewCellAccessoryNone;
};

//cell的编辑类型
-(void)setEditingStyle:(UITableViewCellEditingStyle)editingStyle{
    [self.obj setObject:@(editingStyle) forKey:@"editingStyle"];
}

-(UITableViewCellEditingStyle )editingStyle{
    NSNumber *number = [self.obj objectForKey:@"editingStyle"];
    return number?[number integerValue]:UITableViewCellEditingStyleNone;
};

//cell的名字,复用使用
-(void)setCellName:(NSString *)cellName{
    [self.obj setObject:cellName forKey:@"cellName"];
}

-(NSString *)cellName{
    return [self.obj objectForKey:@"cellName"];
};

//bundleName xib且非公共cell时,需要传自己的bundle名字
-(void)setBundleName:(NSString *)bundleName{
    [self.obj setObject:bundleName forKey:@"bundleName"];
}

-(NSString *)bundleName{
    return [self.obj objectForKey:@"bundleName"];
};

//二级副标题
-(void)setPlaceHolder:(NSString *)placeHolder{
    [self.obj setObject:placeHolder forKey:@"placeHolder"];
}

-(NSString *)placeHolder{
    return [self.obj objectForKey:@"placeHolder"];
};

//cell的高度
-(void)setCellH:(CGFloat)cellH{
    [self.obj setObject:@(cellH) forKey:@"cellH"];
}

-(CGFloat )cellH{
    NSNumber *number = [self.obj objectForKey:@"cellH"];
    return number?[number floatValue]:0;
};

//点击事件的sel name 在子类中实现
-(void)setTapAction:(NSString *)tapAction{
    tapAction?[self.obj setObject:tapAction forKey:@"tapAction"]:nil;
}

-(NSString *)tapAction{
    return [self.obj objectForKey:@"tapAction"];
};

//长按的sel name 在子类中实现
-(void)setLongPressAction:(NSString *)longPressAction{
    longPressAction?[self.obj setObject:longPressAction forKey:@"longPressAction"]:nil;
}

-(NSString *)longPressAction{
    return [self.obj objectForKey:@"longPressAction"];
};

//文本类cell text发生变化时传回的key值用于修改对象对应的值
-(void)setChangeKey:(NSString *)changeKey{
    changeKey?[self.obj setObject:changeKey forKey:@"changeKey"]:nil;
}

-(NSString *)changeKey{
    return [self.obj objectForKey:@"changeKey"];
};

//值改变事件
-(void)setValuechangeAction:(NSString *)valuechangeAction{
    valuechangeAction?[self.obj setObject:valuechangeAction forKey:@"valuechangeAction"]:nil;
}

-(NSString *)valuechangeAction{
    return [self.obj objectForKey:@"valuechangeAction"];
};

-(void)setRowLeadingOffSet:(CGFloat)rowLeadingOffSet{
    [self.obj setObject:@(rowLeadingOffSet) forKey:@"rowLeadingOffSet"];
}

-(CGFloat)rowLeadingOffSet{
    NSNumber *number = [self.obj objectForKey:@"rowLeadingOffSet"];
    return number?[number floatValue]:0;
}

-(void)setDisable:(bool)disable{
    [self.obj setObject:@(disable) forKey:@"disable"];
}

-(bool )disable{
    NSNumber *number = [self.obj objectForKey:@"disable"];
    return number?[number boolValue]:NO;
};

-(void)setSelected:(bool)selected{
    [self.obj setObject:@(selected) forKey:@"selected"];
}

-(bool )selected{
    NSNumber *number = [self.obj objectForKey:@"selected"];
    return number?[number boolValue]:NO;
};


//点击事件回调时实现model的回调函数，执行此函数
-(void)setCellBlock:(CellBlock)cellBlock{
    [self.obj setObject:cellBlock forKey:@"cellBlock"];
}

-(CellBlock)cellBlock{
    return [self.obj objectForKey:@"cellBlock"];
}

//正向传值,以减少没必要的cell刷新
-(void)setAToBCellBlock:(AToBCellBlock)aToBCellBlock{
    [self.obj setObject:aToBCellBlock forKey:@"aToBCellBlock"];
}

-(AToBCellBlock)aToBCellBlock{
    return [self.obj objectForKey:@"aToBCellBlock"];
}

@end


@implementation JoyTextCellBaseModel

-(void)setBorderStyle:(UITextBorderStyle)borderStyle{
    [self.obj setObject:@(borderStyle) forKey:@"borderStyle"];
}

-(UITextBorderStyle)borderStyle{
    NSNumber *number = [self.obj objectForKey:@"borderStyle"];
    return number?[number integerValue]:UITextBorderStyleNone;
}

- (void)setSecureTextEntry:(bool)secureTextEntry{
    [self.obj setObject:@(secureTextEntry) forKey:@"secureTextEntry"];
}

-(bool)secureTextEntry{
    NSNumber *number = [self.obj objectForKey:@"secureTextEntry"];
    return number?[number boolValue]:NO;
}

-(void)setTextFieldModel:(ETextCellType)textFieldModel{
    [self.obj setObject:@(textFieldModel) forKey:@"textFieldModel"];
}

-(ETextCellType)textFieldModel{
    NSNumber *number = [self.obj objectForKey:@"textFieldModel"];
    return number?[number integerValue]:leftViewModel;
}

-(void)setMaxNumber:(NSInteger)maxNumber{
    [self.obj setObject:@(maxNumber) forKey:@"maxNumber"];
}

-(NSInteger)maxNumber{
    NSNumber *number = [self.obj objectForKey:@"maxNumber"];
    return number?[number integerValue]:0;
}

-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    [self.obj setObject:@(keyboardType) forKey:@"keyboardType"];
}

-(UIKeyboardType)keyboardType{
    NSNumber *number = [self.obj objectForKey:@"keyboardType"];
    return number?[number integerValue]:UIKeyboardTypeDefault;
}

@end

@implementation JoyImageCellBaseModel

-(void)setAvatarBundleName:(NSString *)avatarBundleName{
    [self.obj setObject:avatarBundleName forKey:@"avatarBundleName"];
}

-(NSString *)avatarBundleName{
    return [self.obj objectForKey:@"avatarBundleName"];
}

-(void)setAvatar:(NSString *)avatar{
    [self.obj setObject:avatar forKey:@"avatar"];
}

-(NSString *)avatar{
    return [self.obj objectForKey:@"avatar"];
}

-(void)setViewShape:(EImageType)viewShape{
    [self.obj setObject:@(viewShape) forKey:@"viewShape"];
}

-(EImageType)viewShape{
    NSNumber *number = [self.obj objectForKey:@"viewShape"];
    return number?[number integerValue]:EImageTypeRound;
}

-(void)setPlaceHolderImageStr:(NSString *)placeHolderImageStr{
    placeHolderImageStr?[self.obj setObject:placeHolderImageStr forKey:@"placeHolderImageStr"]:nil;
}

-(NSString *)placeHolderImageStr{
    return [self.obj objectForKey:@"placeHolderImageStr"];
}

@end

@implementation JoySwitchCellBaseModel

@end

@implementation JoyTableCollectionCellBaseModel
-(NSMutableArray *)itemList{
    return _itemList = _itemList?:[NSMutableArray array];
}
@end

