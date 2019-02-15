//
//  JoyCellBaseModel
//  Toon
//
//  Created by joymake on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyCellBaseModel.h"


@implementation JoyCellBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}

-(id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"找不到%@对应的字段",key);
    return nil;
}

//
////@synthesize cellName = _cellName;
//-(void)setCellName:(NSString *)cellName{
//    _cellName = cellName;
//}
//
//-(NSString *)cellName{
//    return _cellName?:@"JoyLeftMiddleRightLabelCell";
//}

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
    NSNumber *number = [self.obj objectForKey:@"cellType"];
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
    [self.obj setObject:tapAction forKey:@"tapAction"];
}

-(NSString *)tapAction{
    return [self.obj objectForKey:@"tapAction"];
};

//长按的sel name 在子类中实现
-(void)setLongPressAction:(NSString *)longPressAction{
    [self.obj setObject:longPressAction forKey:@"longPressAction"];
}

-(NSString *)longPressAction{
    return [self.obj objectForKey:@"longPressAction"];
};

//文本类cell text发生变化时传回的key值用于修改对象对应的值
-(void)setChangeKey:(NSString *)changeKey{
    [self.obj setObject:changeKey forKey:@"changeKey"];
}

-(NSString *)changeKey{
    return [self.obj objectForKey:@"changeKey"];
};

//值改变事件
-(void)setValuechangeAction:(NSString *)valuechangeAction{
    [self.obj setObject:valuechangeAction forKey:@"valuechangeAction"];
}

-(NSString *)valuechangeAction{
    return [self.obj objectForKey:@"valuechangeAction"];
};

-(void)setDisable:(bool)disable{
    [self.obj setObject:@(disable) forKey:@"disable"];
}

-(bool )disable{
    NSNumber *number = [self.obj objectForKey:@"disable"];
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
//-(NSString *)cellName{
//    return _cellName?:@"JoyTextNoLabelCell";
//}

@end

@implementation JoyImageCellBaseModel
//-(NSString *)cellName{
//    return _cellName?:@"JoyLeftAvatarRightLabelCell";
//}

@end

@implementation JoySwitchCellBaseModel
//-(NSString *)cellName{
//    return _cellName?:@"JoySwitchCell";
//}

@end

@implementation JoyTableCollectionCellBaseModel
-(NSMutableArray *)itemList{
    return _itemList = _itemList?:[NSMutableArray array];
}
@end
//OC最初设定@property和@synthesize的作用：
//
//@property的作用是定义属性，声明getter,setter方法。(注意：属性不是变量)
//@synthesize的作用是实现属性的,如getter，setter方法.
//在声明属性的情况下如果重写setter,getter,方法，就需要把未识别的变量在@synthesize中定义，把属性的存取方法作用于变量。如：
//
//.h文件中
//
//后来因为使用@property灰常频繁，就简略了@synthesize的表达。
//
//从Xcode4.4以后@property已经独揽了@synthesize的功能主要有三个作用：
//
//(1)生成了私有的带下划线的的成员变量因此子类不可以直接访问，但是可以通过get/set方法访问。那么如果想让定义的成员变量让子类直接访问那么只能在.h文件中定义成员　　　　变量了，因为它默认是@protected
//（2)生成了get/set方法的实现
//当：
//用@property声明的成员属性,相当于自动生成了setter getter方法,如果重写了set和get方法,与@property声明的成员属性就不是一个成员属性了,是另外一个实例变量,而这个实例变量需要手动声明。所以会报错误。
//总结：一定要分清属性和变量的区别，不能混淆。@synthesize 声明的属性=变量。意思是，将属性的setter,getter方法，作用于这个变量。
