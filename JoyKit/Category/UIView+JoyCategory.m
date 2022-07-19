//
//  UIView+JoyCategory.m
//  Toon
//
//  Created by joymake on 2017/2/27.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import "UIView+JoyCategory.h"
static   UIInterfaceOrientation AppInterfaceOrientation() {
    return [UIApplication sharedApplication].statusBarOrientation;
}

@implementation UIView (JoyCategory)
- (UIViewController*)viewController {
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}
- (CGFloat)left {
    return self.frame.origin.x;
}


- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)top {
    return self.frame.origin.y;
}


- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)centerX {
    return self.center.x;
}


- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)centerY {
    return self.center.y;
}


- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height {
    return self.frame.size.height;
}


- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}


- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


- (CGPoint)origin {
    return self.frame.origin;
}


- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)size {
    return self.frame.size;
}


- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (CGFloat)orientationWidth {
    return UIInterfaceOrientationIsLandscape(AppInterfaceOrientation())
    ? self.height : self.width;
}


- (CGFloat)orientationHeight {
    return UIInterfaceOrientationIsLandscape(AppInterfaceOrientation())
    ? self.width : self.height;
}


- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}


- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}


- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}

-(NSArray*)allSubviews

{
    NSMutableArray *arr = [NSMutableArray array];
    
    [arr addObject:self];
    
    for (UIView * subview in self.subviews)
        
    {
        [arr addObjectsFromArray:[subview allSubviews]];
    }
    return arr;
}

-(UIImage *)snapshotSingleView{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage*)imageFromRect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
//    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 1);

    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    rect.size.width*=[UIScreen mainScreen].scale;
    rect.size.height*=[UIScreen mainScreen].scale;
    CGRect myImageRect = rect;
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef,myImageRect );
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}

- (void)cutImageFromRect:(CGRect)frame successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block{
    
    //先把裁剪区域上面显示的层隐藏掉
    for (UIView * wipe in self.subviews) {
        [wipe setHidden:YES];
    }
    
    // ************************   进行第一次裁剪 ********************
    
    //1.开启上下文
    //    UIGraphicsBeginImageContext(view.frame.size);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    
    //2、获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3、添加裁剪区域
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:frame];
    [path addClip];
    //4、渲染
    [self.layer renderInContext:ctx];
    //5、从上下文中获取
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7、关闭上下文
    UIGraphicsEndImageContext();
    
    //8、进行完第一次裁剪之后，我们就已经拿到了没有半透明层的图片，这个时候可以恢复显示
    for (UIView * wipe in self.subviews) {
        [wipe setHidden:NO];
    }
    
    // ************************   进行第二次裁剪 ********************
    //9、开启上下文，这个时候的大小就是我们最终要显示图片的大小
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    
    //10、这里把x y 坐标向左、上移动
    [newImage drawAtPoint:CGPointMake(- frame.origin.x, - frame.origin.y)];
    
    //11、得到要显示区域的图片
    UIImage * fImage = UIGraphicsGetImageFromCurrentImageContext();
    //12、得到data类型 便于保存
    NSData * data2 = UIImageJPEGRepresentation(fImage, 1);
    //13、关闭上下文
    UIGraphicsEndImageContext();
    //14、回调
    block(fImage,data2);
}
@end

static NSInteger emitterBirthRate = 20;
static float emitterDelaytimes = 0.7;

static char KEmitterKey;
@implementation UIView (JoyEmillterLayer)

-(void)configEmitterLayer:(UIImage *)effectImage{
    [self configEmitterLayerWithImage:effectImage birthRate:20 velocity:-200 emitterSize:self.bounds.size];
}

