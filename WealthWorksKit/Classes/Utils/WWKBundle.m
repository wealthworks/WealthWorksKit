//
//  WWKBundle.m
//  WealthWorksKit
//
//  Created by JianLei on 16/7/6.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKBundle.h"

@implementation WWKBundle

+ (NSString *)appVersion
{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

+ (NSString *)bundleID
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)buildVersion
{
    return [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleVersionKey];
}

@end
