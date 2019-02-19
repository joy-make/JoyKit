//
//  SwitchCell.m
//  Toon
//
//  Created by joymake on 16/5/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoySwitchCell.h"
#import "JoyCellBaseModel.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface JoySwitchCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UISwitch *mySwitch;

- (void)addSubViews;
@end

@implementation JoySwitchCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.mySwitch];
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

-(UISwitch *)mySwitch{
    if (!_mySwitch) {
        _mySwitch = [[UISwitch alloc]initWithFrame:CGRectZero];
        [_mySwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _mySwitch;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.trailing.mas_equalTo(weakSelf.mySwitch.mas_leading).offset(-15);
                   make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.mySwitch,
                   make.trailing.mas_equalTo(weakSelf.contentView.mas_trailing).offset(-15);
                   make.width.mas_equalTo(49);
                   make.top.mas_greaterThanOrEqualTo(weakSelf.contentView.mas_top).offset(6);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}

-(void)setCellWithModel:(JoySwitchCellBaseModel *)model{
    self.titleLabel.text = model.title;
    self.mySwitch.userInteractionEnabled = !model.disable;
    self.mySwitch.on = model.on;
    if(model.titleColor){
        self.titleLabel.textColor = KJoyHexColor(model.titleColor, 1);
    }
    if(model.switchBackColor){
        self.mySwitch.backgroundColor = KJoyHexColor(model.switchBackColor, 1);
    }
    
    if(model.onTintColor){
        self.mySwitch.onTintColor = KJoyHexColor(model.onTintColor, 1);
    }

    __block JoySwitchCellBaseModel *switchModel = model;
    __weak typeof (self) weakSelf = self;
    model.aToBCellBlock= ^(id onState){
        switchModel.on = [onState boolValue];
        [weakSelf.mySwitch setOn:[onState boolValue] animated:NO];
        [weakSelf.mySwitch layoutIfNeeded];
    };
    objc_setAssociatedObject(self, @selector(switchValueChanged:), model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)switchValueChanged:(UISwitch *)sender {
    JoySwitchCellBaseModel *model = objc_getAssociatedObject(self, _cmd) ;
    model.on = sender.on;
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        [self.delegate textChanged:self.index andText:(NSString *)@(sender.on) andChangedKey:model.changeKey];
    }
}

@end


@interface JoySwitchSubTitleCell ()
@property (strong, nonatomic) UILabel *switchSubTitleLabel;

@end

@implementation JoySwitchSubTitleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.switchSubTitleLabel];
    [self.contentView addSubview:self.mySwitch];
}

-(void)setConstraint{
    MAS_CONSTRAINT(self.mySwitch,
                   make.trailing.mas_equalTo(-15);
                   make.width.mas_equalTo(49);
                   make.top.mas_greaterThanOrEqualTo(6);
                   make.centerY.mas_equalTo(self.contentView.mas_centerY);
                   );
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(15);
                   make.trailing.mas_equalTo(self.mySwitch.mas_leading).offset(-15);
                   make.top.mas_equalTo(18);
                   make.bottom.mas_equalTo(self.contentView.mas_centerY).mas_offset(-3);
                   );
    
    MAS_CONSTRAINT(self.switchSubTitleLabel,
                   make.leading.trailing.mas_equalTo(self.titleLabel);
                   make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(6);
                   make.bottom.mas_equalTo(-18);
                   );
}

-(void)setCellWithModel:(JoySwitchCellBaseModel *)model{
    [super setCellWithModel:model];
    self.switchSubTitleLabel.text = model.subTitle;
    if(model.subTitleColor){
        self.switchSubTitleLabel.textColor = KJoyHexColor(model.subTitleColor, 1);
    }
}

-(UILabel *)switchSubTitleLabel{
    if(!_switchSubTitleLabel){
        _switchSubTitleLabel = [[UILabel alloc]init];
        _switchSubTitleLabel.numberOfLines = 0;
        _switchSubTitleLabel.font = [UIFont systemFontOfSize:12];
        _switchSubTitleLabel.textColor = KJoyHexColor(@"0x999999", 1);
    }
    return _switchSubTitleLabel;
}


@end
