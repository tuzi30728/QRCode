//
//  AppDelegate.m
//  QRCode
//
//  Created by HongXiangWen on 15/10/15.
//  Copyright © 2015年 HongXiangWen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //修改导航条
    UINavigationBar *barAppearance = [UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil];
    NSDictionary *barTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                        NSForegroundColorAttributeName: [UIColor blackColor]};
    [barAppearance setTitleTextAttributes:barTextAttributes];
    [barAppearance setTintColor:THEME_COLOR];
    
    //修改导航条上的UIBarButtonItem
    UIBarButtonItem *itemAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    NSDictionary *itemTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17],
                                     NSForegroundColorAttributeName: THEME_COLOR,};
    
    [itemAppearance setTitleTextAttributes:itemTextAttributes forState:UIControlStateNormal];
    [itemAppearance setTintColor:THEME_COLOR];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:THEME_COLOR];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
