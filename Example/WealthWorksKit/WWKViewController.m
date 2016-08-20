//
//  WWKViewController.m
//  WealthWorksKit
//
//  Created by 张建磊 on 08/06/2016.
//  Copyright (c) 2016 张建磊. All rights reserved.
//

#import "WWKViewController.h"
#import "WWKTestNavigationDefine.h"

@import WealthWorksKit;

@interface WWKViewController ()

@end

@implementation WWKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self testCommonService];
}

- (IBAction)jumpToOtherController:(id)sender {
//    WWKURLNavigatorAction *action = [WWKURLNavigatorAction actionWithURLPath:kWWKTestViewController];
//    
//    NSDictionary *params = @{@"param1" : @"123", @"param2" : @"abc"};
//    [action applyQuery:params];
//    
//    [[WWKURLNavigator navigator] openURLAction:action];
}

- (void)testCommonService
{
//    [[WWKTrackKit shareInstance] checkAppUpdateWithSuccess:^(WWKAppUpdateInfo *appUpdateInfo) {
//        
//    }];
    
    
    [WWKTrackKit startWithAppKey:WWKAppKeyTimi];
    
    [[WWKTrackKit shareInstance] userDidActivate];
    
    [[WWKTrackKit shareInstance] userDidLoginWithUserId:@"1000"];
    [[WWKTrackKit shareInstance] userDidRegistWithUserId:@"1000"];
    [[WWKTrackKit shareInstance] userDidLogoutWithUserId:@"1000"];
    
    [[WWKTrackKit shareInstance] userDidPurchase:@"1000" product:@"1" shares:10000 cost:2000 status:1];
    [[WWKTrackKit shareInstance] userDidRedeem:@"1000" product:@"1" shares:10000 cost:2000 status:1];


    
    
}

@end
