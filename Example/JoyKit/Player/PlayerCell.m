//
//  PlayerCell.m
//  JoyKit_Example
//
//  Created by Joymake on 2020/9/5.
//  Copyright © 2020 joy-make. All rights reserved.
//

#import "PlayerCell.h"
#import <Masonry/Masonry.h>

@interface  PlayerCell ()
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,readwrite,strong)AVPlayer *player;

@end

@implementation PlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.leading.trailing.mas_equalTo(0);
            make.height.mas_equalTo(150);
        }];
        [self updateConstraintsIfNeeded];
    }
    return self;;
}

-(void)setCellWithModel:(NSObject *)model{
//    [self performSelector:@selector(play) withObject:model afterDelay:0.2 inModes:@[NSDefaultRunLoopMode]];
}

//-(void)play{
//    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    [self.backView.layer addSublayer:layer];
//    layer.frame = self.backView.frame;
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//
//-(AVPlayer *)player{
//    if (!_player){
//        _player = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4"]]];
//    }
//    return _player;
//}

- (UIView *)backView{
    return _backView = _backView?:UIView.new;
}

-(void)dealloc{
    [self.player pause];
}
@end
