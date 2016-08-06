//
//  WWKTestViewController.m
//  WealthWorksKit
//
//  Created by JianLei on 16/8/6.
//  Copyright © 2016年 张建磊. All rights reserved.
//

#import "WWKTestViewController.h"

@interface WWKTestViewController ()<WWKURLNavigatorViewControllerProtocol>

@property (nonatomic, weak) IBOutlet UILabel *label1;
@property (nonatomic, weak) IBOutlet UILabel *label2;
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation WWKTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label1.text = self.params[@"param1"];
    self.label2.text = self.params[@"param2"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setQuery:(NSDictionary *)dic
{
    self.params = dic;
}

@end
