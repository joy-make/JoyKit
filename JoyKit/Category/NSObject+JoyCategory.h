//
//  NSObject+JoyCategory.h
//  JoyKit
//
//  Created by Joymake on 2018/9/8.
//

#import <Foundation/Foundation.h>

@interface NSObject (JoyCategory)

+ (void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

- (void)performTapAction:(NSString *)tapActionStr;

@end
