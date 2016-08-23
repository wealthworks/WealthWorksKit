//
//  WWKTestModelViewController.m
//  WealthWorksKit
//
//  Created by JiaLei on 8/23/16.
//  Copyright © 2016 张建磊. All rights reserved.
//

#import "WWKTestModelViewController.h"

@implementation WWKTestModelViewController

#pragma mark - INIT
- (instancetype)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    if (self = [super init]) {
    }
    
    return self;
}

#pragma mark - VIEW
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    label.text = @"这是个model Viewcontroller";
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor redColor];
    
    [self.view addSubview:label];
    
    CGRect frame = CGRectMake(100, 400, 200, 50);
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = frame;
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeButton];
    [closeButton sizeToFit];
}

- (void)closeAction
{
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}

@end
