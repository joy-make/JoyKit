//
//  UIWindow+Observer.m
//  JoyKit
//
//  Created by Joymake on 2018/5/14.
//

#import "UIWindow+Observer.h"

@implementation UIWindow (Observer)
- (BOOL)canBecomeFirstResponder {//默认是NO，所以得重写此方法，设成YES
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionBegan");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter]postNotificationName:KMOTIONEND_NOTI object:nil];
    NSLog(@"摇一摇结束");
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionCancelled");
}

-(void)startSCreenLightObserver:(BOOL)screenObserverSwithch{
    NSMutableString *notificationOnStr = [NSMutableString stringWithString:@"cozxlm.apzxlple.szxlpringzxlboard.hasBzxllankedSzxlcreen"];
    [notificationOnStr replaceOccurrencesOfString:@"zxl" withString:@"" options:(0) range:NSMakeRange(0, notificationOnStr.length)];
    CFStringRef notificationOnStrRef = (__bridge CFStringRef)notificationOnStr;
    
    NSMutableString *NotificationScreenDisplayStr = [NSMutableString stringWithString:@"cozxlm.apzxlple.iokizxlt.hzxlid.diszxlplayStazxltus"];
    [NotificationScreenDisplayStr replaceOccurrencesOfString:@"zxl" withString:@"" options:(0) range:NSMakeRange(0, NotificationScreenDisplayStr.length)];
    CFStringRef NotificationScreenDisplayStrRef = (__bridge CFStringRef)NotificationScreenDisplayStr;
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, displayStatusChanged, notificationOnStrRef, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, displayStatusChanged, NotificationScreenDisplayStrRef, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

#pragma mark--- 解锁 亮屏通知捕获方法
//static NSString *unlockState = @"";
static void displayStatusChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    NSMutableString *notificationOnStr = [NSMutableString stringWithString:@"cozxlm.apzxlple.szxlpringzxlboard.hasBzxllankedSzxlcreen"];
    [notificationOnStr replaceOccurrencesOfString:@"zxl" withString:@"" options:(0) range:NSMakeRange(0, notificationOnStr.length)];
    NSMutableString *NotificationScreenDisplayStr = [NSMutableString stringWithString:@"czxlozxlm.apzxlple.iokizxlt.hzxlid.diszxlplayStazxltus"];
    [NotificationScreenDisplayStr replaceOccurrencesOfString:@"zxl" withString:@"" options:(0) range:NSMakeRange(0, NotificationScreenDisplayStr.length)];
    NSLog(@"********屏幕状态改变**********");
    NSString* screenState = (__bridge NSString*)name;
    static NSString *unlockState = @"";
    if ([screenState isEqualToString:notificationOnStr]&&[unlockState isEqualToString:NotificationScreenDisplayStr]) {
        NSLog(@"********点亮屏幕**********");
        [[NSNotificationCenter defaultCenter]postNotificationName:KSCREEN_DISPLAY_NOTI object:nil];
    }
    unlockState = screenState;
}

@end
