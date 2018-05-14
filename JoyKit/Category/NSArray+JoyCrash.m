//
//  NSArray+JoyCrash.m
//  JoyKit
//
//  Created by Joymake on 2016/5/14.
//

#import "NSArray+JoyCrash.h"
#import <objc/runtime.h>

@implementation NSArray (JoyCrash)
#ifdef RELEASE
+(void)load{
    [super load];
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(joyObjectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}
#else
#endif

- (id)joyObjectAtIndex:(NSInteger)index{
    if (self.count-1 <index) {
        @try {
            [self joyObjectAtIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"ERROR:%@",[exception callStackSymbols]);
        }
        @finally {}
        return nil;
    }else{
        return [self joyObjectAtIndex:index];
    }
}

@end
