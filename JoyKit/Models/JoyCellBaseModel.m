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


//+ (NSArray *)mj_ignoredPropertyNames{
//    return @[@"cellType",@"cellName",@"backgroundColor",@"title",@"titleColor",@"subTitle",@"subTitleColor",@"topicTitle",@"expandObj",@"accessoryType",@"editingStyle",@"bundleName",@"placeHolder",@"cellH",@"tapAction",@"longPressAction",@"changeKey",@"valuechangeAction",@"rowLeadingOffSet",@"disable",@"selected",@"cellBlock",@"aToBCellBlock",@"borderStyle",@"secureTextEntry",@"textFieldModel",@"clearButtonMode",@"maxNumber",@"keyboardType",@"avatarBundleName",@"avatar",@"viewShape",@"placeHolderImageStr",@"on",@"switchBackColor",@"onTintColor",@"itemList"];
//}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}

-(id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"找不到%@对应的字段",key);
    return nil;
}

-(void)setCellType:(ECellType)cellType{
    [self joy_setObject:@(cellType) forKey:@"cellType"];
}

-(ECellType)cellType{
    NSNumber *number = [self.obj objectForKey:@"cellType"];
    return number?[number integerValue]:0;
}

-(void)setBackgroundColor:(NSString *)backgroundColor{
    [self joy_setObject:backgroundColor forKey:@"backgroundColor"];
}

-(NSString *)backgroundColor{
    return [self.obj objectForKey:@"backgroundColor"];
}

-(void)setTitle:(NSString *)title{
    [self joy_setObject:title forKey:@"title"];
}

-(NSString *)title{
    return [self.obj objectForKey:@"title"];
}

-(NSMutableDictionary *)obj{
    return _obj = _obj?:[NSMutableDictionary dictionary];
}

//标题颜色
-(void)setTitleColor:(NSString *)titleColor{
    [self joy_setObject:titleColor forKey:@"titleColor"];
}

-(NSString *)titleColor{
    return [self.obj objectForKey:@"titleColor"];
};

//副标题
-(void)setSubTitle:(NSString *)subTitle{
    [self joy_setObject:subTitle forKey:@"subTitle"];
}

-(NSString *)subTitle{
    return [self.obj objectForKey:@"subTitle"];
};

//标题颜色
-(void)setSubTitleColor:(NSString *)subTitleColor{
    [self joy_setObject:subTitleColor forKey:@"subTitleColor"];
}

-(NSString *)subTitleColor{
    return [self.obj objectForKey:@"subTitleColor"];
};

//副标题
-(void)setTopicTitle:(NSString *)topicTitle{
    [self joy_setObject:topicTitle forKey:@"topicTitle"];
}

-(NSString *)topicTitle{
    return [self.obj objectForKey:@"topicTitle"];
};

//扩展字段
-(void)setExpandObj:(NSObject *)expandObj{
    [self joy_setObject:expandObj forKey:@"expandObj"];
}

-(NSObject *)expandObj{
    return [self.obj objectForKey:@"expandObj"];
};

