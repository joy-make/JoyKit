//
//  UITableViewHeaderFooterView+JoyHeaderFooter.m
//  JoyKit
//
//  Created by Joymake on 2018/11/8.
//

#import "UITableViewHeaderFooterView+JoyHeaderFooter.h"
#import <objc/runtime.h>

@implementation UITableViewHeaderFooterView (JoyHeaderFooter)

-(void (^)(NSObject * _Nonnull))headerViewActionBlock{
    return objc_getAssociatedObject(self, @selector(setHeaderViewActionBlock:));
}

-(void)setHeaderViewActionBlock:(void (^)(NSObject * _Nonnull))headerViewActionBlock{
    objc_setAssociatedObject(self, _cmd, headerViewActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
