//
//  WWKCommonService.m
//  WealthWorksKit
//
//  Created by JianLei on 16/7/7.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKCommonService.h"
#import "WWKHTTPSessionManager.h"
#import "WWKDevice.h"
#import "WWKBundle.h"
#import "WWKAppUpdateInfo.h"

static NSString * const kSendUserMetaDataURL = @"/r/app";
static NSString * const kCheckAppUpdateURL   = @"/v1/update/check";

@implementation WWKCommonService

+ (void)sendUserMetaDataWithSite:(WWKCommonServiceUserMetaDataSite)site
                         success:(void (^)(NSURLSessionDataTask *task))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    WWKHTTPSessionManager *manager = [WWKHTTPSessionManager wwk_manager];
    NSDictionary *params = @{
                             @"os"        : @(2), // 1=android, 2=iOS, 3=other
                             @"osversion" : [WWKDevice systemVersion],
                             @"idfa"      : [WWKDevice IDFA],
                             @"openudid"  : [WWKDevice uuid],
                             @"model"     : [WWKDevice model],
                             @"appversion": [WWKBundle appVersion],
                             @"buildcode" : [WWKBundle buildVersion],
                             @"channel"   : @"AppStore",
                             @"ip"        : [WWKDevice IPAddress],
                             @"site"      : @(site)
                             };
    
    WWKLogPARAMS(params);
    [manager GET:kSendUserMetaDataURL parameters:params progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        WWKLogSUCCESS(responseObject);
        if (!success) return;
        success(task);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        WWKLogFAILURE(error);
        if (!failure) return;
        failure(task, error);
    }];
}

+ (void)checkAppUpdateWithSuccess:(void (^)(NSURLSessionDataTask *task, WWKAppUpdateInfo *appUpdateInfo))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    WWKHTTPSessionManager *manager = [WWKHTTPSessionManager wwk_managerWithBaseURL:@"http://192.168.8.21:34000/"];
    NSDictionary *params = @{
                             @"pkg_name": [WWKBundle bundleID],
                             @"platform": @(2), // 1=android, 2=iOS, 3=other
                             @"channel" : @"AppStore",
                             @"version" : [WWKBundle appVersion]
                             };
    
    WWKLogPARAMS(params);
    [manager wwk_GET:kCheckAppUpdateURL parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        WWKLogSUCCESS(responseObject);
        if (!success) return;
        WWKAppUpdateInfo *appUpdateInfo = [WWKAppUpdateInfo mj_objectWithKeyValues:responseObject[@"data"]];
        success(task, appUpdateInfo);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        WWKLogFAILURE(error);
        if (!failure) return;
        failure(task, error);
    }];
}

@end
