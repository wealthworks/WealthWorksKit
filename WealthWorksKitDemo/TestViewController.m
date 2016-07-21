//
//  TestViewController.m
//  WealthWorksKit
//
//  Created by JiaLei on 7/20/16.
//  Copyright © 2016 WealthWorks. All rights reserved.
//

#import "TestViewController.h"
#import "TestNavigator/TestNavigator.h"
#import <WealthWorksKit/WealthWorksKit.h>

@interface TestViewController ()<WWKURLNavigatorViewControllerProtocol>

@property (nonatomic, weak) IBOutlet UILabel *label1;
@property (nonatomic, weak) IBOutlet UILabel *label2;
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label1.text = self.params[@"param1"];
    self.label2.text = self.params[@"param2"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setQuery:(NSDictionary *)dic {
    self.params = dic;
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
