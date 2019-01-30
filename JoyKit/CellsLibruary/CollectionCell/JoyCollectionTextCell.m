//
//  JoyCollectionTextCell.m
//  JoyKit_Example
//
//  Created by Joymake on 2019/1/21.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import "JoyCollectionTextCell.h"
#import "JoyCellBaseModel.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface JoyCollectionTextCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation JoyCollectionTextCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.layer.cornerRadius = 5;
        _titleLabel.layer.borderWidth=1;
        _titleLabel.layer.borderColor = [UIColor greenColor].CGColor;
    }
    return _titleLabel;
}

-(void)setConstraint{
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(0);
                   make.top.mas_equalTo(5);
                   make.height.mas_equalTo(25);
                   make.centerX.mas_equalTo(self.contentView);
                   make.centerY.mas_equalTo(self.contentView);
                   );
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    self.titleLabel.text = cellModel.title;
    if(cellModel.titleColor){
        self.titleLabel.textColor = KJoyHexColor(cellModel.titleColor,1);
    }
}
@end
