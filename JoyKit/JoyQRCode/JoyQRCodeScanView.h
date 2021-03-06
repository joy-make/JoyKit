//
//  JoyQRCodeScanView.h
//  LW
//
//  Created by joymake on 2017/6/7.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoyMediaRecordPlay.h"

@interface JoyQRCodeScanView : UIView
@property (nonatomic,copy) STRINGBLOCK scanMMetaBlock;
@property (nonatomic,copy)VOIDBLOCK selectPhotoBlock;
@property (nonatomic,copy)VOIDBLOCK goBackBlock;
@property (nonatomic,strong)JoyMediaRecordPlay *recorder;

@end
