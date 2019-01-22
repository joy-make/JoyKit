//
//  UIColor+JoyColor.m
//  JoyKit
//
//  Created by Joymake on 2019/1/22.
//

#import "UIColor+JoyColor.h"

@implementation UIColor (JoyColor)

+ (UIColor *)joyColorWithRGBHex:(UInt32)hex {
    return [UIColor joyColorWithRGBHex:hex alpha:1.0];
}

+ (UIColor *)joyColorWithRGBHex:(UInt32)hex  alpha:(float)alpha{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    float al = (alpha >=0 && alpha <= 1.0f) ? alpha : 1.0f;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:al];
}
// Returns a UIColor by scanning the string for a hex number and passing that to +[UIColor joyColorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters
+ (UIColor *)joyColorWithHEXString:(NSString *)stringToConvert{
    return [UIColor joyColorWithHEXString:stringToConvert alpha:1.0];
}

+ (UIColor *)joyColorWithHEXString:(NSString *)stringToConvert  alpha:(float)alpha{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // 字符串应该是6个或者8个字节
    if ([cString length] < 6) return [UIColor clearColor];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    
    stringToConvert = cString;
    
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return [UIColor clearColor];
    float al = (alpha >=0 && alpha <= 1.0f) ? alpha : 1.0f;
    return [UIColor joyColorWithRGBHex:hexNum alpha:al];
}

+ (UIColor *) joyColorWithHexString: (NSString *)color{
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