//右箭头隐藏与否 yes隐藏 no显示
-(void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType{
    [self joy_setObject:@(accessoryType) forKey:@"accessoryType"];
}

-(UITableViewCellAccessoryType )accessoryType{
    NSNumber *number = [self.obj objectForKey:@"accessoryType"];
    return number?[number integerValue]:UITableViewCellAccessoryNone;
};

//cell的编辑类型
-(void)setEditingStyle:(UITableViewCellEditingStyle)editingStyle{
    [self joy_setObject:@(editingStyle) forKey:@"editingStyle"];
}

-(UITableViewCellEditingStyle )editingStyle{
    NSNumber *number = [self.obj objectForKey:@"editingStyle"];
    return number?[number integerValue]:UITableViewCellEditingStyleNone;
};

//cell的名字,复用使用
-(void)setCellName:(NSString *)cellName{
    [self joy_setObject:cellName forKey:@"cellName"];
}

-(NSString *)cellName{
    return [self.obj objectForKey:@"cellName"];
};

//bundleName xib且非公共cell时,需要传自己的bundle名字
-(void)setBundleName:(NSString *)bundleName{
    [self joy_setObject:bundleName forKey:@"bundleName"];
}

-(NSString *)bundleName{
    return [self.obj objectForKey:@"bundleName"];
};

//二级副标题
-(void)setPlaceHolder:(NSString *)placeHolder{
    [self joy_setObject:placeHolder forKey:@"placeHolder"];
}

-(NSString *)placeHolder{
    return [self.obj objectForKey:@"placeHolder"];
};

//cell的高度
-(void)setCellH:(CGFloat)cellH{
    [self joy_setObject:@(cellH) forKey:@"cellH"];
}

-(CGFloat )cellH{
    NSNumber *number = [self.obj objectForKey:@"cellH"];
    return number?[number floatValue]:0;
};

//点击事件的sel name 在子类中实现
-(void)setTapAction:(NSString *)tapAction{
    tapAction?[self joy_setObject:tapAction forKey:@"tapAction"]:nil;
}

-(NSString *)tapAction{
    return [self.obj objectForKey:@"tapAction"];
};

//长按的sel name 在子类中实现
-(void)setLongPressAction:(NSString *)longPressAction{
    longPressAction?[self joy_setObject:longPressAction forKey:@"longPressAction"]:nil;
}

-(NSString *)longPressAction{
    return [self.obj objectForKey:@"longPressAction"];
};

//文本类cell text发生变化时传回的key值用于修改对象对应的值
-(void)setChangeKey:(NSString *)changeKey{
    changeKey?[self joy_setObject:changeKey forKey:@"changeKey"]:nil;
}

-(NSString *)changeKey{
    return [self.obj objectForKey:@"changeKey"];
};

//值改变事件
-(void)setValuechangeAction:(NSString *)valuechangeAction{
    valuechangeAction?[self joy_setObject:valuechangeAction forKey:@"valuechangeAction"]:nil;
}

-(NSString *)valuechangeAction{
    return [self.obj objectForKey:@"valuechangeAction"];
};

-(void)setRowLeadingOffSet:(CGFloat)rowLeadingOffSet{
    [self joy_setObject:@(rowLeadingOffSet) forKey:@"rowLeadingOffSet"];
}

-(CGFloat)rowLeadingOffSet{
    NSNumber *number = [self.obj objectForKey:@"rowLeadingOffSet"];
    return number?[number floatValue]:0;
}

-(void)setDisable:(bool)disable{
    [self joy_setObject:@(disable) forKey:@"disable"];
}

-(bool )disable{
    NSNumber *number = [self.obj objectForKey:@"disable"];
    return number?[number boolValue]:NO;
};

-(void)setSelected:(bool)selected{
    [self joy_setObject:@(selected) forKey:@"selected"];
}

-(bool )selected{
    NSNumber *number = [self.obj objectForKey:@"selected"];
    return number?[number boolValue]:NO;
};


//点击事件回调时实现model的回调函数，执行此函数
-(void)setCellBlock:(CellBlock)cellBlock{
    [self joy_setObject:cellBlock forKey:@"cellBlock"];
}

-(CellBlock)cellBlock{
    return [self.obj objectForKey:@"cellBlock"];
}

//正向传值,以减少没必要的cell刷新
-(void)setAToBCellBlock:(AToBCellBlock)aToBCellBlock{
    [self joy_setObject:aToBCellBlock forKey:@"aToBCellBlock"];
}

-(AToBCellBlock)aToBCellBlock{
    return [self.obj objectForKey:@"aToBCellBlock"];
}

- (void)joy_setObject:(id)obj forKey:(NSString *)key{
    if(obj &&key){
        [self.obj setObject:obj forKey:key];
    }else if([self.obj objectForKey:key]!=nil){
        [self.obj removeObjectForKey:key];
    }
}

@end


@implementation JoyTextCellBaseModel

-(void)setBorderStyle:(UITextBorderStyle)borderStyle{
    [self joy_setObject:@(borderStyle) forKey:@"borderStyle"];
}

-(UITextBorderStyle)borderStyle{
    NSNumber *number = [self.obj objectForKey:@"borderStyle"];
    return number?[number integerValue]:UITextBorderStyleNone;
}

- (void)setSecureTextEntry:(bool)secureTextEntry{
    [self joy_setObject:@(secureTextEntry) forKey:@"secureTextEntry"];
}

-(bool)secureTextEntry{
    NSNumber *number = [self.obj objectForKey:@"secureTextEntry"];
    return number?[number boolValue]:NO;
}

-(void)setTextFieldModel:(ETextCellType)textFieldModel{
    [self joy_setObject:@(textFieldModel) forKey:@"textFieldModel"];
}

-(ETextCellType)textFieldModel{
    NSNumber *number = [self.obj objectForKey:@"textFieldModel"];
    return number?[number integerValue]:leftViewModel;
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode{
    [self joy_setObject:@(clearButtonMode) forKey:@"clearButtonMode"];
}

-(UITextFieldViewMode)clearButtonMode{
    NSNumber *number = [self.obj objectForKey:@"clearButtonMode"];
    return number?[number integerValue]:UITextFieldViewModeNever;
}

-(void)setMaxNumber:(NSInteger)maxNumber{
    [self joy_setObject:@(maxNumber) forKey:@"maxNumber"];
}

-(NSInteger)maxNumber{
    NSNumber *number = [self.obj objectForKey:@"maxNumber"];
    return number?[number integerValue]:0;
}

-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    [self joy_setObject:@(keyboardType) forKey:@"keyboardType"];
}

-(UIKeyboardType)keyboardType{
    NSNumber *number = [self.obj objectForKey:@"keyboardType"];
    return number?[number integerValue]:UIKeyboardTypeDefault;
}

@end

@implementation JoyImageCellBaseModel

-(void)setAvatarBundleName:(NSString *)avatarBundleName{
    [self joy_setObject:avatarBundleName forKey:@"avatarBundleName"];
}

-(NSString *)avatarBundleName{
    return [self.obj objectForKey:@"avatarBundleName"];
}

-(void)setAvatar:(NSString *)avatar{
    [self joy_setObject:avatar forKey:@"avatar"];
}

-(NSString *)avatar{
    return [self.obj objectForKey:@"avatar"];
}

-(void)setViewShape:(EImageType)viewShape{
    [self joy_setObject:@(viewShape) forKey:@"viewShape"];
}

-(EImageType)viewShape{
    NSNumber *number = [self.obj objectForKey:@"viewShape"];
    return number?[number integerValue]:EImageTypeRound;
}

-(void)setPlaceHolderImageStr:(NSString *)placeHolderImageStr{
    placeHolderImageStr?[self joy_setObject:placeHolderImageStr forKey:@"placeHolderImageStr"]:nil;
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

