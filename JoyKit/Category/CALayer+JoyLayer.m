//
//  CALayer+JoyLayer.m
//  Pods
//
//  Created by joymake on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.//
//

#import "CALayer+JoyLayer.h"

@implementation CALayer (JoyLayer)
- (CATextLayer*)textLayer:(NSString*)text rotate:(CGFloat)angel frame:(CGRect)frame position:(CGPoint)position font:(NSInteger)fontSize
{
    CATextLayer *txtLayer = [CATextLayer layer];
    
    txtLayer.frame = frame;
    
    //设置锚点，绕中心点旋转
    txtLayer.anchorPoint = CGPointMake(0.5, 0.5);
    txtLayer.string = text;
    txtLayer.alignmentMode = [NSString stringWithFormat:@"right"];
    txtLayer.fontSize = fontSize;
    txtLayer.foregroundColor = [UIColor grayColor].CGColor;
    txtLayer.contentsScale = [UIScreen mainScreen].scale;//解决文字模糊 以Retina方式来渲染，防止画出来的文本像素化

    txtLayer.shadowColor = [UIColor yellowColor].CGColor;
    txtLayer.shadowOffset = CGSizeMake(5, 2);
    txtLayer.shadowRadius = 6;
    txtLayer.shadowOpacity = 0.6;
    
    //layer没有center，用Position
    [txtLayer setPosition:position];
    //旋转
    txtLayer.transform = CATransform3DMakeRotation(angel,0,0,1);
    return txtLayer;
}

@end


@implementation CALayer (Transition)


/**
 *  转场动画
 *
 *  @param animType 转场动画类型
 *  @param subtype  转动动画方向
 *  @param curve    转动动画曲线
 *  @param duration 转动动画时长
 *
 *  @return 转场动画实例
 */
-(CATransition *)transitionWithAnimType:(TransitionAnimType)animType subType:(TransitionSubType)subType curve:(TransitionCurve)curve duration:(CGFloat)duration{
    
    NSString *key = @"transition";
    
    if([self animationForKey:key]!=nil){
        [self removeAnimationForKey:key];
    }
    
    
    CATransition *transition=[CATransition animation];
    
    //动画时长
    transition.duration=duration;
    
    //动画类型
    transition.type=[self animaTypeWithTransitionType:animType];
    
    //动画方向
    transition.subtype=[self animaSubtype:subType];
    
    //缓动函数
    transition.timingFunction=[CAMediaTimingFunction functionWithName:[self curve:curve]];
    
    //完成动画删除
    transition.removedOnCompletion = YES;
    
    [self addAnimation:transition forKey:key];
    
    return transition;
}



/*
 *  返回动画曲线
 */
-(NSString *)curve:(TransitionCurve)curve{
    
    //曲线数组
    NSArray *funcNames=@[kCAMediaTimingFunctionDefault,kCAMediaTimingFunctionEaseIn,kCAMediaTimingFunctionEaseInEaseOut,kCAMediaTimingFunctionEaseOut,kCAMediaTimingFunctionLinear];
    
    return [self objFromArray:funcNames index:curve isRamdom:(TransitionCurveRamdom == curve)];
}



/*
 *  返回动画方向
 */
-(NSString *)animaSubtype:(TransitionSubType)subType{
    
    //设置转场动画的方向
    NSArray *subtypes=@[kCATransitionFromTop,kCATransitionFromLeft,kCATransitionFromBottom,kCATransitionFromRight];
    
    return [self objFromArray:subtypes index:subType isRamdom:(TransitionSubtypesFromRamdom == subType)];
}

/*
 *  返回动画类型
 */
