//
//  JoyQRCodeScan.m
//  JoyKit
//
//  Created by Joymake on 2018/9/19.
//

#import "JoyQRCodeScan.h"
#import <UIImage+Extension.h>

@interface JoyQRCodeScan ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)JoyQRCodeScanView *scanView;
@end

@implementation JoyQRCodeScan

+(instancetype)shareInstance{
    static JoyQRCodeScan *scanner = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scanner = [[super alloc]init];
    });
    return scanner;
}

- (void)startScan:(STRINGBLOCK)scanBlock{
    [self.scanView removeFromSuperview];
    self.scanView = [[JoyQRCodeScanView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:self.scanView];
//    MAS_CONSTRAINT(self.scanView, make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow););
//    [[UIApplication sharedApplication].keyWindow updateConstraintsIfNeeded];
    
    _scanView.scanMMetaBlock = scanBlock;
    [_scanView.recorder.captureSession startRunning];
    __weak __typeof(&*self)weakSelf = self;
    _scanView.selectPhotoBlock = ^{
        [weakSelf selectPhoto];
    };
}

- (void)selectPhoto{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    //图库
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
    }
    [_scanView removeFromSuperview];
    
}

#pragma clang diagnostic ignored  "-Wunguarded-availability"
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
    UIImage *pickImage = info[UIImagePickerControllerEditedImage];
    if (!pickImage) {
        pickImage = info[UIImagePickerControllerOriginalImage];
    }
    //初始化  将类型设置为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    //设置数组，放置识别完之后的数据
    NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(pickImage)]];
    //判断是否有数据（即是否是二维码）
    if (features.count >= 1) {
        //取第一个元素就是二维码所存放的文本信息
        CIQRCodeFeature *feature = features[0];
        NSString *scannedResult = feature.messageString;
        _scanView.scanMMetaBlock?_scanView.scanMMetaBlock(scannedResult):nil;
    }
}

@end
