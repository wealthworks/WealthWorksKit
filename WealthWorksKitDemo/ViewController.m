//
//  ViewController.m
//  WealthWorksKitDemo
//
//  Created by JianLei on 16/7/8.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "ViewController.h"
#import <WealthWorksKit/WealthWorksKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // DEMO
    NSLog(@"%@", [WWKDevice openUDID]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
