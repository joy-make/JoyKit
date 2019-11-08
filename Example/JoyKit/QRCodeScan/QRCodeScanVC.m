//
//  QRCodeScanVC.m
//  JoyKit_Example
//
//  Created by Joymake on 2019/11/4.
//  Copyright © 2019 joy-make. All rights reserved.
//

#import "QRCodeScanVC.h"
#import <JoyKit/JoyQRCodeScanVC.h>
#import <JoyKit/CALayer+JoyLayer.h>
#import <JoyKit/JoyAlert.h>

@interface QRCodeScanVC ()

@end

@implementation QRCodeScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"点击空白开始扫码";
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    JoyQRCodeScanVC *vc = [[JoyQRCodeScanVC alloc]init];
    [vc setScanSize:CGSizeMake(300, 300) cornerRadius:20 color:[UIColor greenColor]];
    [self presentViewController:vc animated:true completion:nil];
    __weak __typeof(&*self)weakSelf = self;
    [vc startScan:^(NSString *str) {
        [[JoyAlert shareAlert]showalertWithMessage:str alertBlock:nil];;
    } backBlock:^{
        [weakSelf dismissViewControllerAnimated:true completion:nil];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

//
//    [[JoyQRCodeScan shareInstance] startScan:^(NSString *str) {
//
//    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
