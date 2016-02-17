//
//  HXBaseCodeViewController.m
//  二维码
//
//  Created by HongXiangWen on 15/11/20.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import "HXBaseCodeViewController.h"

@interface HXBaseCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) UIImageView *scanImageView;
@property (strong, nonatomic) UIImageView *scanLine;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation HXBaseCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startReading];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopReading];
}

- (void)startReading
{
    if (_captureSession) {
        [_timer setFireDate:[NSDate date]];
        [_captureSession startRunning];
    }
}

- (void)stopReading
{
    if (_captureSession) {
        [_captureSession stopRunning];
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCodeView];
}

- (void)setupCodeView
{
    NSError *error;
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机不支持，请设置." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    //4.1.将输入流添加到会话
    [_captureSession addInput:input];
    //4.2.将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //5.2.设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:self.view.layer.bounds];
    //9.将图层添加到预览view的图层上
    [self.view.layer addSublayer:_videoPreviewLayer];
    // 计算y的系数
    CGFloat ratioY = 0.66 * kScreenWidth / kScreenHeight;
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake((1-ratioY)/2, 0.17 , ratioY, 0.66);
    //    //_output setRectOfInterest : CGRectMake (( 124 )/ ScreenHigh ,(( ScreenWidth - 220 )/ 2 )/ ScreenWidth , 220 / ScreenHigh , 220 / ScreenWidth )
    //    //10.1.扫描框
    _scanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.17f, self.view.bounds.size.height * (1-ratioY)/2, self.view.bounds.size.width - self.view.bounds.size.width * 0.34f, self.view.bounds.size.height - self.view.bounds.size.height * (1-ratioY))];
    _scanImageView.image = [UIImage imageNamed:@"扫描框"];
    [self.view addSubview:_scanImageView];
    //10.2.扫描线
    _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, _scanImageView.bounds.size.width, 3)];
    _scanLine.image = [UIImage imageNamed:@"扫描线"];
    [_scanImageView addSubview:_scanLine];
    
    [self addMaskViewWithRect:_scanImageView.frame];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveScanLine) userInfo:nil repeats:YES];
}

- (void)addMaskViewWithRect:(CGRect)scanMaskRect
{
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,scanMaskRect.origin.y)];
    upView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.view addSubview:upView];
    
    //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.frame.size.height,scanMaskRect.origin.x, scanMaskRect.size.height)];
    leftView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.view addSubview:leftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(scanMaskRect.size.width+scanMaskRect.origin.x, upView.frame.size.height, scanMaskRect.origin.x, scanMaskRect.size.height)];
    rightView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.view addSubview:rightView];
    
    //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rightView.frame), kScreenWidth,kScreenHeight-CGRectGetMaxY(rightView.frame))];
    downView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.view addSubview:downView];
    
    //用于说明的label
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame = CGRectMake(0, 0, kScreenWidth * 0.66 - 40, 40);
    labIntroudction.center = CGPointMake(kScreenWidth/2, 30);
    labIntroudction.textColor = [UIColor whiteColor];
    labIntroudction.font = [UIFont systemFontOfSize:15];
    labIntroudction.text = @"请将二维码放入扫描框内，即可自动扫描";
    labIntroudction.numberOfLines = 0;
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    [downView addSubview:labIntroudction];
}

- (void)moveScanLine
{
    CGRect frame = _scanLine.frame;
    if (frame.origin.y > _scanImageView.frame.size.height - 15) {
        frame.origin.y = 0;
        _scanLine.frame = frame;
    }else{
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLine.frame = frame;
        }];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self handleResultWithResultString:[metadataObj stringValue]];
        }
    }
}

- (void)handleResultWithResultString:(NSString *)string
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(readCodeSuccessWithResultString:)]) {
        [self.delegate readCodeSuccessWithResultString:string];
    }
    [self releaseCapture];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)releaseCapture
{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
