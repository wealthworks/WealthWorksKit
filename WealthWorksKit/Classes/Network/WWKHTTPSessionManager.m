//
//  WWKHTTPSessionManager.m
//  WealthWorksKit
//
//  Created by JianLei on 16/8/1.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKHTTPSessionManager.h"

static NSString * const kWWKBaseURL = @"http://c.lcgc.pub/";

@implementation WWKHTTPSessionManager

+ (instancetype)wwk_manager
{
    return [self wwk_managerWithBaseURL:kWWKBaseURL];
}

+ (instancetype)wwk_managerWithBaseURL:(NSString *)baseURL
{
    NSURL *URL = [NSURL URLWithString:baseURL];
    WWKHTTPSessionManager *manager = [[self alloc] initWithBaseURL:URL];
    return manager;
}

@end
