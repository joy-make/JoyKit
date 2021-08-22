//
//  JoyTableCell.m
//  Home
//
//  Created by joy on 2021/8/10.
//

#import "JoyPortalTableCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <JoyKit/UIColor+JoyColor.h>
@implementation JoyPortalTableCell

@end

@interface JoySigleTableCell ()
@property(nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation JoySigleTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.collectionView];
}

-(void)setConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.height.mas_equalTo(self.collectionView.mas_width).multipliedBy(210.0/345.0);
    }];
}

-(void)setCellWithModel:(JoyTableCollectionCellBaseModel *)model{
    self.collectionView.setDataSource(model.itemList).reloadCollection();
}

-(JoyCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero layout:self.flowLayout];
        _collectionView.collectionView.pagingEnabled = true;
        _collectionView.layer.cornerRadius = 5;
        _collectionView.layer.masksToBounds = true;
        __weak __typeof(&*self)weakSelf = self;
        _collectionView.setCollectionInfinite(true, 3).cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            weakSelf.collectionDidSelectBlock?weakSelf.collectionDidSelectBlock(indexPath):nil;
        });
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
//        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        CGFloat height = (SCREEN_W-30)*210.0/345;
        _flowLayout.estimatedItemSize = CGSizeMake(SCREEN_W-30, roundf(height));
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _flowLayout.footerReferenceSize = CGSizeMake(0, 40);
    }
    return _flowLayout;
}

@end

@interface JoySigleMiniTableCell ()
@property(nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@end
@implementation JoySigleMiniTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.collectionView];
}

-(void)setConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.height.mas_equalTo(self.contentView.mas_width).multipliedBy(76.0/263.0);
    }];
}

-(void)setCellWithModel:(JoyTableCollectionCellBaseModel *)model{
    self.collectionView.setDataSource(model.itemList).reloadCollection();
}

-(JoyCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero layout:self.flowLayout];
        _collectionView.collectionView.pagingEnabled = true;
        _collectionView.layer.cornerRadius = 5;
        _collectionView.layer.masksToBounds = true;
        __weak __typeof(&*self)weakSelf = self;
        _collectionView.setCollectionInfinite(true, 3).cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            weakSelf.collectionDidSelectBlock?weakSelf.collectionDidSelectBlock(indexPath):nil;
        });
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
//        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        _flowLayout.estimatedItemSize = CGSizeMake(SCREEN_W-30, (SCREEN_W-30)*76.0/263);
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        _flowLayout.footerReferenceSize = CGSizeMake(0, 40);
    }
    return _flowLayout;
}
@end

@interface JoyDoubleTableCell ()
@property(nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation JoyDoubleTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.collectionView];
}

-(void)setConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(166);
    }];
}

-(void)setCellWithModel:(JoyTableCollectionCellBaseModel *)model{
    self.collectionView.setDataSource(model.itemList).reloadCollection();
//    CGFloat height = [self.collectionView setData:model.itemList];
//    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
//    [self.contentView setNeedsLayout];
}

-(JoyCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero layout:self.flowLayout];
        _collectionView.collectionView.pagingEnabled = true;
        __weak __typeof(&*self)weakSelf = self;
        _collectionView.cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            weakSelf.collectionDidSelectBlock?weakSelf.collectionDidSelectBlock(indexPath):nil;
        });
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.estimatedItemSize = CGSizeMake(156, 166);
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.footerReferenceSize = CGSizeZero;
    }
    return _flowLayout;
}

@end

@interface JoyDoubleNormalTableCell ()
@property(nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation JoyDoubleNormalTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.collectionView];
}

-(void)setConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.height.mas_equalTo(10+ 68.0/167*(SCREEN_W-45.0)/2);
    }];
}

-(void)setCellWithModel:(JoyTableCollectionCellBaseModel *)model{
    self.collectionView.setDataSource(model.itemList).reloadCollection();
//    CGFloat height = [self.collectionView setData:model.itemList];
//    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
//    [self.contentView setNeedsLayout];
}

