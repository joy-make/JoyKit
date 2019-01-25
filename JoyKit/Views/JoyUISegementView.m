//
//  JoyUISegementView.m
//  CustomSegMent
//
//  Created by joymake on 16/7/7.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyUISegementView.h"
#import "Joy.h"

@interface JoyUISegementView (){
    UISegmentedControl *_segment;
    UIView *_bottomView;
    UIView *_separateLineSuperview;
    UIView *_bottomSeparateLineSuperview;
    NSDate *_oldDate;
}
@property (nonatomic,strong)NSArray *segmentItems;
@property (nonatomic,strong)UIColor *separateColor;
@property (nonatomic,strong)UIColor *selectColor;
@property (nonatomic,strong)UIColor *deselectColor;
@property (nonatomic,strong)UIColor *bottomSliderColor;
@property (nonatomic,assign)BOOL isTouchUpInAction;

@end

@implementation JoyUISegementView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

-(JoyUISegementView *(^)(NSArray *))setSegmentItems{
    __weak __typeof(&*self)weakSelf = self;
    return ^(NSArray *items){
        weakSelf.segmentItems = items;
        [self updateSegment];
        return weakSelf;
    };
}

-(JoyUISegementView *(^)(UIColor *))setSelectColor{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIColor *color){
        weakSelf.selectColor = color;
        [self updateSegment];
        return weakSelf;
    };
}

-(JoyUISegementView *(^)(UIColor *))setDeselectColor{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIColor *color){
        weakSelf.deselectColor = color;
        [self updateSegment];
        return weakSelf;
    };
}

-(JoyUISegementView *(^)(UIColor *))setSeparateColor{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIColor *color){
        weakSelf.separateColor = color;
        [self updateSegment];
        return weakSelf;
    };
}

-(JoyUISegementView *(^)(UIColor *))setBottomSliderColor{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIColor *color){
        weakSelf.bottomSliderColor = color;
        [self updateSegment];
        return weakSelf;
    };
}

-(JoyUISegementView *(^)(NSInteger))setDefaultSelectIndex{
    __weak __typeof(&*self)weakSelf = self;
    return ^(NSInteger selectIndex){
        weakSelf.selectIndex = selectIndex;
        [self updateSegment];
        return weakSelf;
    };
}

-(JoyUISegementView *(^)(BOOL))setTouchUpInAction{
    __weak __typeof(&*self)weakSelf = self;
    return ^(BOOL select){
        weakSelf.isTouchUpInAction = select;
        return weakSelf;
    };
}

