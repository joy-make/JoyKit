//
//  JoyQRCodeScanVC.h
//  JoyKit
//
//  Created by Joymake on 2019/11/6.
//

#import <UIKit/UIKit.h>
#import "JoyQRCodeScanView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JoyQRCodeScanVC : UIViewController
@property (nonatomic,strong,readonly)JoyQRCodeScanView *scanView;

- (void)startScan:(STRINGBLOCK)scanBlock backBlock:(VOIDBLOCK)goBack;

- (void)setScanSize:(CGSize)scanSize cornerRadius:(CGFloat)cornerRadius color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
