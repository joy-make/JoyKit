//
//  UIDevice+JoyCategory.h
//  JoyKit
//
//  Created by joy on 2022/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (JoyCategory)

//旋转设备布局方向 supportedInterfaceOrientations函数要支持对应的设备方向
+ (void)changeDeviceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end

NS_ASSUME_NONNULL_END