-(JoyUISegementView *(^)(SegmentChangedBlock))segmentValuechangedBlock{
    __weak __typeof(&*self)weakSelf = self;
    return ^(SegmentChangedBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

- (void)updateSegment{
    _oldDate = [NSDate date];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIFont *font = [UIFont boldSystemFontOfSize:15];
    _segment = [[UISegmentedControl alloc]initWithItems:_segmentItems];
    _segment.backgroundColor = [UIColor clearColor];
    _segment.tintColor = [UIColor clearColor];
//    [_segment setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2663C7)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [_segment setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    _segment.layer.masksToBounds = YES;
    _segment.layer.borderWidth = 2;
    _segment.layer.borderColor = [UIColor clearColor].CGColor;
    [self addSubview:_segment];
    [_segment addTarget:self action:@selector(segmentTap:) forControlEvents:UIControlEventValueChanged];
    
    //选中时
    NSDictionary *selectSegmentDic = [NSDictionary dictionaryWithObjectsAndKeys:self.selectColor?:[UIColor blackColor],NSForegroundColorAttributeName, font,NSFontAttributeName,nil];
    [ _segment setTitleTextAttributes:selectSegmentDic forState:UIControlStateSelected];

    //未选中时
    NSDictionary *deselectSegmentDic = [NSDictionary dictionaryWithObjectsAndKeys:self.deselectColor?:[UIColor lightGrayColor],NSForegroundColorAttributeName, font,NSFontAttributeName,nil];
    [_segment setTitleTextAttributes:deselectSegmentDic forState:UIControlStateNormal];

    CGFloat segmentTotalW = 0;
    for (int i = 0; i<_segment.numberOfSegments; i++) {
//        NSString *segmentStr = _segmentItems[i];
        //计算字体占用宽度
//        CGFloat segmentW =[segmentStr boundingRectWithSize:CGSizeMake(MAXFLOAT,CGRectGetHeight(_segment.frame))
//                                                   options:NSStringDrawingUsesLineFragmentOrigin
//                                                attributes:selectSegmentDic
//                                                   context:nil].size.width +10;

//        [_segment setWidth:segmentW forSegmentAtIndex:i];
//        segmentTotalW += segmentW;
        [_segment setWidth:self.width/_segmentItems.count forSegmentAtIndex:i];
        segmentTotalW += self.width/_segmentItems.count;
    }
    [_segment setFrame:CGRectMake(0, 0, segmentTotalW, CGRectGetHeight(self.frame))];
    _segment.center = self.center;
    
    _separateLineSuperview = [[UIView alloc]initWithFrame:_segment.frame];
    //屏蔽tap，让responsder穿透到segment层
    _separateLineSuperview.userInteractionEnabled = NO;
    [self addSubview:_separateLineSuperview];
    CGFloat separateLinePositionX = 0.0f;
    CGFloat separateLinePositionH = CGRectGetHeight(_segment.frame);
    
    for (int i = 0; i<_segment.numberOfSegments-1; i++) {
        separateLinePositionX+=[_segment widthForSegmentAtIndex:i];
        UIView *separateView = [[UIView alloc]initWithFrame:CGRectMake(separateLinePositionX+1,0, 1, separateLinePositionH)];
        separateView.backgroundColor = self.separateColor?:[UIColor clearColor];
        [_separateLineSuperview addSubview:separateView];
    }
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetHeight(_separateLineSuperview.frame)-2, self.width/_segmentItems.count-40, 2)];

    if(self.selectIndex !=-1 &&self.segmentItems.count>self.selectIndex){
        [_segment setSelectedSegmentIndex:self.selectIndex];
        [self updateBottomViewFrame];
    }

    [_separateLineSuperview addSubview:_bottomView];
    _bottomSeparateLineSuperview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_separateLineSuperview.frame), self.width, 0.5)];
    _bottomSeparateLineSuperview.backgroundColor = UIColorFromRGB(0xDDDEE3);
    [_separateLineSuperview addSubview:_bottomSeparateLineSuperview];
}

- (void)segmentTap:(UISegmentedControl *)segment{
    NSTimeInterval timerInterval = [[NSDate date]timeIntervalSinceDate:_oldDate];
    _oldDate = [NSDate date];
    if(timerInterval>0.3){
        self.selectIndex = segment.selectedSegmentIndex;
        SegmentChangedBlock segmentValuechangedBlock = objc_getAssociatedObject(self, @selector(segmentValuechangedBlock));
        segmentValuechangedBlock?segmentValuechangedBlock(segment.selectedSegmentIndex):nil;
        [self updateBottomViewFrame];
    }
}

- (void)updateBottomViewFrame{
    _bottomView.backgroundColor = self.bottomSliderColor;
    CGRect newRect = CGRectMake(20+self.width/_segmentItems.count * _segment.selectedSegmentIndex, CGRectGetHeight(_separateLineSuperview.frame)-2, self.width/_segmentItems.count-40, 2);
    __weak __typeof (&*_bottomView)weakBottomView = _bottomView;
    [UIView animateWithDuration:0.3 animations:^{
        [weakBottomView setFrame:newRect];
    }];
}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGPoint tempPoint = [_segment convertPoint:point fromView:self];
    //判断点击的点是否在按钮区域内
    if (CGRectContainsPoint(_segment.bounds, tempPoint) && self.isTouchUpInAction){
        //返回按钮
        NSInteger selectIndex = point.x/(_segment.width/_segment.numberOfSegments);
        _segment.selectedSegmentIndex = selectIndex;
        [self segmentTap:_segment];
        return _segment;
    }
    else{
        return  [super hitTest:point withEvent:event];
    }
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == nil){
//        //转换坐标
//        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
//        //判断点击的点是否在按钮区域内
//        if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
//            //返回按钮
//            return _centerBtn;
//        }
//    }
//    return view;
}
@end
