//
//  JJDNavigator.m
//  Fund
//
//  Created by JiaLei on 6/20/16.
//  Copyright © 2016 WealthWork. All rights reserved.
//

#import "TestNavigator.h"
#import "WWKURLNavigator.h"
#import "UIApplication+UINavigationController.h"
#import "NSString+Compare.h"
#import "TestViewController.h"

static NSString *const kServerUrlNeedLoginKey = @"needlogin=1";

@interface TestNavigator()

@end

@implementation TestNavigator

#pragma mark - 本地页面注册

+ (instancetype)navigator {
    static TestNavigator *sharedNavigator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNavigator = [[TestNavigator alloc] init];
    });
    
    return sharedNavigator;
}

+ (void)setup {
    [[WWKURLNavigator navigator].urlNavigatorMap from:kTestViewController
                                     toViewController:[TestViewController class]
                                      stoaryboardName:@"Main"];
    
}


@end
