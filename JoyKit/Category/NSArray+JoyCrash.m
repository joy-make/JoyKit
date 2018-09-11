//
//  NSArray+JoyCrash.m
//  JoyKit
//
//  Created by Joymake on 2016/5/14.
//

#import "NSArray+JoyCrash.h"
#import "NSObject+JoyCategory.h"
#import <objc/runtime.h>

@implementation NSArray (JoyCrash)
#ifdef RELEASE
+(void)load{
    [super load];
    [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(joyObjectAtIndex:)];
//
//    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
//    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(joyObjectAtIndex:));
//    method_exchangeImplementations(fromMethod, toMethod);
}
#else
#endif

- (id)joyObjectAtIndex:(NSInteger)index{
    if (self.count<=index || index<0) {
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

@implementation NSMutableArray (JoyCrash)
#ifdef RELEASE
+(void)load{
    [super load];
    [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(joyObjectAtIndex:)];
    [objc_getClass("__NSArrayM") swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(joyInsertObject:atIndex:)];
    [objc_getClass("__NSArrayM") swizzleMethod:@selector(addObject:) swizzledSelector:@selector(joyAddObject:)];
}
#else
#endif
- (void)joyInsertObject:(id)object atIndex:(NSUInteger)index{
    if (object) {
        [self joyInsertObject:object atIndex:index];
    }
}

- (void)joyAddObject:(id)obj
{
    if (obj) {
        [self joyAddObject:obj];
    }
}
@end
