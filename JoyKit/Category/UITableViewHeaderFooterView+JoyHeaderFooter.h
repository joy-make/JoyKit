//
//  UITableViewHeaderFooterView+JoyHeaderFooter.h
//  JoyKit
//
//  Created by Joymake on 2018/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//***********************传模型协议，实现***************************
@protocol JoyHeaderFooterProtocol <NSObject>                                    //|*
@optional                                                                       //|*
- (void)setHeaderFooterWithModel:(NSObject *)model isHeader:(BOOL)isHeader;     //|*
@end                                                                            //|*
//***********************传模型协议,必须实现*************************

@interface UITableViewHeaderFooterView (JoyHeaderFooter)<JoyHeaderFooterProtocol>

@property (nonatomic,copy)void (^headerViewActionBlock)(NSObject *actionObject);

@end

NS_ASSUME_NONNULL_END
