//
//  Joy.h
//  Toon
//
//  Created by joymake on 2017/2/28.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#ifndef Joy_h
#define Joy_h
#import <UIKit/UIKit.h>
#pragma clang diagnostic ignored "-Wunused-variable"
#pragma clang diagnostic ignored "-Wnonportable-include-path"

//提示语相关结束-------------------------------------------------

//数据处理----------------------------------------------------
#define Joy_RandomData(list) [list isKindOfClass:[NSArray class]]?((NSArray *)list)[arc4random()%([(NSArray *)list count])]:nil
//数据处理结束-------------------------------------------------

//MASONRY约束-------------------------------------------------
#import <Masonry/Masonry.h>
#define MAS_CONSTRAINT(view,block)[view mas_makeConstraints:^(MASConstraintMaker *make) {block}]
//MASONRY约束结束-------------------------------------------------

#ifndef HIDE_KEYBOARD
#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];[[[UIApplication sharedApplication] keyWindow] endEditing:YES];
#endif

//获取bundle----------------------------------------------
#define JOY_GETBUNDLE(bundleName) bundleName?[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName]]:nil

#define JOY_GETSOURCE_PATH(bundleName,resourceName) bundleName?[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@", bundleName, resourceName]]:resourceName

//获取bundle结束----------------------------------------------

//获取color----------------------------------------------

#define JOY_blackColor      [UIColor blackColor]      // 0.0 white
#define JOY_darkGrayColor   [UIColor darkGrayColor]   // 0.333 white
#define JOY_lightGrayColor  [UIColor lightGrayColor]  // 0.667 white
#define JOY_whiteColor      [UIColor whiteColor]      // 1.0 white
#define JOY_grayColor       [UIColor grayColor]       // 0.5 white
#define JOY_redColor        [UIColor redColor]        // 1.0, 0.0, 0.0 RGB
#define JOY_greenColor      [UIColor greenColor]      // 0.0, 1.0, 0.0 RGB
#define JOY_blueColor       [UIColor blueColor]       // 0.0, 0.0, 1.0 RGB
#define JOY_cyanColor       [UIColor cyanColor]       // 0.0, 1.0, 1.0 RGB
#define JOY_yellowColor     [UIColor yellowColor]     // 1.0, 1.0, 0.0 RGB
#define JOY_magentaColor    [UIColor magentaColor]    // 1.0, 0.0, 1.0 RGB
#define JOY_orangeColor     [UIColor orangeColor]     // 1.0, 0.5, 0.0 RGB
#define JOY_purpleColor     [UIColor purpleColor]     // 0.5, 0.0, 0.5 RGB
#define JOY_brownColor      [UIColor brownColor]      // 0.6, 0.4, 0.2 RGB
#define JOY_clearColor      [UIColor clearColor]      // 0.0 white, 0.0 alpha

#define JOY_colorList       @[JOY_blackColor,JOY_darkGrayColor,JOY_lightGrayColor,JOY_grayColor,JOY_redColor,JOY_greenColor,JOY_blueColor,JOY_cyanColor,JOY_yellowColor,JOY_magentaColor,JOY_orangeColor,JOY_purpleColor,JOY_brownColor]

#define JOY_RandomColor   UIColorFromRGB(arc4random()%0xFFFFFF)

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//获取color结束----------------------------------------------

typedef void (^IDBLOCK)(id idObject);
typedef void (^DICTBLOCK)(NSDictionary *dict);
typedef void (^ERRORBLOCK)(NSError *error);
typedef void (^LISTBLOCK)(NSArray *list);
typedef void (^BOOLBLOCK)(BOOL boolValue);
typedef void (^STRINGBLOCK)(NSString *str);
typedef void (^NUMBERBLOCK)(NSNumber *number);
typedef void (^FLOATBLOCK)(float floatValue);
typedef void (^INTBLOCK)(int intValue);
typedef void (^VOIDBLOCK)(void);

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

// 导航栏 + 状态栏 的高度
#define Joy_NavigationBarHeight (kDevice_Is_iPhoneX ? 88 : 64)
#define Joy_TopMargin (kDevice_Is_iPhoneX ? 44 : 0)
#define Joy_BottomMargin (kDevice_Is_iPhoneX ? 34 : 0)

#define Joy_iOS11_Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#define Joy_iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

#define Joy_iOS9_Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

#define Joy_iOS8_2Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.2f)
#endif /* Joy_h */
