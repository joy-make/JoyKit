//
//  JoyImageCollectionViewCell.h
//  Toon
//
//  Created by joymake on 16/7/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JoyCollectionCellDelegate <NSObject>

@optional;
- (void)cellDidSelectWithIndexPath:(NSIndexPath *)indexPath action:(NSString *)action;

@required;
- (void)setCellWithModel:(NSObject *)cellModel;

@end

@interface JoyCollectionBaseCell :UICollectionViewCell<JoyCollectionCellDelegate>;
@property (nonatomic,weak)id <JoyCollectionCellDelegate>delegate;
@property (nonatomic,weak)NSIndexPath *indexPath;
@end

/**
 collectioncell
 */
@interface JoyImageCollectionViewCell : UICollectionViewCell
- (void)setCellWithModel:(NSObject *)cellModel;
@end
