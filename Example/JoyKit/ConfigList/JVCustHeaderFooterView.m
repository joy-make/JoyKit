//
//  JVCustHeaderFooterView.m
//  JoyKit_Example
//
//  Created by Joymake on 2018/11/8.
//  Copyright © 2018年 joy-make. All rights reserved.
//

#import "JVCustHeaderFooterView.h"
#import "JoySectionBaseModel.h"
#import <Masonry/Masonry.h>

@interface JVCustHeaderFooterView ()
@property (nonatomic,strong)UIButton *testBtn;

@end

@implementation JVCustHeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.testBtn];
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        [self setConstraints];
    }
    return self;
}

- (void)setConstraints{
    [self.testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];
}

-(UIButton *)testBtn{
    if (!_testBtn) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testBtn setFrame:CGRectMake(0, 0, 375, 100)];
        [_testBtn setTitle:@"sectionBtn" forState:UIControlStateNormal];
        [_testBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}

- (void)btnClick{
    self.headerViewActionBlock?self.headerViewActionBlock(@"btnClick"):nil;
}

-(void)setHeaderFooterWithModel:(JoySectionBaseModel *)model isHeader:(BOOL)isHeader{
    [_testBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    __weak __typeof(&*self)weakSelf = self;
    model.headerFooterAToBBlock = ^(UIColor *color) {
        [weakSelf.testBtn setTitleColor:color forState:UIControlStateNormal];
    };
}

@end
