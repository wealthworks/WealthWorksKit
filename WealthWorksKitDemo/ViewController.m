//
//  ViewController.m
//  WealthWorksKitDemo
//
//  Created by JianLei on 16/7/8.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "ViewController.h"
#import <WealthWorksKit/WealthWorksKit.h>
#import "ViewController.h"
#import "WWKURLNavigator.h"
#import "TestNavigator/TestNavigator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // DEMO
    [WWKCommonService sendUserMetaDataWithSite:WWKCommonServiceUserMetaDataSiteGuihua];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jumpToOtherController:(id)sender {
    WWKURLNavigatorAction *action = [WWKURLNavigatorAction actionWithURLPath:kTestViewController];
    
    NSDictionary *params = @{@"param1" : @"123", @"param2" : @"abc"};
    [action applyQuery:params];
    
    [[WWKURLNavigator navigator] openURLAction:action];
}

@end
