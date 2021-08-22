//
//  JoyPortalCollectionCell.m
//  Home
//
//  Created by joy on 2021/8/10.
//

#import "JoyPortalCollectionCell.h"
#import <JoyKit/JoyCellBaseModel.h>
#import <JoyKit/UIColor+JoyColor.h>
#import <JoyKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@implementation JoyPortalCollectionCell

@end


@interface JoySigleCollectionCell ()
@property (strong, nonatomic) UIImageView *imageView;
@end
@implementation JoySigleCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self setConstraint];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self.contentView addSubview:self.imageView];
        [self setConstraint];
    }
    return self;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.clipsToBounds = true;
        _imageView.layer.masksToBounds = true;
        _imageView.layer.cornerRadius =5;
    }
    return _imageView ;
}

-(void)setConstraint{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(SCREEN_W-30);
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(210.0/345);
    }];
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellModel.avatar] placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
}
@end


@interface JoySigleMiniCollectionCell ()

@end
@implementation JoySigleMiniCollectionCell
-(void)setConstraint{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(SCREEN_W-30);
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(76.0/263);
    }];
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellModel.avatar] placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
}

@end


@interface JoyQuadraCollectionCell ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@end
@implementation JoyQuadraCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
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
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 5;
        _imageView.layer.masksToBounds = true;
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines =0;
        _titleLabel.textColor = [UIColor joyColorWithHEXString:@"#2F2F2F"];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

-(void)setConstraint{
    int itemCount = [self getItemCount];
    float CollectionLeadingOffSet = 15.0;
    float itemSpace = 15.0;
    float itemWidth = (SCREEN_W-2*CollectionLeadingOffSet-(itemCount-1)*itemSpace)/itemCount;
    float imageLeading = 15.0;
    float imageWidthHeight = (itemWidth -imageLeading*2);
    float imageTopBottom = 10.0;
    float labelBottom = 10.0;
    float titleLabelHeight = 15.0;
    float itemHeight = imageTopBottom+imageWidthHeight+imageTopBottom+titleLabelHeight+labelBottom;
    CGSize itemSize = CGSizeMake(itemWidth, itemHeight);

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(imageLeading);
        make.width.height.mas_equalTo(imageWidthHeight);
//        make.height.mas_equalTo(self.imageView.mas_width);
        make.top.mas_equalTo(imageTopBottom);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(titleLabelHeight);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(imageTopBottom);
        make.bottom.mas_equalTo(self.contentView).offset(-labelBottom);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
}

-(NSInteger)getItemCount{
    return 4;
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellModel.avatar] placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
    self.titleLabel.text = cellModel.title;
}
@end

@implementation JoyPentalCollectionCell
-(NSInteger)getItemCount{
    return 5;
}

-(void)setCellWithModel:(NSObject *)cellModel{
    [super setCellWithModel:cellModel];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
}
@end

@implementation JoyTripleCollectionCell

-(void)setCellWithModel:(NSObject *)cellModel{
    [super setCellWithModel:cellModel];
    self.titleLabel.textColor = [UIColor joyColorWithHEXString:@"#8D4C10"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}
-(void)setConstraint{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.width.mas_equalTo((SCREEN_W-60)/3);
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(80.0/105);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.imageView.mas_leading).offset(5);
        make.trailing.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.imageView.mas_top).offset(5);
    }];
}

@end

@interface JoyDoubleCollectionCell ()
@property(nonatomic,strong)UIView *backView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@end
@implementation JoyDoubleCollectionCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.imageView];
        [self.backView addSubview:self.titleLabel];
        [self setConstraint];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.imageView];
        [self.backView addSubview:self.titleLabel];
        [self setConstraint];
    }
    return self;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.layer.cornerRadius = 5;
        _imageView.layer.masksToBounds = true;
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines =0;
    }
    return _titleLabel;
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellModel.avatar] placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
    self.titleLabel.text = cellModel.title;
}

-(void)setConstraint{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(0);
        make.width.mas_equalTo((SCREEN_W-60)/2);
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(108.0/156.0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(5);
        make.centerX.mas_equalTo(self.backView);
        make.top.mas_greaterThanOrEqualTo(self.imageView.mas_bottom).offset(5);
        make.bottom.mas_greaterThanOrEqualTo(-5);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(0);
        make.trailing.mas_equalTo(-15);
        make.bottom.mas_equalTo(-5);
    }];
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _backView.layer.cornerRadius = 2;
        _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0,2);
        _backView.layer.shadowOpacity = 1;
        _backView.layer.shadowRadius = 6;
    }
    return _backView;
}

@end

@interface JoyDoubleTitleRightIconlCollectionCell ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;

@end

@implementation JoyDoubleTitleRightIconlCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.imageView addSubview:self.titleLabel];
        [self.imageView addSubview:self.subTitleLabel];
        [self.imageView addSubview:self.iconImageView];
        [self setConstraint];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self.contentView addSubview:self.imageView];
        [self.imageView addSubview:self.titleLabel];
        [self.imageView addSubview:self.subTitleLabel];
        [self.imageView addSubview:self.iconImageView];
        [self setConstraint];
    }
    return self;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 5;
        _imageView.layer.masksToBounds = true;
    }
    return _imageView;
}

