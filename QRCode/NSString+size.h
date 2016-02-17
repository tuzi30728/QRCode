//
//  NSString+size.h
//  QRCode
//
//  Created by HongXiangWen on 15/10/16.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (size)

/**
 *  计算字符串的size
 *
 *  @param font    字符串的字体
 *  @param maxSize 字符串的最大size
 *
 *  @return 计算出的size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
