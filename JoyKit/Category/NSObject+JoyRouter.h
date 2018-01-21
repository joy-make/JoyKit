//
//  NSObject+JoyRouter.h
//  Toon
//
//  Created by joymake on 2017/3/8.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JoyRouter)
-(NSObject *)joyProtocolObjectFromStr:(NSString *)classStr;


-(Class)joyClassFromStr:(NSString *)classStr;

@end
