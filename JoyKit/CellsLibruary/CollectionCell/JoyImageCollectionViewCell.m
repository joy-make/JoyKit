//
//  JoyImageCollectionViewCell.m
//  Toon
//
//  Created by joymake on 16/7/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyImageCollectionViewCell.h"
#import "JoyCellBaseModel.h"
#import "UIImageView+JoyCategory.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@implementation JoyCollectionBaseCell

-(instancetype)initWithFrame:(CGRect)frame{
    if  (self = [super initWithFrame:frame]){
    }
    return self;
}
@end

@interface JoyImageCollectionViewCell ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@end
@implementation JoyImageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        self.contentView.backgroundColor = [UIColor orangeColor];
        [self setConstraint];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
    }
    return self;
}

-(UIImageView *)imageView{
    return _imageView =  _imageView?: [[UIImageView alloc]initWithFrame:CGRectZero];
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.imageView,
                   make.leading.mas_equalTo(5);
                   make.width.mas_equalTo(weakSelf.imageView.mas_height);
                   make.height.mas_equalTo(55);
                   make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(5);
                   make.centerX.mas_equalTo(weakSelf.contentView);
                   );
    
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(5);
                   make.height.mas_equalTo(20);
                   make.top.mas_equalTo(weakSelf.imageView.mas_bottom).offset(5);
                   make.bottom.mas_equalTo(weakSelf.contentView).offset(-5);
                   make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
                   );
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    [self.imageView joySetImageWithUrlString:cellModel.avatar placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
    self.titleLabel.text = cellModel.title;
    if(cellModel.titleColor){
        self.titleLabel.textColor = KJoyHexColor(cellModel.titleColor,1);
    }
}
@end