-(JoyCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero layout:self.flowLayout];
        _collectionView.collectionView.pagingEnabled = true;
        __weak __typeof(&*self)weakSelf = self;
        _collectionView.cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            weakSelf.collectionDidSelectBlock?weakSelf.collectionDidSelectBlock(indexPath):nil;
        });
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 15;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
        _flowLayout.estimatedItemSize = CGSizeMake((SCREEN_W-45.0)/2, 68.0/167*(SCREEN_W-45.0)/2);
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.footerReferenceSize = CGSizeZero;
    }
    return _flowLayout;
}

@end
@interface JoyQuadraTableCell ()

@property(nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation JoyQuadraTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.collectionView];
}

-(void)setConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
    }];
}

-(void)setCellWithModel:(JoyTableCollectionCellBaseModel *)model{
    self.collectionView.setDataSource(model.itemList).reloadCollection();
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.flowLayout.collectionViewContentSize.height);
    }];
    [self.contentView layoutIfNeeded];
}

-(JoyCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero layout:self.flowLayout];
        _collectionView.collectionView.pagingEnabled = true;
        _collectionView.layer.cornerRadius = 5;
        _collectionView.layer.masksToBounds = true;
        _collectionView.collectionView.scrollEnabled = false;
        __weak __typeof(&*self)weakSelf = self;
        _collectionView.cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            weakSelf.collectionDidSelectBlock?weakSelf.collectionDidSelectBlock(indexPath):nil;
        });
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[UICollectionViewFlowLayout alloc]init];
        NSInteger itemCount = [self getItemCount];
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
        _flowLayout.estimatedItemSize = itemSize;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = itemSpace;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _flowLayout.estimatedItemSize = CGSizeMake((SCREEN_W-30)/4, (SCREEN_W-75)/4.0 +30);
        _flowLayout.headerReferenceSize = CGSizeZero;
    }
    return _flowLayout;
}

-(NSInteger)getItemCount{
    return 4;
}
@end

@implementation JoyPentaTableCell

-(NSInteger)getItemCount{
    return 5;
}

@end

@interface JoyTripleTableCell ()
@property(nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation JoyTripleTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.collectionView];
}

-(void)setConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
    }];
}

-(void)setCellWithModel:(JoyTableCollectionCellBaseModel *)model{
    self.collectionView.setDataSource(model.itemList).reloadCollection();
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.flowLayout.collectionViewContentSize.height);
    }];
    [self.contentView setNeedsLayout];
}

-(JoyCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero layout:self.flowLayout];
        _collectionView.collectionView.pagingEnabled = true;
        _collectionView.layer.cornerRadius = 5;
        _collectionView.layer.masksToBounds = true;
        _collectionView.collectionView.scrollEnabled = false;
        __weak __typeof(&*self)weakSelf = self;
        _collectionView.cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            weakSelf.collectionDidSelectBlock?weakSelf.collectionDidSelectBlock(indexPath):nil;
        });
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.estimatedItemSize = CGSizeMake((SCREEN_W-60)/3, ((SCREEN_W-60)/3) *(80.0/105)+5);
        _flowLayout.headerReferenceSize = CGSizeZero;
//        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        _flowLayout.footerReferenceSize = CGSizeMake(0, 40);
    }
    return _flowLayout;
}
@end

@interface JoyListMoreCell ()
@property(nonatomic,strong)UIView *leadingRedView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *subTitleLabel;
@property(nonatomic,strong)UIView *separateLineView;
@end

@implementation JoyListMoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.leadingRedView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.separateLineView];
}

-(void)setConstraints{
    [self.leadingRedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.width.mas_equalTo(2);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.leadingRedView.mas_trailing).mas_offset(13);
        make.top.mas_equalTo(12);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.separateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(0.3);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

-(void)setCellWithModel:(JoyCellBaseModel *)model{
    self.titleLabel.text= model.title;
    self.subTitleLabel.text= model.subTitle;
}

-(UIView *)leadingRedView{
    if (!_leadingRedView) {
        _leadingRedView = [UIView new];
        _leadingRedView.backgroundColor = [UIColor redColor];
    }
    return _leadingRedView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        _subTitleLabel.numberOfLines = 2;
        _subTitleLabel.textColor = UIColor.grayColor;
    }
    return _subTitleLabel;
}

