//
//  JoyLeftAvatarRightTopBottomLabel.m
//  Toon
//
//  Created by joymake on 16/3/22.
//  Copyright © 2016年 Joy. All rights reserved.
//


#import "JoyLeftAvatarRightTopBottomLabel.h"
#import "JoyCellBaseModel.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface JoyLeftAvatarRightTopBottomLabel ()

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@end

@implementation JoyLeftAvatarRightTopBottomLabel

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UIImageView *)headImageView{
    return _headImageView =  _headImageView?: [[UIImageView alloc]initWithFrame:CGRectZero];
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _titleLabel;}

-(UILabel *)subtitleLabel{
    if(!_subtitleLabel){
    _subtitleLabel = [[UILabel alloc]init];
    _subtitleLabel.textColor = UIColorFromRGB(0x757887);
    _subtitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _subtitleLabel;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.headImageView,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.width.mas_equalTo(weakSelf.headImageView.mas_height);
                   make.height.mas_lessThanOrEqualTo(60);
                   make.top.mas_equalTo(KCellTopOffset);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.headImageView.mas_trailing).offset(10);
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.height.mas_equalTo(17);
                   make.centerY.mas_equalTo(weakSelf.headImageView.mas_centerY).offset(-13);
                   );
    
    MAS_CONSTRAINT(self.subtitleLabel,
                   make.leading.mas_equalTo(weakSelf.headImageView.mas_trailing).offset(10);
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.height.mas_equalTo(17);
                   make.centerY.mas_equalTo(weakSelf.headImageView.mas_centerY).offset(13);
                   );
}


-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.subTitle;
    if (model.titleColor) {
        self.titleLabel.textColor = KJoyHexColor(model.titleColor,1);
    }
    if (model.subTitleColor) {
        self.subtitleLabel.textColor = KJoyHexColor(model.subTitleColor,1);
    }
    SDIMAGE_LOAD(self.headImageView, model.avatar,model.placeHolderImageStr);
}

@end
