//
//  WWKDevice.h
//  WealthWorksKit
//
//  Created by JianLei on 16/7/6.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWKDevice : NSObject

/**
 *  广告标示符
 */
+ (NSString *)IDFA NS_AVAILABLE_IOS(6_0);

/**
 *  OpenUDID
 */
+ (NSString *)openUDID;

@end