-(UIView *)separateLineView{
    if (!_separateLineView) {
        _separateLineView = [UIView new];
        _separateLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _separateLineView;
}
@end

@interface JoyListCell ()
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *subTitleLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *reviewImageView;
@property(nonatomic,strong)UILabel *reviewLabel;
@property(nonatomic,strong)UIImageView *likeImageView;
@property(nonatomic,strong)UILabel *likeLabel;
@property(nonatomic,strong)UIImageView *shareImageView;
@property(nonatomic,strong)UILabel *shareLabel;
@property(nonatomic,strong)UIView *separateLineView;

@end

@implementation JoyListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.reviewImageView];
    [self.contentView addSubview:self.reviewLabel];
    [self.contentView addSubview:self.likeImageView];
    [self.contentView addSubview:self.likeLabel];
    [self.contentView addSubview:self.shareImageView];
    [self.contentView addSubview:self.shareLabel];
    [self.contentView addSubview:self.separateLineView];
}

-(void)setConstraints{
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(90);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.leftImageView.mas_trailing).mas_offset(19);
        make.top.mas_equalTo(self.leftImageView);
        make.trailing.mas_equalTo(-15);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabel);
        make.trailing.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.leftImageView);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.leftImageView);
        make.top.mas_equalTo(self.leftImageView.mas_bottom).mas_offset(20);
        make.bottom.mas_equalTo(self.separateLineView).mas_offset(-10);
    }];
    
    [self.reviewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLabel);
        make.width.height.mas_equalTo(15);
        make.trailing.mas_equalTo(self.reviewLabel.mas_leading).mas_offset(-10);
    }];
    
    [self.reviewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLabel);
        make.trailing.mas_equalTo(self.likeImageView.mas_leading).mas_offset(-20);
    }];
    
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLabel);
        make.width.height.mas_equalTo(15);
        make.trailing.mas_equalTo(self.likeLabel.mas_leading).mas_offset(-10);
    }];
    
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLabel);
        make.trailing.mas_equalTo(self.shareImageView.mas_leading).mas_offset(-20);
    }];
    
    [self.shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLabel);
        make.width.height.mas_equalTo(15);
        make.trailing.mas_equalTo(self.shareLabel.mas_leading).mas_offset(-10);

    }];
    
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLabel);
        make.trailing.mas_equalTo(-15);
    }];
    
    [self.separateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.height.mas_equalTo(0.3);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"template_cover_1"]];
    self.titleLabel.text= @"elf.leftImageView sd_setImageWithURL:nil placeholderImage:";
    self.subTitleLabel.text= @"elf.leftImageView sd_setImageWithURL:nil placeholderImage:";
    self.timeLabel.text= @"2018-03-09 22:00:00";
    [self.reviewImageView sd_setImageWithURL:[NSURL URLWithString:@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng3f3c6a2970de3c6e6cbee1773d901cc21d9cad184f110780688adb3d31b2cea3"] completed:nil];
    self.reviewLabel.text = @"1898";
    [self.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPngaa7e8bcce8ec0d39ee9a38d5070f4d214933ad90322620a636bc2eccad132912"] completed:nil];
    self.likeLabel.text = @"1022";
    [self.shareImageView sd_setImageWithURL:[NSURL URLWithString:@"https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng567cc913f600b12527f179d10fee8e59043812c191b291be020de7e20822f734"] completed:nil];
    self.shareLabel.text = @"223";
}

-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.layer.cornerRadius=5;
        _leftImageView.layer.masksToBounds = true;
    }
    return _leftImageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        _subTitleLabel.numberOfLines = 2;
        _subTitleLabel.textColor = UIColor.grayColor;
    }
    return _subTitleLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = UIColor.grayColor;
    }
    return _timeLabel;
}


