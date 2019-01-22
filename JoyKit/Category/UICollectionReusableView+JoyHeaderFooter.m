//
//  UICollectionReusableView+JoyHeaderFooter.m
//  JoyKit
//
//  Created by Joymake on 2019/1/21.
//

#import "UICollectionReusableView+JoyHeaderFooter.h"
#import <objc/runtime.h>

@implementation UICollectionReusableView (JoyHeaderFooter)

-(void (^)(NSObject * _Nonnull))headerViewActionBlock{
    return objc_getAssociatedObject(self, @selector(setHeaderViewActionBlock:));
}

-(void)setHeaderViewActionBlock:(void (^)(NSObject * _Nonnull))headerViewActionBlock{
    objc_setAssociatedObject(self, _cmd, headerViewActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