-(NSString *)animaTypeWithTransitionType:(TransitionAnimType)type{
    
    //设置转场动画的类型
    NSArray *animArray=@[@"rippleEffect",@"suckEffect",@"pageCurl",@"oglFlip",@"cube",@"reveal",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose",@"fade"];
    
    return [self objFromArray:animArray index:type isRamdom:(TransitionAnimTypeRamdom == type)];
}



/*
 *  统一从数据返回对象
 */
-(id)objFromArray:(NSArray *)array index:(NSUInteger)index isRamdom:(BOOL)isRamdom{
    
    NSUInteger count = array.count;
    
    NSUInteger i = isRamdom?arc4random_uniform((u_int32_t)count) : index;
    
    return array[i];
}
@end

@implementation CALayer (ScanCode)

- (void)addScanLayerScanW:(CGFloat)scanW scanH:(CGFloat)scanH cornerWidth:(CGFloat)cornerW{
    [self addScanLayerScanW:scanW scanH:scanH cornerWidth:cornerW color:[UIColor greenColor]];
}


- (void)addScanLayerScanW:(CGFloat)scanW scanH:(CGFloat)scanH cornerWidth:(CGFloat)cornerW color:(UIColor *)scanColor{
    
    float scanWidth = scanW?:200;
    float scanHeight = scanH?:200;
    float cornerWidth = cornerW?:30;
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat spaceLeading = (width - scanWidth)/2;
    CGFloat spaceTop = (height - scanHeight)/2;
    
    UIBezierPath *grayPath = [[UIBezierPath alloc]init];
    [grayPath moveToPoint:CGPointMake(spaceLeading, spaceTop)];
    [grayPath addLineToPoint:CGPointMake(width-spaceLeading, spaceTop)];
    [grayPath addLineToPoint:CGPointMake(width-spaceLeading, height-spaceTop)];
    [grayPath addLineToPoint:CGPointMake(spaceLeading, height-spaceTop)];
    
    [grayPath moveToPoint:CGPointMake(0, 0)];
    [grayPath addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [grayPath addLineToPoint:CGPointMake(self.bounds.size.width,self.bounds.size.height)];
    [grayPath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [grayPath closePath];
    
    CAShapeLayer *grayLayer = [CAShapeLayer layer];
    grayLayer.path = grayPath.CGPath;
//    grayLayer.strokeColor = [UIColor whiteColor].CGColor;
    grayLayer.fillColor = [[UIColor colorWithWhite:0.3 alpha:0.8] CGColor];
    grayLayer.fillRule = kCAFillRuleEvenOdd;
    [self addSublayer:grayLayer];
    
    //四个角
    UIBezierPath *topCornerPath = [[UIBezierPath alloc]init];
    [topCornerPath moveToPoint:CGPointMake(spaceLeading, spaceTop+cornerWidth)];
    [topCornerPath addLineToPoint:CGPointMake(spaceLeading, spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(spaceLeading+cornerWidth, spaceTop)];
    
    [topCornerPath moveToPoint:CGPointMake(width-cornerWidth-spaceLeading, spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(width-spaceLeading, spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(width-spaceLeading, spaceTop+cornerWidth)];
    
    [topCornerPath moveToPoint:CGPointMake(width-spaceLeading, height-spaceTop-cornerWidth)];
    [topCornerPath addLineToPoint:CGPointMake(width-spaceLeading, height-spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(width-spaceLeading-cornerWidth, height-spaceTop)];
    
    [topCornerPath moveToPoint:CGPointMake(cornerWidth+spaceLeading, height-spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(spaceLeading, height-spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(spaceLeading, height-spaceTop-cornerWidth)];
    topCornerPath.lineWidth = 5;
    topCornerPath.lineJoinStyle = kCGLineJoinMiter;
    topCornerPath.lineCapStyle = kCGLineCapRound;
    
    CAShapeLayer *topCornerLayer = [CAShapeLayer layer];
    topCornerLayer.path = topCornerPath.CGPath;
    topCornerLayer.strokeColor = [scanColor CGColor];
    topCornerLayer.fillColor = [[UIColor clearColor] CGColor];
    [self addSublayer:topCornerLayer];
    
    //动画layer
    UIBezierPath *animationPath = [[UIBezierPath alloc]init];
    [animationPath moveToPoint:CGPointMake(spaceLeading+cornerWidth, spaceTop)];
    [animationPath addLineToPoint:CGPointMake(width - spaceLeading-cornerWidth, spaceTop)];
    animationPath.lineWidth = 50;
    CAShapeLayer *animationLayer = [CAShapeLayer layer];
    animationLayer.path = animationPath.CGPath;
    animationLayer.strokeColor = [scanColor CGColor];
    animationLayer.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:animationLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, scanHeight)];
    moveAnimation.autoreverses = YES;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 1.5;
    [animationLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    [self addSublayer:animationLayer];
}

@end

