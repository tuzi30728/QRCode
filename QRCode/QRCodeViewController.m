//
//  QRCodeViewController.m
//  QRCode
//
//  Created by HongXiangWen on 15/10/15.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRResultViewController.h"

@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
}

- (IBAction)backButtonAction:(id)sender {
    [self releaseCapture];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleResultWithResultString:(NSString *)string
{
    [self performSegueWithIdentifier:@"pushToScenResultVC" sender:string];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QRResultViewController *resultVC = segue.destinationViewController;
    resultVC.qr_result = (NSString *)sender;
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
