//
//  WWKBundle.h
//  WealthWorksKit
//
//  Created by JianLei on 16/7/6.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserDefaultsDeviceToken   @"kUserDefaultsDeviceToken"

@interface WWKBundle : NSObject

/**
 *  应用的版本号
 */
+ (NSString *)appVersion;

/**
 *  应用的包名
 */
+ (NSString *)bundleID;

/**
 *  编译版本号（git提交号）
 */
+ (NSString *)buildVersion;

/**
 *  极光推送设置tag （1_1_0）
 */
+ (NSString *)jpushVersionForDebug:(BOOL)debug;

/**
 *  获取clientInfo，外部已知AFNetworkReachabilityManager的网络状态。
 */
+ (NSString *)clientInfo;

/**
 *  获取clientInfo，在AFNetworkReachabilityManager异步获取网络状态后返回，并且再网络状态更新后可重新获取clientInfo
 */
+ (void)clientInfo:(void (^)(NSString *clientInfo))complete;

@end
