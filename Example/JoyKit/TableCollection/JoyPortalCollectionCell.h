//
//  JoyPortalCollectionCell.h
//  Home
//
//  Created by joy on 2021/8/10.
//

#import "JoyImageCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JoyPortalCollectionCell : JoyCollectionBaseCell

@end

//一行单列背景滚动图210:345
@interface JoySigleCollectionCell : JoyCollectionBaseCell

@end

//一行单列高度较小背景滚动图140:385
@interface JoySigleMiniCollectionCell : JoySigleCollectionCell

@end


//一行四列上图下标题-图片1:1
@interface JoyQuadraCollectionCell : JoyCollectionBaseCell

@end

//一行五列上图下标题-图片1:1
@interface JoyPentalCollectionCell : JoyQuadraCollectionCell

@end

//一行三列背景图加标题-图片80:105
@interface JoyTripleCollectionCell : JoyQuadraCollectionCell

@end

//一行两列上图下标题-图片108:156
@interface JoyDoubleCollectionCell : JoyCollectionBaseCell

@end

//一行两列左上下标题右icon-图片1:1
@interface JoyDoubleTitleRightIconlCollectionCell : JoyCollectionBaseCell

@end

//一行两列左icon右上下标题-图片1:1
@interface JoyLeftIconRightDoubleTitleCollectionCell : JoyCollectionBaseCell

@end

//上图片中标题下副标题
@interface JoyTopIconTitleSubTitleCollectionCell : JoyCollectionBaseCell

@end

//通知消息
@interface JoyNoticesCollectionCell : JoyCollectionBaseCell

@end


NS_ASSUME_NONNULL_END
