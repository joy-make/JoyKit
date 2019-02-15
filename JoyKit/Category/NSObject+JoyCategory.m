//
//  NSObject+JoyCategory.m
//  JoyKit
//
//  Created by Joymake on 2018/9/8.
//

#import "NSObject+JoyCategory.h"
#import <objc/runtime.h>

@implementation NSObject (JoyCategory)
+ (void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    //原有方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    //替换原有方法的新方法
    
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {//添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {//添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)performTapAction:(NSString *)tapActionStr{
    if (tapActionStr) {
        SEL selector = NSSelectorFromString(tapActionStr);
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        if ([self respondsToSelector:selector]) {
            func(self, selector);
            NSLog(@"\n *********************************************************\n You has performed the Method \"%@\"  in the class \"%@\" \n *********************************************************\n ",tapActionStr,NSStringFromClass([self class]));
        }else{
            NSLog(@"\n *********************************************************\n Oh my God ,I hasn't Found the Method \"%@\" in implementation,Please Sure it's in the class \"%@\"\n *********************************************************\n ",tapActionStr,NSStringFromClass([self class]));
        }
    }else{
        NSLog( @"\n *********************************************************\n You had do nothing,if you want to do something please tell you cellModel and Realize it  in the class \"%@\"  \n *********************************************************\n ",NSStringFromClass([self class]));
    }
}

@end
