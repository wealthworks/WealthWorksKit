//
//  WWKCommonService.h
//  WealthWorksKit
//
//  Created by JianLei on 16/7/7.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WWKCommonServiceUserMetaDataSite) {
    WWKCommonServiceUserMetaDataSiteTalicai = 1,
    WWKCommonServiceUserMetaDataSiteGuihua  = 2,
    WWKCommonServiceUserMetaDataSiteTimi    = 3,
    WWKCommonServiceUserMetaDataSiteFund    = 4,
};

@class WWKAppUpdateInfo;

@interface WWKCommonService : NSObject

/**
 *  广告跟踪数据统计
 */
+ (void)sendUserMetaDataWithSite:(WWKCommonServiceUserMetaDataSite)site
                         success:(void (^)(NSURLSessionDataTask *task))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  获取应用更新数据
 */
+ (void)checkAppUpdateWithSuccess:(void (^)(NSURLSessionDataTask *task, WWKAppUpdateInfo *appUpdateInfo))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
