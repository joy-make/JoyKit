//
//  UIImageView+JoyCategory.m
//  Toon
//
//  Created by joymake on 2017/2/28.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import "UIImageView+JoyCategory.h"
#if __has_include ("UIImageView+WebCache.h")
#import "UIImageView+WebCache.h"
#endif

@implementation UIImageView (JoyCategory)

/**
 *  设置图片
 */
- (void)joySetImageWithUrlString:(NSString *)urlString
{
    [self joySetImageWithUrlString:urlString placeholderImage:nil];
}

/**
 *  设置图片(placeholder)
 */
- (void)joySetImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholder
{
    [self joySetImageWithUrlString:urlString placeholderImage:placeholder completed:nil];
}

/**
 *  设置图片(完成回调)
 */
- (void)joySetImageWithUrlString:(NSString *)urlString completed:(completionBlock)completedBlock
{
    [self joySetImageWithUrlString:urlString placeholderImage:nil completed:completedBlock];
}

/**
 *  设置图片(placeholder+完成回调)
 */
- (void)joySetImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholder completed:(completionBlock)completedBlock
{
#if __has_include ("UIImageView+WebCache.h")
    [self sd_setImageWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:placeholder options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock)
        {
            completedBlock(image, error);
        }
    }];
#else
    self.image = placeholder;
#endif
}
@end
