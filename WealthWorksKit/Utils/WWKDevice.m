//
//  WWKDevice.m
//  WealthWorksKit
//
//  Created by JianLei on 16/7/6.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKDevice.h"
#import <AdSupport/AdSupport.h>
#import <OpenUDID/OpenUDID.h>

@implementation WWKDevice

+ (NSString *)IDFA
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)openUDID
{
    return [OpenUDID value];
}

+ (NSString *)model
{
    return [UIDevice currentDevice].model;
}

+ (NSString *)systemName
{
    return [UIDevice currentDevice].systemName;
}

+ (NSString *)systemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

@end
