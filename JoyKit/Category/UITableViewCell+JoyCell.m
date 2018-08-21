//
//  UITableViewCell+JoyCell.m
//  Toon
//
//  Created by joymake on 2017/3/15.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import "UITableViewCell+JoyCell.h"
#import <objc/runtime.h>

@implementation UITableViewCell (JoyCell)

-(void)setDelegate:(id<JoyCellDelegate>)delegate{
    objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_ASSIGN);
}

-(id<JoyCellDelegate>)delegate{
    return objc_getAssociatedObject(self, @selector(setDelegate:));
}

-(void)setIndex:(NSIndexPath *)index{
    objc_setAssociatedObject(self, _cmd, index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSIndexPath *)index{
    return objc_getAssociatedObject(self, @selector(setIndex:));
}

//-(void)setMaxNum:(NSInteger)maxNum{
//    objc_setAssociatedObject(self, _cmd, @(maxNum), OBJC_ASSOCIATION_ASSIGN);
//}
//
//-(NSInteger)maxNum{
//    return [objc_getAssociatedObject(self, @selector(setMaxNum:)) integerValue];
//}

-(void)setBeginUpdatesBlock:(void (^)(void))beginUpdatesBlock{
    objc_setAssociatedObject(self, _cmd, beginUpdatesBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(void))beginUpdatesBlock{
    return objc_getAssociatedObject(self, @selector(setBeginUpdatesBlock:));
}

-(void)setEndUpdatesBlock:(void (^)(void))endUpdatesBlock{
    objc_setAssociatedObject(self, _cmd, endUpdatesBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(void))endUpdatesBlock{
    return objc_getAssociatedObject(self, @selector(setEndUpdatesBlock:));
}


-(void (^)(void))longPressBlock{
    return objc_getAssociatedObject(self, @selector(setLongPressBlock:));
}

-(void)setLongPressBlock:(void (^)(void))longPressBlock{
    objc_setAssociatedObject(self, _cmd, longPressBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setScrollBlock:(void (^)(NSIndexPath *, UITableViewScrollPosition, BOOL))scrollBlock{
    objc_setAssociatedObject(self, _cmd, scrollBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(NSIndexPath *, UITableViewScrollPosition, BOOL))scrollBlock{
    return objc_getAssociatedObject(self, @selector(setScrollBlock:));
}

-(void)setCollectionDidSelectBlock:(void (^)(NSIndexPath *))collectionDidSelectBlock{
    objc_setAssociatedObject(self, _cmd, collectionDidSelectBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(NSIndexPath *))collectionDidSelectBlock{
    return objc_getAssociatedObject(self, @selector(setCollectionDidSelectBlock:));
}

-(void)setCollectionDeleteBlock:(void (^)(NSIndexPath *))collectionDeleteBlock{
    objc_setAssociatedObject(self, _cmd, collectionDeleteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(NSIndexPath *))collectionDeleteBlock{
    return objc_getAssociatedObject(self, @selector(setCollectionDeleteBlock:));
}
@end