-(UIImageView *)reviewImageView{
    if (!_reviewImageView) {
        _reviewImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _reviewImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _reviewImageView;
}

-(UILabel *)reviewLabel{
    if (!_reviewLabel) {
        _reviewLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _reviewLabel.font = [UIFont boldSystemFontOfSize:11];
        _reviewLabel.textColor = UIColor.darkGrayColor;
    }
    return _reviewLabel;
}

-(UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _likeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _likeImageView;
}

-(UILabel *)likeLabel{
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _likeLabel.font = [UIFont boldSystemFontOfSize:11];
        _likeLabel.textColor = UIColor.darkGrayColor;
    }
    return _likeLabel;
}

-(UIImageView *)shareImageView{
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _shareImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _shareImageView;
}

-(UILabel *)shareLabel{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _shareLabel.font = [UIFont boldSystemFontOfSize:11];
        _shareLabel.textColor = UIColor.darkGrayColor;
    }
    return _shareLabel;
}
-(UIView *)separateLineView{
    if (!_separateLineView) {
        _separateLineView = [UIView new];
        _separateLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _separateLineView;
}

@end


@interface JoyLeftImageRightCollectionTableCell ()
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@end

@implementation JoyLeftImageRightCollectionTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.collectionView];
//    [self.contentView addSubview:self.titleLabel];
}

-(void)setConstraints{
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftImageView);
        make.leading.mas_equalTo(self.leftImageView.mas_trailing);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];

//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(self.leftImageView.mas_trailing).mas_offset(10);
//        make.centerY.mas_equalTo(self.leftImageView);
//        make.trailing.mas_equalTo(-15);
//    }];
}

-(void)setCellWithModel:(JoyTableCollectionCellBaseModel *)model{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:@"https://www.lgstatic.com/thumbnail_300x300/image1/M00/00/01/Cgo8PFTUV_OAH8cPAACZoNxm1EI176.jpg"] placeholderImage:[UIImage imageNamed:@""]];
//    self.titleLabel.text= model.title;
    self.collectionView.setDataSource(model.itemList).reloadCollection();
}

-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.layer.cornerRadius=5;
        _leftImageView.layer.masksToBounds = true;
    }
    return _leftImageView;
}

//-(UILabel *)titleLabel{
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//        _titleLabel.font = [UIFont systemFontOfSize:14];
//    }
//    return _titleLabel;
//}

-(JoyCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero layout:self.flowLayout];
        _collectionView.collectionView.pagingEnabled = true;
        _collectionView.layer.cornerRadius = 5;
        _collectionView.layer.masksToBounds = true;
        __weak __typeof(&*self)weakSelf = self;
        _collectionView.setCollectionInfinite(true, 2).cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            weakSelf.collectionDidSelectBlock?weakSelf.collectionDidSelectBlock(indexPath):nil;
        });
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsZero;
        _flowLayout.estimatedItemSize = CGSizeMake(SCREEN_W-110, 30);
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        _flowLayout.footerReferenceSize = CGSizeMake(0, 40);
    }
    return _flowLayout;
}

@end

@interface JoySingleDoubleCell ()
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIImageView *leftIconImageView;
@property(nonatomic,strong)UILabel *leftTitleLabel;
@property(nonatomic,strong)UILabel *leftSubTitleLabel;

@property(nonatomic,strong)UIView *rightTopView;
@property(nonatomic,strong)UIImageView *rightTopIconImageView;
@property(nonatomic,strong)UILabel *rightTopTitleLabel;
@property(nonatomic,strong)UILabel *rightTopSubTitleLabel;

@property(nonatomic,strong)UIView *rightBottomView;
@property(nonatomic,strong)UIImageView *rightBottomIconImageView;
@property(nonatomic,strong)UILabel *rightBottomTitleLabel;
@property(nonatomic,strong)UILabel *rightBottomSubTitleLabel;
@end

