//
//  UIView+JoyCategory.h
//  Toon
//
//  Created by joymake on 2017/2/27.
//  Copyright © 2017年 JoyMake. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <objc/message.h>

@interface UIView (JoyCategory)
@property(nonatomic,readonly)UIViewController* _Nullable  viewController;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*_Nonnull)descendantOrSelfWithClass:(Class _Nullable )cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*_Nullable)ancestorOrSelfWithClass:(Class _Nonnull )cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 * Calculates the offset of this view from another view in screen coordinates.
 *
 * otherView should be a parent view of this view.
 */
- (CGPoint)offsetFromView:(UIView*_Nullable)otherView;

/**
 +* Retrive all subviews recuisivly in the reciver
 */

- (NSArray*_Nullable)allSubviews;


/**
 view转换图片
 @return 返回转后的image
 */
-(UIImage *_Nullable)snapshotSingleView;

- (UIImage*_Nullable)imageFromRect:(CGRect)rect;

- (void)cutImageFromRect:(CGRect)frame successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;
@end


@interface UIView (JoyEmillterLayer)

//配置粒子（uicontrol 点击时会自动触发动画）
-(void)configEmitterLayer:(UIImage *_Nullable)effectImage;

//参数配置粒子（uicontrol 点击时会自动触发动画）
-(void)configEmitterLayerWithImage:(UIImage *_Nullable)effectImage birthRate:(NSInteger)birthRate velocity:(CGFloat)velocity emitterSize:(CGSize)emitterSize;

//手动开启粒子发生器并在times时间后结束
-(void)startFireAndStopAfterTimes:(float)times;

//结束粒子发生器
-(void)stopFire;


@end

