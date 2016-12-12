//
//  WWKBundle.m
//  WealthWorksKit
//
//  Created by JianLei on 16/7/6.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKBundle.h"
#import "WWKDevice.h"
#import "AFNetworkReachabilityManager.h"

#define WWKAppChannel                    @"AppStore"

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

+ (NSString *)jpushVersionForDebug:(BOOL)debug
{
    NSString *tag = [[self appVersion] stringByReplacingOccurrencesOfString:@"." withString:@"_"];
    if (debug) {
        tag = [tag stringByAppendingString:@"_test"];
    }
    return tag;
}

+ (NSString *)clientInfo {
    NSMutableString *str = [NSMutableString stringWithString:WWKAppChannel];
    [str appendString:@"|iOS"];
    [str appendFormat:@"|%@",[[self class] appVersion]];
    [str appendFormat:@"|%@",[WWKDevice uuid]];
    [str appendFormat:@"|%@",[UIDevice currentDevice].model];
    [str appendFormat:@"|%@",[UIDevice currentDevice].systemVersion];
    
    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
            [str appendString:@"|WiFi"];
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            [str appendString:@"|3G"];
            break;
        default:
            [str appendString:@"|unknow"];
            break;
    }
    
    [str appendFormat:@"|%@",[WWKDevice IDFA]];
    [str appendFormat:@"|%@",[WWKDevice identifier]];
    [str appendFormat:@"|%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsDeviceToken]];
    
    return str;
}

+ (void)clientInfo:(void (^)(NSString *clientInfo))complete {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSMutableString *str = [NSMutableString stringWithString:WWKAppChannel];
        [str appendString:@"|iOS"];
        [str appendFormat:@"|%@",[[self class] appVersion]];
        [str appendFormat:@"|%@",[WWKDevice uuid]];
        [str appendFormat:@"|%@",[UIDevice currentDevice].model];
        [str appendFormat:@"|%@",[UIDevice currentDevice].systemVersion];
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [str appendString:@"|WiFi"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [str appendString:@"|3G"];
                break;
            default:
                [str appendString:@"|unknow"];
                break;
        }
        
        [str appendFormat:@"|%@",[WWKDevice IDFA]];
        [str appendFormat:@"|%@",[WWKDevice identifier]];
        [str appendFormat:@"|%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsDeviceToken]];
        
        complete(str);
    }];
}

@end
