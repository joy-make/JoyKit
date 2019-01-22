//
//  JoyCollectionReusableView.h
//  JoyKit_Example
//
//  Created by Joymake on 2019/1/21.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UICollectionReusableView+JoyHeaderFooter.h>

NS_ASSUME_NONNULL_BEGIN

@interface JoyCollectionReusableView : UICollectionReusableView<JoyCollectionHeaderFooterProtocol>
@property (nonatomic,strong)UILabel *textLabel;

@end

NS_ASSUME_NONNULL_END