-(void)configEmitterLayerWithImage:(UIImage *)effectImage birthRate:(NSInteger)birthRate velocity:(CGFloat)velocity emitterSize:(CGSize)emitterSize{
    emitterBirthRate = birthRate?:emitterBirthRate;
    CAEmitterLayer *emittLayer = [self getEmitterLayerWithEffectImage:effectImage?:[UIImage imageNamed:@"JoyLike"] birthRate:emitterBirthRate velocity:velocity emitterSize:emitterSize];
    objc_setAssociatedObject(self, &KEmitterKey, emittLayer, OBJC_ASSOCIATION_RETAIN);
    [self.layer addSublayer:emittLayer];
    if ([self isKindOfClass:UIControl.class]) {
        [(UIControl *)self addTarget:self action:@selector(emitterAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)startFireAndStopAfterTimes:(float)times{
    emitterDelaytimes = times?:0;
    self.emitterLayer.birthRate = emitterBirthRate;
    if(emitterDelaytimes){
        [self performSelector:@selector(stopEmitterLayer) withObject:nil afterDelay:times];
    }
}

-(void)stopFire{
    self.emitterLayer.birthRate = 0;
}

-(void)emitterAction:(UIControl *)btn{
    self.emitterLayer.birthRate = emitterBirthRate;
    [self performSelector:@selector(stopEmitterLayer) withObject:nil afterDelay:emitterDelaytimes];
}

-(void)stopEmitterLayer{
    self.emitterLayer.birthRate = 0;
}

-(CAEmitterLayer *)emitterLayer{
    return objc_getAssociatedObject(self, &KEmitterKey);
}

- (CAEmitterLayer *)getEmitterLayerWithEffectImage:(UIImage *)effectImage birthRate:(NSInteger)birthRate velocity:(CGFloat)velocity emitterSize:(CGSize)emitterSize{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    //定义粒子细胞是如何被呈现到layer中的
    emitterLayer.renderMode = kCAEmitterLayerBackToFront;
    emitterLayer.emitterPosition = CGPointMake(emitterSize.width/2, emitterSize.height/2);
    //发射源的形状
    //kCAEmitterLayerRectangle  发射源矩形区域
    //kCAEmitterLayerLine       发射源一条线
    //kCAEmitterLayerPoint      发射源一个点
    emitterLayer.emitterShape = kCAEmitterLayerPoint;
    
//    // 粒子发射器 发射的模式 emitterMode的作用是进一步决定发射的区域是在发射形状的哪一部份
//    kCAEmitterLayerPoints;  // 顶点
//    kCAEmitterLayerOutline;     // 轮廓，即边上
//    kCAEmitterLayerSurface;   // 表面，即图形的面积内
//    kCAEmitterLayerVolume;    // 容积，即3D图形的体积内
    emitterLayer.emitterMode  =  kCAEmitterLayerPoints;
    //发射源的尺寸大小
    emitterLayer.emitterSize = emitterSize;
    //    emitterLayer.emitterDepth = 0.5;
    //粒子数量
    emitterLayer.birthRate = 0;
    
//    emitterLayer.shadowOpacity = 10.0;
//    emitterLayer.shadowRadius  = 0.0;
//    emitterLayer.shadowOffset  = CGSizeMake(0.0, 0.0);
//    //粒子边缘的颜色
//    emitterLayer.shadowColor = [UIColor orangeColor].CGColor;
    CAEmitterCell *cell = [self emitterCellImage:effectImage birthRate:birthRate velocity:velocity velocityRange:emitterSize.height];
    emitterLayer.emitterCells = @[cell];
    return emitterLayer;
}

-(CAEmitterCell *)emitterCellImage:(UIImage *)effectImage birthRate:(CGFloat)birthRate velocity:(CGFloat)velocity velocityRange:(CGFloat)velocityRange{
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)effectImage.CGImage;
    //每秒创建的粒子个数
    cell.birthRate = 1;
    //每个粒子的存在时间
    cell.lifetime = 2;
    // 粒子透明度改变范围
    cell.alphaRange = 0.10;
    //粒子透明度变化到0的速度，单位为秒
    cell.alphaSpeed = -0.4;
    //粒子的扩散速度
    cell.velocity = velocity;
    //粒子向外扩散区域大小
    cell.velocityRange = 4;
    //粒子y方向的加速度分量
    cell.yAcceleration = -200;
    cell.emissionRange = 2*M_PI;
    cell.emissionLongitude = M_PI_2;//x-y平面的发射方向
    //粒子的扩散角度，设置成2*M_PI则会从360°向外扩散
    cell.emissionRange = M_PI_4;    //周围发射角度
    cell.spinRange = 0.15*M_PI;     //粒子旋转弧度
    //粒子起始缩放比例
    cell.scale = 0.2;
    cell.scaleRange = 0.2f;
    //粒子缩放从0~0.5的速度
    cell.scaleSpeed = 0.01;
    
    cell.color = [[UIColor colorWithRed:1 green:1 blue:1 alpha:1]CGColor];
    cell.redRange = 1;   //可变范围 cell.redRange*cell.color.Red
    cell.greenRange = 1;
    cell.blueRange = 1;
    cell.alphaRange = 0.8;
    
    return cell;
}
@end
