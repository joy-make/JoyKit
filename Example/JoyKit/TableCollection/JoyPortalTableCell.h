//
//  JoyTableCell.h
//  Home
//
//  Created by joy on 2021/8/10.
//

#import <UIKit/UIKit.h>
#import <JoyKit/JoyKit.h>
#import <JoyKit/UITableViewCell+JoyCell.h>
NS_ASSUME_NONNULL_BEGIN

@interface JoyPortalTableCell : UITableViewCell

@end

//单行单列（党群扶贫,爱心助农）
@interface JoySigleTableCell : UITableViewCell

@end

//单行单列高度较低
@interface JoySigleMiniTableCell : UITableViewCell

@end

//单行两列高度
@interface JoyDoubleTableCell : UITableViewCell

@end

//单行两列高度
@interface JoyDoubleNormalTableCell : UITableViewCell

@end

//多行四列的
@interface JoyQuadraTableCell : UITableViewCell

@end

//多行五列的
@interface JoyPentaTableCell : JoyQuadraTableCell

@end

//多行三列(入党指南、提交材料、申请消息)
@interface JoyTripleTableCell : UITableViewCell

@end

//左标题右副标题(如党内要闻--更多)
@interface JoyListMoreCell : UITableViewCell

@end

//新闻列表
@interface JoyListCell : UITableViewCell

@end

//左小图片右title(头条)通知
@interface JoyLeftImageRightCollectionTableCell : UITableViewCell

@end

//左一右二
@interface JoySingleDoubleCell : UITableViewCell

@end

@interface JoyLeftSingleRightDoubleCell : UITableViewCell

@end



NS_ASSUME_NONNULL_END
