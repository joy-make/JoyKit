//
//  JoyQRCodeScan.h
//  JoyKit
//
//  Created by Joymake on 2018/9/19.
//

#import <Foundation/Foundation.h>
#import "JoyQRCodeScanView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JoyQRCodeScan : NSObject
+(instancetype)shareInstance;
@property (nonatomic,strong,readonly)JoyQRCodeScanView *scanView;

- (void)startScan:(STRINGBLOCK)scanBlock;

@end

NS_ASSUME_NONNULL_END
