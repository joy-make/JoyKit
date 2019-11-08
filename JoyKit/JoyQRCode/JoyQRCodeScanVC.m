//
//  JoyQRCodeScanVC.m
//  JoyKit
//
//  Created by Joymake on 2019/11/6.
//

#import "JoyQRCodeScanVC.h"
#import <UIImage+Extension.h>
#import "JoyQRCodeScanView.h"
#import <JoyKit/CALayer+JoyLayer.h>

@interface JoyQRCodeScanVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)JoyQRCodeScanView *scanView;
@property (nonatomic,assign)CGSize scanSize;
@property (nonatomic,assign)CGFloat cornerRadius;
@property (nonatomic,strong)UIColor *color;

@end

@implementation JoyQRCodeScanVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scanView];
    [self.scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.scanView.layer addScanLayerScanW:self.scanSize.width?:300 scanH:self.scanSize.height?:300 cornerWidth:self.cornerRadius?:20 color:self.color?:[UIColor greenColor]];
}

-(void)setScanSize:(CGSize)scanSize cornerRadius:(CGFloat)cornerRadius color:(UIColor *)color{
    self.scanSize = scanSize;
    self.cornerRadius = cornerRadius;
    self.color = color;
}

-(JoyQRCodeScanView *)scanView{
    if (!_scanView) {
        _scanView = [[JoyQRCodeScanView alloc]initWithFrame:self.view.bounds];
        __weak __typeof(&*self)weakSelf = self;
        _scanView.selectPhotoBlock = ^{
            [weakSelf selectPhoto];
        };
    }
    return _scanView;
}

- (void)startScan:(STRINGBLOCK)scanBlock backBlock:(VOIDBLOCK)goBack{
    _scanView.scanMMetaBlock = scanBlock;
    _scanView.goBackBlock = goBack;
    [_scanView.recorder.captureSession startRunning];
}

- (void)selectPhoto{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    //图库
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:picker animated:true completion:nil];
    }
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
        __weak __typeof(&*self)weakSelf = self;
        [self dismissViewControllerAnimated:false completion:^{
            __strong __typeof(&*weakSelf)strongSelf = weakSelf;
            strongSelf.scanView.scanMMetaBlock?strongSelf.scanView.scanMMetaBlock(scannedResult):nil;
        }];
    }
}
@end
