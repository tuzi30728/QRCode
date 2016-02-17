//
//  QRResultViewController.m
//  QRCode
//
//  Created by HongXiangWen on 15/10/16.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import "QRResultViewController.h"
#import "QRCreateViewController.h"
#import "HXCodeGenerator.h"

@interface QRResultViewController () <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *resultWebView;
@property (nonatomic,strong) UILabel *resultLabel;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation QRResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"更多"] style:UIBarButtonItemStyleBordered target:self action:@selector(moreButtonItemAction)];
    self.navigationItem.rightBarButtonItem = moreItem;
    
    NSString *urlStr = [self checkResultUrl];
    _resultWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _resultWebView.backgroundColor = [UIColor clearColor];
    _resultWebView.delegate = self;
    [self.view addSubview: _resultWebView];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_resultWebView loadRequest:request];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    _activityIndicatorView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2 - 64);
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:_activityIndicatorView];
    [_activityIndicatorView startAnimating];
}

- (NSString *)checkResultUrl
{
    if ([_qr_result containsString:@"https://"] || [_qr_result containsString:@"http://"]) {
        return _qr_result;
    } else {
        NSString *str = [NSString stringWithFormat:@"http://%@",_qr_result];
        return str;
    }
}

#pragma mark -- UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (!_resultLabel) {
        UIFont *font = [UIFont boldSystemFontOfSize:15];
        CGFloat height = [_qr_result sizeWithFont:font maxSize:CGSizeMake(kScreenWidth - 30, NSIntegerMax)].height;
        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, height)];
        _resultLabel.text = _qr_result;
        _resultLabel.font = font;
        _resultLabel.textColor = [UIColor blackColor];
        [_resultWebView.scrollView addSubview:_resultLabel];
    }
    [_activityIndicatorView stopAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (_resultLabel) {
        _resultLabel.hidden = YES;
    }
    [_activityIndicatorView stopAnimating];
}

- (void)moreButtonItemAction
{
    [self performSegueWithIdentifier:@"pushToQRCreateVCFromQRResultVC" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QRCreateViewController *createVC = segue.destinationViewController;
    UIImage *image = [HXCodeGenerator qrTwoCodeImageForString:_qr_result imageSize:250];
    createVC.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
