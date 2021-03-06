//  Created by joymake on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//


#import "JoyBaseVC.h"
#import "UIBarButtonItem+JoyBarItem.h"
#import "JoyBaseVC+Extention.h"
#import "UIImage+Extension.h"
#import <objc/runtime.h>

static const float KNavLeftSpace = 15;
static const float KNavWidth = 40;
static const float KleftNavItemSpace = -6;
static const float KrightNavItemSpace = -8;

static NSString *JoyedgesForExtendedLayout = @"JoyedgesForExtendedLayout";
static NSString *JoyNavBackImage = @"JoyNavBackImage";
static NSString *JoyBarMetrics = @"JoyBarMetrics";
static NSString *JoyShadowImage = @"JoyShadowImage";

@implementation JoyBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    [self addSubViews];
    [self setConstraints];
    NSLog(@"The current viewController is %@", self);
}

- (void)setRectEdgeAll{
    objc_setAssociatedObject(self, &JoyedgesForExtendedLayout, @(self.edgesForExtendedLayout), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &JoyNavBackImage, [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &JoyShadowImage, self.navigationController.navigationBar.shadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)recoveryEdgeNav{
    self.edgesForExtendedLayout =[objc_getAssociatedObject(self, &JoyedgesForExtendedLayout) integerValue];
    [self.navigationController.navigationBar setBackgroundImage:objc_getAssociatedObject(self, &JoyNavBackImage)
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = objc_getAssociatedObject(self, &JoyShadowImage);
}

-(void)addSubViews{}

-(void)setConstraints{}

- (void)setNavItem{
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColorFromRGB(0xF2F2F4);
    [self setLeftNaviItemWithTitle:@""];
}

#pragma mark action nacitem
- (void)setLeftNavItemWithTitle:(NSString *)leftNavItemTitle andImageStr:(NSString *)normalImageStr andHighLightImageStr:(NSString *)highLightImageStr action:(SEL)action bundle:(NSString *)bundleName

{
    NSString *defaultIcon = self.navigationController.viewControllers.count>1?@"header_icon_back":nil;
    SEL leftNavItemClickAction = action?@selector(action):@selector(leftNavItemClickAction);
    NSString *leftNormalImageStr = normalImageStr?:defaultIcon;
    NSString *leftHighLightImageStr = highLightImageStr?:defaultIcon;
    UIBarButtonItem *backNavigationItem =  [UIBarButtonItem JoyBarButtonItemWithTarget:self action:leftNavItemClickAction normalImage:leftNormalImageStr highLightImage:leftHighLightImageStr title:leftNavItemTitle titleColor:nil frame:CGRectMake(0, 0, KNavLeftSpace, KNavWidth) bundle:bundleName?:nil];
    UIBarButtonItem *negativeSpaceItem = [[UIBarButtonItem alloc]                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpaceItem.width = KleftNavItemSpace;
    self.navigationItem.leftBarButtonItems = @[negativeSpaceItem, backNavigationItem];
}

- (void)setRightNavItemWithTitle:(NSString *)rightNavItemTitle andImageStr:(NSString *)normalImageStr andHighLightImageStr:(NSString *)highLightImageStr action:(SEL)action bundle:(NSString *)bundleName{
    SEL rightNavItemClickAction = action?@selector(action):@selector(rightNavItemClickAction);
    UIBarButtonItem *rightNavigationItem = [UIBarButtonItem JoyBarButtonItemWithTarget:self action:rightNavItemClickAction normalImage:normalImageStr highLightImage:highLightImageStr title:rightNavItemTitle titleColor:nil frame:CGRectMake(0, 0, KNavWidth, KNavWidth) bundle:bundleName?:nil];
    UIBarButtonItem *negativeSpaceItem = [[UIBarButtonItem alloc]                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpaceItem.width = KrightNavItemSpace;
    [self.navigationItem setRightBarButtonItems:@[negativeSpaceItem ,rightNavigationItem]];
}

- (void)setLeftNavWithGifStr:(NSString *)gifStr{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage sd_animatedGIFNamed:gifStr] style:UIBarButtonItemStylePlain target:self action:@selector(leftNavItemClickAction)];
    [self.navigationItem setLeftBarButtonItems:@[leftItem]];
}

- (void)setRightNavWithGifStr:(NSString *)gifStr{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage sd_animatedGIFNamed:gifStr]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(rightNavItemClickAction)];

    [self.navigationItem setRightBarButtonItems:@[rightItem] animated:YES];
}


#pragma mark - 默认样式
- (void)setLeftNaviItemWithTitle:(NSString *)leftTitle
{
    NSString *defaultIcon = self.navigationController.viewControllers.count>1?@"header_icon_back":nil;

    [self setLeftNavItemWithTitle:leftTitle andImageStr:defaultIcon andHighLightImageStr:defaultIcon action:nil bundle:nil];
}

- (void)setRightNavItemWithTitle:(NSString *)rightTitle
{
    [self setRightNavItemWithTitle:rightTitle andImageStr:nil andHighLightImageStr:nil action:nil bundle:nil];
}

#pragma clang diagnostic ignored "-Wunused-variable"
#pragma mark defaultConstraint
- (void)setDefaultConstraintWithView:(UIView *)view andTitle:(NSString *)title{
    [self.view addSubview:view];
    if (title)
    self.title = title;
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(view, make.edges.equalTo(weakSelf.view);
                   );
    [self.view setNeedsUpdateConstraints];
}

#pragma mark navitemClickAction
- (void)leftNavItemClickAction{
    HIDE_KEYBOARD;
    [self goBack];
}

- (void)rightNavItemClickAction{
    HIDE_KEYBOARD;
}

#pragma MARk goVC
- (void)goVC:(JoyBaseVC *)vc{
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark gobackAction
- (void)popToVCWithVCName:(NSString *)vcName{
    __block Class popVCClass = NSClassFromString(vcName);
    __weak __typeof (&*self)weakSelf = self;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^( UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:popVCClass])
        {
        [weakSelf.navigationController popToViewController:obj animated:YES];
        *stop = YES;
        }else if (idx == weakSelf.navigationController.viewControllers.count-1){
            [weakSelf goBack];
        }
    }];
}

- (void)goBack{
    HIDE_KEYBOARD;
    self.presentingViewController?[self dismissViewControllerAnimated:YES completion:NULL]:
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    NSLog(@"The dealloc viewController is %@", [self class]);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
