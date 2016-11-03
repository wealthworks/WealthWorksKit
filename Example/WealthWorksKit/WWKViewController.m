//
//  WWKViewController.m
//  WealthWorksKit
//
//  Created by 张建磊 on 08/06/2016.
//  Copyright (c) 2016 张建磊. All rights reserved.
//

#import "WWKViewController.h"
#import "WWKTestNavigationDefine.h"
#import <WealthWorksKit/WWKTrackKit.h>
#import <WealthWorksKit/WWKNetworkReachability.h>
#import "UIApplication+UINavigationController.h"

@interface WWKViewController ()

@end

@implementation WWKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self testCommonService];
    
//    [WWKNetworkReachability alertIfNetworkNotConnect];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"已为“基金豆”关闭网络"
                                                                             message:@"您可以在“设置”中为此应用打开无线局域网。"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    UIViewController *currentViewController = [UIApplication sharedApplication].currentTopViewController;
    [currentViewController presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)jumpToOtherController:(id)sender {
    WWKURLNavigatorAction *action = [WWKURLNavigatorAction actionWithURLPath:kWWKTestViewController];
    
    NSDictionary *params = @{@"param1" : @"123", @"param2" : @"abc"};
    [action applyQuery:params];

    [[WWKURLNavigator navigator] openURLAction:action];
}

- (IBAction)modelViewController:(id)sender {
    WWKURLNavigatorAction *action = [WWKURLNavigatorAction actionWithURLPath:kTestModelViewController];
    
    [[WWKURLNavigator navigator] openURLAction:action];
}

- (void)testCommonService
{
//    [[WWKTrackKit shareInstance] checkAppUpdateWithSuccess:^(WWKAppUpdateInfo *appUpdateInfo) {
//        
//    }];
    
    
    [WWKTrackKit startWithAppKey:WWKAppKeyTimi];
    
    [[WWKTrackKit shareInstance] userDidActivate:nil];
    
    [[WWKTrackKit shareInstance] userDidLoginWithUserId:@"1000"];
    [[WWKTrackKit shareInstance] userDidRegistWithUserId:@"1000"];
    [[WWKTrackKit shareInstance] userDidLogoutWithUserId:@"1000"];
    
    [[WWKTrackKit shareInstance] userDidPurchase:@"1000" product:@"1" shares:10000 cost:2000 status:1];
    [[WWKTrackKit shareInstance] userDidRedeem:@"1000" product:@"1" shares:10000 cost:2000 status:1];


    
    
}

@end
