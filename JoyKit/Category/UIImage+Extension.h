//
//  UIImage+Extension.h
//  LW
//
//  Created by Joymake on 2016/11/9.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SAVEIMAGEBLOCK)(void);

FOUNDATION_EXPORT double ImageEffectsVersionNumber;
FOUNDATION_EXPORT const unsigned char ImageEffectsVersionString[];

@interface UIImage (Extension)
- (UIImage *)lightImage;

- (UIImage *)extraLightImage;

- (UIImage *)darkImage;

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)blurredImageWithRadius:(CGFloat)blurRadius;
- (UIImage *)blurredImageWithSize:(CGSize)blurSize;
- (UIImage *)blurredImageWithSize:(CGSize)blurSize
                        tintColor:(UIColor *)tintColor
            saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                        maskImage:(UIImage *)maskImage;
- (UIImage *)screenShot;


+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

//按宽度等比例缩放
- (UIImage *)scaleToWidth:(CGFloat)width;

//按高度等比例缩放
- (UIImage *)scaleToHeight:(CGFloat)height;

#pragma markUIBezierPath 裁剪
+ (UIImage *)UIBezierPathClip:(UIImage *)img cornerRadius:(CGFloat)c;

#pragma mark 按指定大小压缩图片质量
-(NSData *)compressToMaxLength:(NSUInteger)maxLength;

//颜色转换图片
+(UIImage*)imageWithColor:(UIColor*)color;

//条形码
+ (UIImage *)barCodeImageWithBarStr:(NSString *)barStr;
/**
 二维码
 @param qrStr 二维码字符串
 @param imageName 中间的logo
 @return 二维码图片
 */
+(UIImage *)logoQrCodeWithStr:(NSString *)qrStr image:(NSString *)imageName;

/**
 view转换图片
 @param view 待转换view
 @return 返回转后的image
 */
+(UIImage *)snapshotSingleView:(UIView *)view;

//存相册
- (void)saveToPhotos:(SAVEIMAGEBLOCK)successed;
@end
