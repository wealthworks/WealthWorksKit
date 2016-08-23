//
//  WWKTestNavigator.m
//  WealthWorksKit
//
//  Created by JianLei on 16/8/6.
//  Copyright © 2016年 张建磊. All rights reserved.
//

#import "WWKTestNavigator.h"
#import "WWKTestViewController.h"
#import "WWKTestModelViewController.h"
#import "WWKTestNavigationDefine.h"

static NSString *const kServerUrlNeedLoginKey = @"needlogin=1";

@implementation WWKTestNavigator

#pragma mark - 本地页面注册

+ (instancetype)navigator {
    static WWKTestNavigator *sharedNavigator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNavigator = [[WWKTestNavigator alloc] init];
    });
    
    return sharedNavigator;
}

+ (void)setup {
    [[WWKURLNavigator navigator].urlNavigatorMap from:kWWKTestViewController
                                     toViewController:[WWKTestViewController class]
                                      stoaryboardName:@"Main"];
    
    [[WWKURLNavigator navigator].urlNavigatorMap from:kTestModelViewController
                                toModelViewController:[WWKTestModelViewController class]];

}

@end
