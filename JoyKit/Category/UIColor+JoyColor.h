//
//  UIColor+JoyColor.h
//  JoyKit
//
//  Created by Joymake on 2019/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JoyColor)
+ (UIColor *)joyColorWithRGBHex:(UInt32)hex;                                           //RGB example:0x66ff22
+ (UIColor *)joyColorWithRGBHex:(UInt32)hex alpha:(float)alpha;                        //RGBA
+ (UIColor *)joyColorWithHEXString:(NSString *)stringToConvert;                        //HEX example:@"#4A4A4A"
+ (UIColor *)joyColorWithHEXString:(NSString *)stringToConvert alpha:(float)alpha;     //HEXA
+ (UIColor *)joyColorWithHexString: (NSString *)color;

@end

NS_ASSUME_NONNULL_END
