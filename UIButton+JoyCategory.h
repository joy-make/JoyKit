//
//  UIButton+JoyCategory.h
//  JoyKit
//
//  Created by Joymake on 2016/5/31.
//

#import <UIKit/UIKit.h>

@interface UIButton (JoyCategory)

/**
 扩充点击区域
 @param distance 扩充大小
 */
- (void)enLargeEdge:(CGFloat)distance;

/**
 扩充四周点击区域
 @param top 顶部
 @param left 左边
 @param bottom 底部
 @param right 右边
 */
- (void)enlargeEdgeWithTop:(CGFloat) top left:(CGFloat) left bottom:(CGFloat) bottom right:(CGFloat) right;
@end
