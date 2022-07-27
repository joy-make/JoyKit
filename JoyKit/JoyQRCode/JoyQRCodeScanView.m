//
//  JoyQRCodeScanView.m
//  LW
//
//  Created by joymake on 2017/6/7.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyQRCodeScanView.h"
#import <CALayer+JoyLayer.h>
#import "Joy.h"
#import <CAAnimation+HCAnimation.h>
#import "JoyCoreMotion.h"
#import "UIView+JoyCategory.h"

@interface JoyQRCodeScanView ()<UIGestureRecognizerDelegate,ReCordPlayProtoCol>
/**
 *  记录开始的缩放比例
 */
@property(nonatomic,assign)CGFloat beginGestureScale;
/**
 *  最后的缩放比例
 */
@property(nonatomic,assign)CGFloat effectiveScale;
@property (nonatomic,strong)UIImageView *focusCursor;
@property (nonatomic,strong)UIButton *torchLightBtn;
@property (nonatomic,strong)UIButton *photoSelectBtn;
@property (nonatomic,strong)UIButton *cancleBtn;

@end

@implementation JoyQRCodeScanView


-(UIButton *)torchLightBtn{
    if (!_torchLightBtn) {
        _torchLightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_torchLightBtn setFrame:CGRectMake(self.bounds.size.width-30-20, 30, 30, 30)];
        [_torchLightBtn setImage:[UIImage imageNamed:@"LW_Video_FlashLight"] forState:UIControlStateNormal];
        [_torchLightBtn addTarget:self action:@selector(lightControl:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _torchLightBtn;
}

-(UIButton *)photoSelectBtn{
    if (!_photoSelectBtn) {
        _photoSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoSelectBtn setFrame:CGRectMake((self.bounds.size.width -50)/2, self.bounds.size.height-60-50, 50, 50)];
        [_photoSelectBtn setImage:[UIImage imageNamed:@"qr_photo"] forState:UIControlStateNormal];
        [_photoSelectBtn addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoSelectBtn;
}

-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setFrame:CGRectMake(self.photoSelectBtn.frame.origin.x-50-40, self.photoSelectBtn.frame.origin.y, 50, 50)];
        [_cancleBtn setImage:[UIImage imageNamed:@"qr_back"] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(leaveout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = JOY_blackColor;
        self.effectiveScale = self.beginGestureScale = 1.0f;
        [self initCapture];
        [self setUpGesture];
        [self addGenstureRecognizer];
        [self addSubview:self.torchLightBtn];
        [self addSubview:self.photoSelectBtn];
        [self addSubview:self.cancleBtn];
        [self setConstraints];
        [self setCoreMotion];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _recorder.preViewLayer.frame = self.bounds;
}

- (void)setConstraints{
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.top.mas_equalTo(40);
        make.height.width.mas_equalTo(30);
    }];
    
    [self.torchLightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.cancleBtn);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    [self.photoSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.torchLightBtn.mas_leading).mas_offset(-20);
        make.height.width.mas_equalTo(35);
        make.centerY.mas_equalTo(self.cancleBtn);
    }];
}

- (void)setCoreMotion{
    __weak __typeof(&*self)weakSelf = self;
    [[JoyCoreMotion sharedInstance] startMotionManager:YES];
    [JoyCoreMotion sharedInstance].screenOrentationBlock = ^(UIDeviceOrientation orientation,CMDeviceMotion *motion){
        [weakSelf updateVideoOrientationWithResult:(AVCaptureVideoOrientation)orientation];
    };
}

-(void)stopCoreMotion{
    [[JoyCoreMotion sharedInstance] stopDetect];
    [JoyCoreMotion sharedInstance].screenOrentationBlock = nil;
}

- (void)updateVideoOrientationWithResult:(AVCaptureVideoOrientation)videoOrientation{
    __weak __typeof(&*self)weakSelf = self;
    CGAffineTransform rotateToTransform = CGAffineTransformIdentity;
    switch (videoOrientation) {
        case AVCaptureVideoOrientationPortrait:
        {
            rotateToTransform = CGAffineTransformIdentity;
        }
            break;
        case AVCaptureVideoOrientationPortraitUpsideDown:
        {
            rotateToTransform = CGAffineTransformMakeRotation(M_PI);
        }
            break;
        case AVCaptureVideoOrientationLandscapeRight:
        {
            rotateToTransform = CGAffineTransformMakeRotation(M_PI_2);
        }
            break;
        case AVCaptureVideoOrientationLandscapeLeft:
        {
            rotateToTransform = CGAffineTransformMakeRotation(-M_PI_2);
        }
            break;
            
        default:
            break;
    }
    if (videoOrientation != AVCaptureVideoOrientationPortraitUpsideDown) {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.torchLightBtn.transform = rotateToTransform;
            weakSelf.photoSelectBtn.transform = rotateToTransform;
            weakSelf.cancleBtn.transform = rotateToTransform;
//            weakSelf.qrCodeBorderImageView.transform = rotateToTransform;
        }];
    }
}

