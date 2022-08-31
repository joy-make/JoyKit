//
//  JoyLeftIconCell.m
//  Toon
//
//  Created by joymake on 16/7/25.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftIconCell.h"
#import "JoyCellBaseModel.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface JoyLeftIconCell ()

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic)  UILabel *titleLabel;

@end

@implementation JoyLeftIconCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _titleLabel;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.iconImageView,
                   make.leading.mas_equalTo(KCellLeadingOffset);
                   make.height.mas_equalTo(33.5);
                   make.width.mas_equalTo(weakSelf.iconImageView.mas_height);
                   make.top.mas_greaterThanOrEqualTo(KCellTopOffset);
                   make.centerY.mas_equalTo(weakSelf.contentView);
                   );
    
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.iconImageView.mas_trailing).offset(15);
                   make.trailing.mas_equalTo(-KCellTrailingOffset);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}

-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    SDIMAGE_LOAD(_iconImageView, model.avatar, model.placeHolderImageStr);
    if (model.viewShape == EImageTypeRound) {
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 17;
    }else{
        _iconImageView.layer.masksToBounds = NO;
    }
    
    if (model.titleColor) {
        _titleLabel.textColor = KJoyHexColor(model.titleColor, 1);
    }

    _titleLabel.text = model.title;
}

@end
