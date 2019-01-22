//
//  UICollectionReusableView+JoyHeaderFooter.h
//  JoyKit
//
//  Created by Joymake on 2019/1/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//***********************传模型协议，实现***************************
@protocol JoyCollectionHeaderFooterProtocol <NSObject>                                    //|*
@optional                                                                       //|*
- (void)setHeaderFooterWithModel:(NSObject *)model isHeader:(BOOL)isHeader;     //|*
@end                                                                            //|*
//***********************传模型协议,必须实现*************************

@interface UICollectionReusableView (JoyHeaderFooter)
@property (nonatomic,copy)void (^headerViewActionBlock)(NSObject *actionObject);

@end

NS_ASSUME_NONNULL_END
