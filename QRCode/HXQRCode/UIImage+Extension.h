//
//  UIImage+Extension.h
//  QRCode
//
//  Created by HongXiangWen on 15/11/21.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (Extension)

/**
 *  改变图片颜色
 *
 *  @param color 颜色
 *
 *  @return 生成的图片
 */
- (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  给图片生成圆角
 *
 *  @param radius 圆角数值
 *  @param width  白边宽度
 *
 *  @return 生成的图片
 */
- (UIImage *)makeRoundedRadius:(CGFloat)radius whiteEdge:(CGFloat)width;

@end
