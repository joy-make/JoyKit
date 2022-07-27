//
//  UIDevice+JoyCategory.m
//  JoyKit
//
//  Created by joy on 2022/7/21.
//

#import "UIDevice+JoyCategory.h"

static  NSString  *const KOrientationKey = @"orientation";

@implementation UIDevice (JoyCategory)

+ (void)changeDeviceOrientation:(UIInterfaceOrientation)interfaceOrientation {

    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];

    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:KOrientationKey];

    // 将输入的转屏方向（枚举）转换成Int类型
    int orientation = (int)interfaceOrientation;

    // 对象包装
    NSNumber *orientationTarget = [NSNumber numberWithInt:orientation];

    // 实现横竖屏旋转
    [[UIDevice currentDevice] setValue:orientationTarget forKey:KOrientationKey];
}

@end
