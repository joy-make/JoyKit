//
//  UIWindow+Observer.h
//  JoyKit
//
//  Created by Joymake on 2018/5/14.
//

#import <UIKit/UIKit.h>
#define KMOTIONEND_NOTI          @"KmotionEnd"

#define KSCREEN_DISPLAY_NOTI     @"KSCREEN_DISPLAY"

@interface UIWindow (Observer)
- (void)startSCreenLightObserver:(BOOL)screenObserverSwithch;

@end
