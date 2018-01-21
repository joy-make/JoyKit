//
//  JVInteractor.h
//  JoyTool
//
//  Created by joymake on 2017/4/12.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyKit.h"

@interface JVInteractor : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;
- (void)getDataSourceSuccess:(LISTBLOCK)list;
@end
