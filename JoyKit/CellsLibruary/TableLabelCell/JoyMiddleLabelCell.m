//
//  JoyMiddleLabelCell.m
//  Toon
//
//  Created by joymake on 16/7/27.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyMiddleLabelCell.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface JoyMiddleLabelCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) JoyCellBaseModel   *model;
@end

@implementation JoyMiddleLabelCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        [self.contentView addGestureRecognizer:longPress];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel = _titleLabel?:[[UILabel alloc]init];
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.top.mas_equalTo(weakSelf.contentView).offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}
- (void)setCellWithModel:(JoyCellBaseModel *)model{
    self.model = model;
    self.titleLabel.text = model.title;
    if (model.titleColor) {
        self.titleLabel.textColor = KJoyHexColor(model.titleColor,1);
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.model.longPressAction&&self.longPressBlock?self.longPressBlock():nil;
    }
}
@end
