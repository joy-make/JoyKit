//
//  CollectionInteractor.h
//  JoyKit_Example
//
//  Created by Joymake on 2019/1/21.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import "JoyInteractorBase.h"
#import <Joy.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionInteractor : JoyInteractorBase

- (void)getDataSource:(VOIDBLOCK)success;
@end

NS_ASSUME_NONNULL_END
