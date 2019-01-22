//
//  JoyCollectionReusableView.m
//  JoyKit_Example
//
//  Created by Joymake on 2019/1/21.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import "JoyCollectionReusableView.h"
#import <JoySectionBaseModel.h>
#import "Masonry.h"

@implementation JoyCollectionReusableView


- (void)setHeaderFooterWithModel:(JoySectionBaseModel *)sectinModel isHeader:(BOOL)isHeader;{
    self.textLabel.text = isHeader?sectinModel.sectionTitle:sectinModel.sectionFootTitle;
}

-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _textLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.textLabel];
        [self setConstraints];
    }
    return self;
}

- (void)setConstraints{
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(15);
        make.bottom.mas_equalTo(0);
    }];
}
@end
