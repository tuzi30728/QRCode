//
//  QREditViewController.m
//  QRCode
//
//  Created by HongXiangWen on 15/10/16.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import "QREditViewController.h"
#import "QRCreateViewController.h"
#import "HXCodeGenerator.h"

@interface QREditViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@end

@implementation QREditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (IBAction)createQRCodeButtonAction:(id)sender {
    if (_textView.text.length > 0) {
        [self performSegueWithIdentifier:@"pushToQRCreateVCFromEditVC" sender:nil];
        
    } else {
        [SVProgressHUD showInfoWithStatus:@"请输入文字"];
    }
}

#pragma mark -- UItextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placeLabel.hidden = NO;
    } else {
        _placeLabel.hidden = YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToQRCreateVCFromEditVC"]) {
        QRCreateViewController *createVC = segue.destinationViewController;
        UIImage *result1 = [HXCodeGenerator qrTwoCodeImageForString:_textView.text];
        UIImage *result2 = [HXCodeGenerator qrTwoCodeImageForString:_textView.text imageSize:300];
        UIImage *result3 = [HXCodeGenerator qrTwoCodeImageForString:_textView.text imageSize:300 withIconImage:[UIImage imageNamed:@"公司logo"]];
        UIImage *result4 = [HXCodeGenerator qrTwoCodeImageForString:_textView.text imageSize:300 withIconImage:[UIImage imageNamed:@"公司logo"] withColor:THEME_COLOR];
        UIImage *result5 = [HXCodeGenerator qrTwoCodeImage:[HXCodeGenerator qrTwoCodeImageForString:_textView.text] withIconImage:[UIImage imageNamed:@"爱心"] withColor:THEME_COLOR];
        UIImage *result6 = [HXCodeGenerator qrTwoCodeImage:[HXCodeGenerator qrTwoCodeImageForString:_textView.text] withIconImage:[UIImage imageNamed:@"爱心"]];
        createVC.image = result6;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
