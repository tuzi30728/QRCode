//
//  HXBaseCodeViewController.h
//  二维码
//
//  Created by HongXiangWen on 15/11/20.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol HXBaseCodeViewControllerDelegate <NSObject>

- (void)readCodeSuccessWithResultString:(NSString *)string;

@end

@interface HXBaseCodeViewController : UIViewController

@property (nonatomic,assign) id<HXBaseCodeViewControllerDelegate> delegate;

/**
 *  释放资源
 */
- (void)releaseCapture;

/**
 *  处理扫描结果，子类可复写此方法
 *
 *  @param string 扫描结果
 */
- (void)handleResultWithResultString:(NSString *)string;

@end
