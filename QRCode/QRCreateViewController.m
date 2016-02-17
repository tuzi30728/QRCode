//
//  QRCreateViewController.m
//  QRCode
//
//  Created by HongXiangWen on 15/10/16.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import "QRCreateViewController.h"

@interface QRCreateViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *qr_ImageView;

@end

@implementation QRCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _qr_ImageView.image = _image;
    
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStyleBordered target:self action:@selector(moreButtonItemAction)];
    self.navigationItem.rightBarButtonItem = moreItem;
}

- (void)moreButtonItemAction
{
    
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
