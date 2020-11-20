//
//  PlayerCell.h
//  JoyKit_Example
//
//  Created by Joymake on 2020/9/5.
//  Copyright © 2020 joy-make. All rights reserved.
//

#import "JoyBaseCell.h"
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerCell : JoyBaseCell
@property (nonatomic,readonly)AVPlayer *player;
@end

NS_ASSUME_NONNULL_END
