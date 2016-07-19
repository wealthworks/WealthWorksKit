//
//  WWKDevice.h
//  WealthWorksKit
//
//  Created by JianLei on 16/7/6.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWKDevice : NSObject

/**
 *  广告标示符
 */
+ (NSString *)IDFA NS_AVAILABLE_IOS(6_0);

/**
 *  FCUUID
 */
+ (NSString *)uuid;

/**
 *  设备类型
 *  e.g. @"iPhone", @"iPod touch"
 */
+ (NSString *)model;

/**
 *  系统名称
 *  e.g. @"iOS"
 */
+ (NSString *)systemName;

/**
 *  系统版本号
 *  e.g. @"4.0"
 */
+ (NSString *)systemVersion;

/**
 *  设备全部IP地址信息
 */
+ (NSDictionary *)IPAddresses;

/**
 *  设备IP地址信息
 *  WIFI(ipv6) > WIFI(ipv4) > CELLULAR(ipv6) > CELLULAR(ipv4)
 */
+ (NSString *)IPAddress;

@end
