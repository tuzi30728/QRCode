//
//  HXCodeGenerator.h
//  二维码
//
//  Created by HongXiangWen on 15/11/20.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HXCodeGenerator : NSObject


/**
 *  生成不带icon的二维码图片
 *
 *  @param string 二维码内容
 *
 *  @return 二维码原始图片
 */
+ (UIImage *)qrTwoCodeImageForString:(NSString *)string;

/**
 *  生成不带icon的二维码图片
 *
 *  @param string 二维码内容
 *  @param size   二维码大小
 *
 *  @return 二维码原始图片
 */
+ (UIImage *)qrTwoCodeImageForString:(NSString *)string imageSize:(CGFloat)size;

/**
 *  生成带icon二维码图片
 *
 *  @param twoCodeImage 不带icon的二维码原始图片
 *  @param iconImage    icon图片
 *
 *  @return 带icon二维码图片
 */
+ (UIImage *)qrTwoCodeImage:(UIImage *)twoCodeImage withIconImage:(UIImage *)iconImage;

/**
 *  生成带icon且自定义颜色的二维码图片
 *
 *  @param twoCodeImage 不带icon的二维码原始图片
 *  @param iconImage    icon图片
 *  @param color        二维码颜色
 *
 *  @return 带icon且自定义颜色的二维码图片
 */
+ (UIImage *)qrTwoCodeImage:(UIImage *)twoCodeImage withIconImage:(UIImage *)iconImage withColor:(UIColor *)color;

/**
 *  生成带icon的二维码图片
 *
 *  @param string    二维码内容
 *  @param size      二维码大小
 *  @param iconImage icon图片
 *
 *  @return 带icon的二维码图片
 */
+ (UIImage *)qrTwoCodeImageForString:(NSString *)string imageSize:(CGFloat)size withIconImage:(UIImage *)iconImage;

/**
 *  生成带icon且自定义颜色的二维码图片
 *
 *  @param string    二维码内容
 *  @param size      二维码大小
 *  @param iconImage icon图片
 *  @param color     二维码颜色
 *
 *  @return 带icon且自定义颜色的二维码图片
 */
+ (UIImage *)qrTwoCodeImageForString:(NSString *)string imageSize:(CGFloat)size withIconImage:(UIImage *)iconImage withColor:(UIColor *)color;


@end
