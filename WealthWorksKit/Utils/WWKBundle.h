//
//  WWKBundle.h
//  WealthWorksKit
//
//  Created by JianLei on 16/7/6.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWKBundle : NSObject

/**
 *  应用的版本号
 */
+ (NSString *)appVersion;

/**
 *  应用的包名
 */
+ (NSString *)bundleID;

@end