#pragma mark 屏幕旋转
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    self.recorder.preViewLayer.frame = [UIScreen mainScreen].bounds;
}

-(UIImageView *)focusCursor{
    if (!_focusCursor) {
        _focusCursor = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        _focusCursor.image = [UIImage imageNamed:@"LW_CameraFocus"];
        [self addSubview:_focusCursor];
        _focusCursor.alpha = 0;
    }
    return _focusCursor;
}

- (void)lightControl:(UIButton *)btn{
    [self.recorder switchTorch:NO];
}

- (void)selectPhoto:(UIButton *)btn{
    self.selectPhotoBlock?self.selectPhotoBlock():nil;
}

- (void)leaveout:(UIButton *)btn{
    [self.recorder stopCurrentVideoRecording];
    [self.recorder.captureSession stopRunning];
    [self stopCoreMotion];
    self.goBackBlock?self.goBackBlock():nil;
}

-(void)initCapture{
    if (!_recorder) {
        __weak typeof(self)weakSelf = self;
        _recorder = [[JoyMediaRecordPlay alloc]initWithCaptureType:EAVCaptureMetadataOutput];
        [_recorder switchTorch:true];
        [self.layer addSublayer:self.recorder.preViewLayer];
        _recorder.delegate = self;
    }
}

-(void)joyCaptureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0){
        [self.recorder.captureSession stopRunning];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects.count?metadataObjects.firstObject:nil;
        NSString *scanStr = obj?obj.stringValue:nil;
        __weak __typeof(&*self)weakSelf = self;
        scanStr?dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.scanMMetaBlock?weakSelf.scanMMetaBlock(scanStr):nil;
            [weakSelf leaveout:nil];
        }):nil;
    }
}

/**
 * 添加手势：点按时聚焦
 *
 */
- (void)addGenstureRecognizer
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
    [self addGestureRecognizer:tapGesture];
}
- (void)tapScreen:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point= [tapGesture locationInView:self];
    NSLog(@"(%f,%f)",point.x,point.y);
//    [self setFocusCursorWithPoint:point];
    [self.recorder setFoucusWithPoint:point];
}
/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
-(void)setFocusCursorWithPoint:(CGPoint)point{
    self.focusCursor.center=point;
    [CAAnimation showRotateAnimationInView:self.focusCursor Degree:6.65*M_PI Direction:AxisZ Repeat:0 Duration:1.5 autoreverses:NO];
    [CAAnimation showScaleAnimationInView:self.focusCursor fromValue:2 ScaleValue:1 Repeat:1 Duration:1 autoreverses:YES];
    [CAAnimation showOpacityAnimationInView:self.focusCursor fromAlpha:1 Alpha:0 Repeat:1 Duration:3 autoreverses:NO];
}

#pragma 创建手势
- (void)setUpGesture{
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinch.delegate = self;
    [self addGestureRecognizer:pinch];
}

#pragma mark gestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        self.beginGestureScale = self.effectiveScale;
    }
    return YES;
}

//缩放手势 用于调整焦距
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer{
    BOOL touchAvaliad = YES;
    NSUInteger numTouches = [recognizer numberOfTouches], i;
    for ( i = 0; i < numTouches; ++i ) {
        CGPoint location = [recognizer locationOfTouch:i inView:self];
        CGPoint convertedLocation = [self.recorder.preViewLayer convertPoint:location fromLayer:self.recorder.preViewLayer.superlayer];
        if ( ! [self.recorder.preViewLayer containsPoint:convertedLocation] )
        {
            touchAvaliad = NO;
            break;
        }
    }
    
    if ( touchAvaliad ) {
        CGFloat maxScaleAndCropFactor = 10;
        if (self.beginGestureScale * recognizer.scale > 1.0 && self.beginGestureScale * recognizer.scale < maxScaleAndCropFactor)
        {
            self.effectiveScale = self.beginGestureScale * recognizer.scale;
            [self.recorder updateVideoScaleAndCropFactor:self.effectiveScale];
        }
    }
}
@end
