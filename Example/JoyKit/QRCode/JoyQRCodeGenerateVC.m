//
//  JoyQRCodeGenerateVC.m
//  JoyKit_Example
//
//  Created by joy on 2022/7/28.
//  Copyright © 2022 joy-make. All rights reserved.
//

#import "JoyQRCodeGenerateVC.h"
#import "UIImage+Extension.h"
#import "NSString+JoyCategory.h"
#import "JoyAlert.h""

@interface JoyQRCodeGenerateVC ()
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIImageView *barCodeImageView;
@property (nonatomic,strong)UIImageView *qrCodeImageView;

@end

@implementation JoyQRCodeGenerateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    self.title = @"字符串生成条形码和二维码";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"生成" style:UIBarButtonItemStylePlain target:self action:@selector(generateAction)];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(80, 200, 200, 50)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"请输入...";
    self.textField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.textField];
    
    self.barCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 280, 200, 70)];
    [self.view addSubview:self.barCodeImageView];

    self.qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 380, 100, 100)];
    self.qrCodeImageView.userInteractionEnabled = true;
    [self.view addSubview:self.qrCodeImageView];
    
    UILabel *topicLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 500, 140, 40)];
    [self.view addSubview:topicLabel];
    topicLabel.text = @"长按二维码保存";
    topicLabel.textColor = UIColor.blackColor;
    topicLabel.textAlignment = NSTextAlignmentCenter;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [self.qrCodeImageView addGestureRecognizer:longPress];

}

-(void)generateAction{
    [self.textField resignFirstResponder];
    if(self.textField.text.length){
        self.barCodeImageView.image = [self.textField.text barCodeImage];
        self.qrCodeImageView.image = [self.textField.text logoQrCode];
    }
}
-(void)longPressAction:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self.qrCodeImageView.image saveToPhotos:^{
            [JoyAlert showWithMessage:@"已保存"];
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField resignFirstResponder];
}



@end
