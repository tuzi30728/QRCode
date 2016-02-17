//
//  HXCodeGenerator.m
//  二维码
//
//  Created by HongXiangWen on 15/11/20.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import "HXCodeGenerator.h"
#import "qrencode.h"
#import "UIImage+Extension.h"

enum {
    qr_margin = 3
};

@implementation HXCodeGenerator

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size
{
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
    
    // draw
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
    for(int i = 0; i < width; ++i) {
        for(int j = 0; j < width; ++j) {
            if(*data & 1) {
                rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}

+ (UIImage *)qrTwoCodeImageForString:(NSString *)string imageSize:(CGFloat)size
{
    if (![string length]) {
        return nil;
    }
    
    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_H, QR_MODE_8, 1);
    if (!code) {
        return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    // draw QR on this context
    [HXCodeGenerator drawQRCode:code context:ctx size:size];
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
}

+ (UIImage *)qrTwoCodeImageForString:(NSString *)string
{
    return [self qrTwoCodeImageForString:string imageSize:300];
}

+ (UIImage *)qrTwoCodeImage:(UIImage *)twoCodeImage withIconImage:(UIImage *)iconImage
{
    if (!twoCodeImage) {
        return nil;
    }
    
    CGSize size = twoCodeImage.size;
    CGSize size2 = CGSizeMake(1.0 / 6 * size.width, 1.0 / 6 * size.height);
    
    UIImage *newIconImage = [iconImage makeRoundedRadius:iconImage.size.width/5 whiteEdge:iconImage.size.width/size2.width * 2];

    UIGraphicsBeginImageContext(size);
    
    [twoCodeImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [newIconImage drawInRect:CGRectMake((size.width - size2.width) / 2.0, (size.height - size2.height) / 2.0, size2.width, size2.height)];
    
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)qrTwoCodeImage:(UIImage *)twoCodeImage withIconImage:(UIImage *)iconImage withColor:(UIColor *)color
{
    UIImage *image = [twoCodeImage imageWithColor:color];
    return [self qrTwoCodeImage:image withIconImage:iconImage];
}

+ (UIImage *)qrTwoCodeImageForString:(NSString *)string imageSize:(CGFloat)size withIconImage:(UIImage *)iconImage
{
    return [self qrTwoCodeImage:[self qrTwoCodeImageForString:string imageSize:size] withIconImage:iconImage];
}

+ (UIImage *)qrTwoCodeImageForString:(NSString *)string imageSize:(CGFloat)size withIconImage:(UIImage *)iconImage withColor:(UIColor *)color
{
    UIImage *image = [[self qrTwoCodeImageForString:string imageSize:size] imageWithColor:color];
    return [self qrTwoCodeImage:image withIconImage:iconImage];
}

@end
