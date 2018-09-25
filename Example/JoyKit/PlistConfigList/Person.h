//
//  Person.h
//  testConfigApp_Example
//
//  Created by Joymake on 2018/6/25.
//  Copyright © 2018年 joy-make. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *like;
@property (nonatomic,copy)NSString *birthday;
@property (nonatomic,copy)NSString *intruduction;
@property (nonatomic,assign)BOOL location;

@end