@implementation JoySingleDoubleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.leftView];
    [self.leftView addSubview:self.leftIconImageView];
    [self.leftView addSubview:self.leftTitleLabel];
    [self.leftView addSubview:self.leftSubTitleLabel];
    [self.contentView addSubview:self.rightTopView];
    [self.rightTopView addSubview:self.rightTopIconImageView];
    [self.rightTopView addSubview:self.rightTopTitleLabel];
    [self.rightTopView addSubview:self.rightTopSubTitleLabel];
    [self.contentView addSubview:self.rightBottomView];
    [self.rightBottomView addSubview:self.rightBottomIconImageView];
    [self.rightBottomView addSubview:self.rightBottomTitleLabel];
    [self.rightBottomView addSubview:self.rightBottomSubTitleLabel];
}

-(void)setConstraints{
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.trailing.mas_equalTo(self.contentView.mas_centerX).mas_offset(-5);
        make.height.mas_equalTo(142);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.leftIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.width.height.mas_equalTo(50);
        make.centerX.mas_equalTo(self.leftView);
        make.bottom.mas_equalTo(self.leftTitleLabel.mas_top).mas_offset(-4);
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftView);
        make.bottom.mas_equalTo(self.leftSubTitleLabel.mas_top).mas_offset(-4);
    }];

    [self.leftSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftView);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.rightTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_centerX).mas_offset(5);
        make.trailing.mas_equalTo(-15);
        make.top.mas_equalTo(self.leftView);
        make.bottom.mas_equalTo(self.contentView.mas_centerY).mas_offset(-5);
    }];
    
    [self.rightTopIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.height.width.mas_equalTo(36);
        make.centerY.mas_equalTo(self.rightTopView);
    }];
    
    [self.rightTopTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rightTopIconImageView.mas_trailing).mas_offset(10);
        make.trailing.mas_equalTo(-10);
        make.top.mas_equalTo(self.rightTopIconImageView);
    }];
    
    [self.rightTopSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rightTopIconImageView.mas_trailing).mas_offset(10);
        make.trailing.mas_equalTo(-10);
        make.bottom.mas_equalTo(self.rightTopIconImageView);
    }];

    [self.rightBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_centerX).mas_offset(5);
        make.trailing.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.leftView);
        make.top.mas_equalTo(self.contentView.mas_centerY).mas_offset(5);
    }];
    
    [self.rightBottomIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.height.width.mas_equalTo(36);
        make.centerY.mas_equalTo(self.rightBottomView);
    }];
    
    [self.rightBottomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rightBottomIconImageView.mas_trailing).mas_offset(10);
        make.trailing.mas_equalTo(-10);
        make.top.mas_equalTo(self.rightBottomIconImageView);
    }];
    
    [self.rightBottomSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.rightBottomIconImageView.mas_trailing).mas_offset(10);
        make.trailing.mas_equalTo(-10);
        make.bottom.mas_equalTo(self.rightBottomIconImageView);
    }];
}

-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    [self.leftIconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:model.placeHolderImageStr]];
    self.leftTitleLabel.text= model.title;
    self.leftSubTitleLabel.text= model.title;
    
    [self.rightTopIconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:model.placeHolderImageStr]];
    self.rightTopTitleLabel.text= model.title;
    self.rightTopSubTitleLabel.text= model.title;

    [self.rightBottomIconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:model.placeHolderImageStr]];
    self.rightBottomTitleLabel.text= model.title;
    self.rightBottomSubTitleLabel.text= model.title;
}

-(UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc]init];
        _leftView.backgroundColor = [UIColor joyColorWithHEXString:@"#FB5053"];
        _leftView.layer.cornerRadius = 5;
        _leftView.layer.masksToBounds = true;
    }
    return _leftView;
}

-(UIImageView *)leftIconImageView{
    if (!_leftIconImageView) {
        _leftIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _leftIconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftIconImageView.layer.cornerRadius=5;
        _leftIconImageView.layer.masksToBounds = true;
    }
    return _leftIconImageView;
}

-(UILabel *)leftSubTitleLabel{
    if (!_leftSubTitleLabel) {
        _leftSubTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _leftSubTitleLabel.font = [UIFont systemFontOfSize:12];
        _leftSubTitleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _leftSubTitleLabel;
}

-(UILabel *)leftTitleLabel{
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _leftTitleLabel.font = [UIFont systemFontOfSize:16];
        _leftTitleLabel.textColor = UIColor.whiteColor;
    }
    return _leftTitleLabel;
}

