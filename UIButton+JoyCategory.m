//
//  UIButton+JoyCategory.m
//  JoyKit
//
//  Created by Joymake on 2016/5/31.
//

#import "UIButton+JoyCategory.h"
#import <objc/runtime.h>

static char joyTopEdgeKey;
static char joyLeftEdgeKey;
static char joyBottomEdgeKey;
static char joyRightEdgeKey;


@implementation UIButton (JoyCategory)

- (void)enLargeEdge:(CGFloat)distance{
    objc_setAssociatedObject(self, &joyTopEdgeKey,   [NSNumber numberWithFloat:distance], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &joyLeftEdgeKey,  [NSNumber numberWithFloat:distance], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &joyBottomEdgeKey,[NSNumber numberWithFloat:distance], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &joyRightEdgeKey, [NSNumber numberWithFloat:distance], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)enlargeEdgeWithTop:(CGFloat) top left:(CGFloat) left bottom:(CGFloat) bottom right:(CGFloat) right
{
    objc_setAssociatedObject(self, &joyTopEdgeKey,   [NSNumber numberWithFloat:top],   OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &joyLeftEdgeKey,  [NSNumber numberWithFloat:left],  OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &joyBottomEdgeKey,[NSNumber numberWithFloat:bottom],OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &joyRightEdgeKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber* joyTopEdge    = objc_getAssociatedObject(self, &joyTopEdgeKey);
    NSNumber* joyRightEdge  = objc_getAssociatedObject(self, &joyRightEdgeKey);
    NSNumber* joyBottomEdge = objc_getAssociatedObject(self, &joyBottomEdgeKey);
    NSNumber* joyLeftEdge   = objc_getAssociatedObject(self, &joyLeftEdgeKey);
    //通过修改bounds 的x,y 值就可以只向X 轴或者Y轴的某一个方向扩展
    //当bounds 的X 为负,Y 为0,就只向X的正方向扩展点击区域,反之亦然
    if (joyTopEdge && joyRightEdge && joyBottomEdge && joyLeftEdge)
    {
        return CGRectMake(self.bounds.origin.x    - joyLeftEdge.floatValue,
                          self.bounds.origin.y    - joyTopEdge.floatValue,
                          self.bounds.size.width  + joyLeftEdge.floatValue + joyRightEdge.floatValue,
                          self.bounds.size.height + joyTopEdge.floatValue + joyBottomEdge.floatValue);
        
    } else
    {
        return self.bounds;
    }
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self enlargedRect];
    
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}
@end
