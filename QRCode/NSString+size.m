//
//  NSString+size.m
//  QRCode
//
//  Created by HongXiangWen on 15/10/16.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import "NSString+size.h"

@implementation NSString (size)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
