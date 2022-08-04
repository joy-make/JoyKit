//
//  PlayerCell.m
//  JoyKit_Example
//
//  Created by Joymake on 2020/9/5.
//  Copyright © 2020 joy-make. All rights reserved.
//

#import "PlayerCell.h"
#import <Masonry/Masonry.h>
#import <Joy.h>>

@interface  PlayerCell ()
@property (nonatomic,strong)UIImageView *backImageView;
@property (nonatomic,readwrite,strong)AVPlayer *player;

@end

@implementation PlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backImageView];
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.leading.trailing.mas_equalTo(0);
            make.height.mas_equalTo(UIScreen.mainScreen.bounds.size.height);
        }];
        [self updateConstraintsIfNeeded];
    }
    return self;;
}

-(void)setCellWithModel:(JoyCellBaseModel *)model{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:(NSString *)model.expandObj];
        // 获取第一帧图片
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
        AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        generate.appliesPreferredTrackTransform = YES;
        NSError *err = NULL;
        CMTime time = CMTimeMake(0, 1);
        CGImageRef oneRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
        UIImage *oneImg = [[UIImage alloc] initWithCGImage:oneRef];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.backImageView.image = oneImg;
        });
    });
    self.backgroundColor = JOY_RandomColor;
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

-(AVPlayer *)player{
    if (!_player){
        _player = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4"]]];
    }
    return _player;
}

-(UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageView;
}

-(void)dealloc{
    [self.player pause];
}
@end
