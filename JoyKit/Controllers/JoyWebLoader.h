//
//  JoyWebLoader.h
//  LW
//
//  Created by joymake on 2017/6/12.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "Joy.h"
#import "JoyBaseVC.h"
#import "JoyWebView.h"

@interface JoyWebLoader : JoyBaseVC
@property (nonatomic,readonly)JoyWebLoader        *(^initUrlStr)(NSString *urlString);
@property (nonatomic,readonly)JoyWebLoader        *(^initUrlType)(JoyUrl_Type urlType);
@property (nonatomic,readonly)JoyWebLoader          *(^startLoad)(void);

@end