-(UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.cornerRadius = 5;
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}


-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines =0;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel{
    if(!_subTitleLabel){
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.numberOfLines =0;
        _subTitleLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _subTitleLabel;
}

-(void)setConstraint{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.width.mas_equalTo((SCREEN_W-45.0)/2);
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(68.0/167);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(27);
        make.centerY.mas_equalTo(self.imageView);
        make.trailing.mas_equalTo(-12);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.trailing.mas_equalTo(self.iconImageView.mas_leading);
        make.bottom.mas_equalTo(self.imageView.mas_centerY);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.trailing.mas_equalTo(self.iconImageView.mas_leading);
        make.top.mas_equalTo(self.imageView.mas_centerY);
    }];
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    if (cellModel.backgroundColor) {
        self.imageView.backgroundColor = [UIColor joyColorWithHEXString:cellModel.backgroundColor];
    }
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellModel.avatar] placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.avatar] placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
    self.titleLabel.text = cellModel.title;
    self.subTitleLabel.text = cellModel.subTitle;
}
@end

@interface JoyLeftIconRightDoubleTitleCollectionCell ()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@end

@implementation JoyLeftIconRightDoubleTitleCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.titleLabel];
        [self.backView addSubview:self.subTitleLabel];
        [self.backView addSubview:self.iconImageView];
        [self setConstraint];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.titleLabel];
        [self.backView addSubview:self.subTitleLabel];
        [self.backView addSubview:self.iconImageView];
        [self setConstraint];
    }
    return self;
}

-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]initWithFrame:CGRectZero];
        _backView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = true;
        _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0,2);
        _backView.layer.shadowOpacity = 1;
        _backView.layer.shadowRadius = 6;
    }
    return _backView;
}

-(UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.cornerRadius = 5;
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}


-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines =0;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel{
    if(!_subTitleLabel){
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _subTitleLabel;
}

-(void)setConstraint{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.width.mas_equalTo((SCREEN_W-45.0)/2);
        make.height.mas_equalTo(self.backView.mas_width).multipliedBy(68.0/167);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(27);
        make.centerY.mas_equalTo(self.backView);
        make.leading.mas_equalTo(10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-12);
        make.leading.mas_equalTo(self.iconImageView.mas_trailing).mas_offset(10);
        make.bottom.mas_equalTo(self.backView.mas_centerY);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-12);
        make.leading.mas_equalTo(self.iconImageView.mas_trailing).mas_offset(10);
        make.top.mas_equalTo(self.backView.mas_centerY).mas_offset(4);
    }];
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    if(cellModel.backgroundColor){
        [self.backView setBackgroundColor:[UIColor joyColorWithHEXString:cellModel.backgroundColor]];
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.avatar] placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
    self.titleLabel.text = cellModel.title;
    self.subTitleLabel.text = cellModel.subTitle;
}

@end


@interface JoyTopIconTitleSubTitleCollectionCell ()
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *subTitleLabel;
@end

@implementation JoyTopIconTitleSubTitleCollectionCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    self.contentView.layer.masksToBounds = true;
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.iconImageView];
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.subTitleLabel];
}

-(void)setConstraints{
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo((SCREEN_W-45.0)/2);
//        make.height.mas_equalTo(self.bottomView.mas_width).multipliedBy(142.0/167);
        make.height.mas_equalTo((68.0/167) *(SCREEN_W-45.0) +15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.width.height.mas_equalTo(50);
        make.centerX.mas_equalTo(self.bottomView);
        make.bottom.mas_equalTo(self.bottomView.mas_centerY).mas_offset(-4);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(4);
        make.centerX.mas_equalTo(self.bottomView);
        make.bottom.mas_equalTo(self.subTitleLabel.mas_top).mas_offset(-4);
    }];

    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.bottom.mas_greaterThanOrEqualTo(-10);
    }];
}

-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    if (model.backgroundColor) {
        [self.bottomView setBackgroundColor:[UIColor joyColorWithHEXString:model.backgroundColor]];
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:model.placeHolderImageStr]];
    self.titleLabel.text= model.title;
    self.subTitleLabel.text= model.title;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.layer.cornerRadius = 5;
        _bottomView.layer.masksToBounds = true;
    }
    return _bottomView;
}

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.layer.cornerRadius=5;
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}

-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _subTitleLabel;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = UIColor.whiteColor;
    }
    return _titleLabel;
}

@end


@interface JoyNoticesCollectionCell ()
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation JoyNoticesCollectionCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.titleLabel];
}

-(void)setConstraints{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(SCREEN_W-110);
        make.height.mas_equalTo(30);
    }];
}

-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    self.titleLabel.text= model.title;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = UIColor.darkGrayColor;
    }
    return _titleLabel;
}
@end
