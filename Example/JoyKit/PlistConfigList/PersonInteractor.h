//
//  PersonInteractor.h
//  testConfigApp_Example
//
//  Created by Joymake on 2018/6/25.
//  Copyright © 2018年 joy-make. All rights reserved.
//

#import "JoyInteractorBase.h"
#import <JoyKit/Joy.h>
#import "Person.h"

@interface PersonInteractor : JoyInteractorBase
@property (nonatomic,strong)NSArray *sexList;
@property (nonatomic,strong)NSArray *likeList;
@property (nonatomic,strong)Person *person;
- (void)getPersonList:(VOIDBLOCK)success;

-(void)checkRequired:(STRINGBLOCK)topicStr;
@end