-(UIView *)rightTopView{
    if (!_rightTopView) {
        _rightTopView = [[UIView alloc]init];
        _rightTopView.backgroundColor = [UIColor joyColorWithHEXString:@"#24CCAA"];
        _rightTopView.layer.cornerRadius = 5;
        _rightTopView.layer.masksToBounds = true;
    }
    return _rightTopView;
}


-(UIImageView *)rightTopIconImageView{
    if (!_rightTopIconImageView) {
        _rightTopIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _rightTopIconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _rightTopIconImageView.layer.cornerRadius=5;
        _rightTopIconImageView.layer.masksToBounds = true;
    }
    return _rightTopIconImageView;
}

-(UILabel *)rightTopSubTitleLabel{
    if (!_rightTopSubTitleLabel) {
        _rightTopSubTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _rightTopSubTitleLabel.font = [UIFont systemFontOfSize:12];
        _rightTopSubTitleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _rightTopSubTitleLabel;
}

-(UILabel *)rightTopTitleLabel{
    if (!_rightTopTitleLabel) {
        _rightTopTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _rightTopTitleLabel.font = [UIFont systemFontOfSize:16];
        _rightTopTitleLabel.textColor = UIColor.whiteColor;
    }
    return _rightTopTitleLabel;
}

-(UIView *)rightBottomView{
    if (!_rightBottomView) {
        _rightBottomView = [[UIView alloc]init];
        _rightBottomView.backgroundColor = [UIColor joyColorWithHEXString:@"#2AA9F7"];
        _rightBottomView.layer.cornerRadius = 5;
        _rightBottomView.layer.masksToBounds = true;
    }
    return _rightBottomView;
}

-(UIImageView *)rightBottomIconImageView{
    if (!_rightBottomIconImageView) {
        _rightBottomIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _rightBottomIconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _rightBottomIconImageView.layer.cornerRadius=5;
        _rightBottomIconImageView.layer.masksToBounds = true;
    }
    return _rightBottomIconImageView;
}

-(UILabel *)rightBottomSubTitleLabel{
    if (!_rightBottomSubTitleLabel) {
        _rightBottomSubTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _rightBottomSubTitleLabel.font = [UIFont systemFontOfSize:12];
        _rightBottomSubTitleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _rightBottomSubTitleLabel;
}

-(UILabel *)rightBottomTitleLabel{
    if (!_rightBottomTitleLabel) {
        _rightBottomTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _rightBottomTitleLabel.font = [UIFont systemFontOfSize:16];
        _rightBottomTitleLabel.textColor = UIColor.whiteColor;
    }
    return _rightBottomTitleLabel;
}

@end


@interface JoyLeftSingleRightDoubleCell ()
@property(nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation JoyLeftSingleRightDoubleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self setConstraints];
    }
    return self;
}

-(void)addSubViews{
    [self.contentView addSubview:self.collectionView];
}

-(void)setConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo((68.0/167) *(SCREEN_W-45.0) +15);
    }];
}

-(void)setCellWithModel:(JoyTableCollectionCellBaseModel *)model{
    self.collectionView.setDataSource(model.itemList).reloadCollection();
//    CGFloat height = [self.collectionView setData:model.itemList];
//    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
//    [self.contentView setNeedsLayout];
}

-(JoyCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero layout:self.flowLayout];
        _collectionView.collectionView.pagingEnabled = true;
        __weak __typeof(&*self)weakSelf = self;
        _collectionView.cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            weakSelf.collectionDidSelectBlock?weakSelf.collectionDidSelectBlock(indexPath):nil;
        });
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 15;
        _flowLayout.minimumInteritemSpacing = 3;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.estimatedItemSize = CGSizeMake((SCREEN_W-45)/2, (68.0/167) *(SCREEN_W-45.0) +15);
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.footerReferenceSize = CGSizeZero;
    }
    return _flowLayout;
}



@end
