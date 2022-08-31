//
//  JoyLeftAvatarRightLabelCell.m
//  Toon
//
//  Created by joymake on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftAvatarRightLabelCell.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface JoyLeftAvatarRightLabelCell ()
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end
@implementation JoyLeftAvatarRightLabelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.titleLabel];
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
    return _titleLabel;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.headImageView,
                   make.leading.mas_equalTo(KCellLeadingOffset);
                   make.height.mas_lessThanOrEqualTo(54.0f);
                   make.width.mas_equalTo(weakSelf.headImageView.mas_height);
                   make.top.mas_greaterThanOrEqualTo(KCellTopOffset);
                   make.centerY.mas_equalTo(weakSelf.contentView);
                   );
//
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.headImageView.mas_trailing).offset(15);
                   make.trailing.mas_equalTo(-KCellTrailingOffset);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)model{
    
    SDIMAGE_LOAD(self.headImageView, model.avatar,model.placeHolderImageStr);
    if (model.title) {
        self.titleLabel.text =  model.title;
    }
    if (model.titleColor) {
        self.titleLabel.textColor = KJoyHexColor(model.titleColor,1);
    }
    if (model.viewShape == EImageTypeRound) {
        self.headImageView.layer.cornerRadius = 27;
        self.headImageView.layer.masksToBounds = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
