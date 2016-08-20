//
//  WWKTrackKit.m
//  WealthWorksKit
//
//  Created by JianLei on 16/7/7.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKTrackKit.h"
#import "WWKHTTPSessionManager.h"
#import "WWKDevice.h"
#import "WWKBundle.h"
#import "WWKAppUpdateInfo.h"

typedef NS_ENUM(NSUInteger,WWKTrackAction) {
    WWKTrackActionActivate  = 1,
    WWKTrackActionRegist    = 2,
    WWKTrackActionLogin     = 3,
    WWKTrackActionPurchase  = 4,
    WWKTrackActionRedeem    = 5,
    WWKTrackActionLogout    = 6
};

//static NSString * const kAppTrackingHost = @"http://192.168.10.115:33000/";
//static NSString * const kAppUpdateHost = @"http://192.168.8.21:34000/";

static NSString * const kAppTrackingHost = @"http://c.lcgc.pub/";
static NSString * const kAppUpdateHost = @"http://v.lcgc.pub/";

static NSString * const kAppTrackingURL = @"/v1/app";
static NSString * const kAppUpdateURL   = @"/v1/update/check";

static NSString * const kIdentifierTalicai  = @"com.talicai.TalicaiCommunity";
static NSString * const kIdentifierTimi     = @"com.talicai.billstool";
static NSString * const kIdentifierGuihua   = @"com.guihua.app.WeathPlan";
static NSString * const kIdentifierFund     = @"com.jijindou.fund";



static WWKTrackKit *instance = nil;

@interface WWKTrackKit ()
@property (nonatomic,assign) WWKAppKey appkey;
@end

@implementation WWKTrackKit
@synthesize appkey;

#pragma mark - static

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WWKTrackKit alloc] init];
        
        if ([[WWKBundle bundleID] isEqualToString:kIdentifierTalicai]) {
            instance.appkey = WWKAppKeyTalicai;
        } else if ([[WWKBundle bundleID] isEqualToString:kIdentifierTimi]) {
            instance.appkey = WWKAppKeyTimi;
        } else if ([[WWKBundle bundleID] isEqualToString:kIdentifierGuihua]) {
            instance.appkey = WWKAppKeyGuihua;
        } else if ([[WWKBundle bundleID] isEqualToString:kIdentifierFund]) {
            instance.appkey = WWKAppKeyFund;
        }
    });
    
    return instance;
    
}

+ (void)startWithAppKey:(WWKAppKey)appkey
{
    WWKTrackKit *shareInstance = [self shareInstance];
    shareInstance.appkey = appkey;
}


#pragma mark - public
- (void)userDidActivate {
    [self sendRequestWithParameters:@{@"action":@(WWKTrackActionActivate)}];
}


- (void)userDidLoginWithUserId:(NSString *)userId {
    
    if (!userId) {
        return;
    }
    
    [self sendRequestWithParameters:@{@"action" :   @(WWKTrackActionLogin),
                                      @"role"   :   userId }];
}

- (void)userDidRegistWithUserId:(NSString *)userId {
    
    if (!userId) {
        return;
    }
    
    [self sendRequestWithParameters:@{@"action" :   @(WWKTrackActionRegist),
                                      @"role"   :   userId }];
}

- (void)userDidLogoutWithUserId:(NSString *)userId {
    if (!userId) {
        return;
    }
    
    [self sendRequestWithParameters:@{@"action" :   @(WWKTrackActionLogout),
                                      @"role"   :   userId }];
}


- (void)userDidPurchase:(NSString *)userId product:(NSString *)productId shares:(CGFloat)shares cost:(CGFloat)cost status:(WWKTransactionState)status {
    
    if( !userId || !productId ) {
        return;
    }
    
    [self sendRequestWithParameters:@{@"action"         :   @(WWKTrackActionPurchase),
                                      @"role"           :   userId,
                                      @"target"         :   productId,
                                      @"shares"         :   @(shares),
                                      @"cost"           :   @(cost),
                                      @"trade_status"   :   @(status)}];

}


- (void)userDidRedeem:(NSString *)userId product:(NSString *)productId shares:(CGFloat)shares cost:(CGFloat)cost status:(WWKTransactionState)status {
    if( !userId || !productId ) {
        return;
    }
    
    [self sendRequestWithParameters:@{@"action"         :   @(WWKTrackActionRedeem),
                                      @"role"           :   userId,
                                      @"target"         :   productId,
                                      @"shares"         :   @(shares),
                                      @"cost"           :   @(cost),
                                      @"trade_status"   :   @(status)}];
    
}

- (void)checkAppUpdateWithSuccess:(void (^)(WWKAppUpdateInfo *appUpdateInfo))success {
    
    WWKHTTPSessionManager *manager = [WWKHTTPSessionManager wwk_managerWithBaseURL:kAppUpdateHost];
    NSDictionary *params = @{
                             @"pkg_name": [WWKBundle bundleID],
                             @"platform": @(2), // 1=android, 2=iOS, 3=other
                             @"channel" : @"AppStore",
                             @"version" : [WWKBundle appVersion]
                             };
    
    WWKLogPARAMS(params);
    [manager wwk_GET:kAppUpdateURL parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        WWKLogSUCCESS(responseObject);
        if (!success) return;
        WWKAppUpdateInfo *appUpdateInfo = [WWKAppUpdateInfo mj_objectWithKeyValues:responseObject[@"data"]];
        success(appUpdateInfo);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        WWKLogFAILURE(error);
    }];
}

#pragma mark - private
- (void)sendRequestWithParameters:(NSDictionary *)parameters {
    WWKHTTPSessionManager *manager = [WWKHTTPSessionManager wwk_managerWithBaseURL:kAppTrackingHost];
    
    long long timestamp = (long long )[[NSDate date] timeIntervalSince1970]*1000;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: @{  @"os"        : @(2), // 1=android, 2=iOS, 3=other
                                                                                   @"osversion" : [WWKDevice systemVersion],
                                                                                   @"idfa"      : [WWKDevice IDFA],
                                                                                   @"openudid"  : [WWKDevice uuid],
                                                                                   @"model"     : [WWKDevice model],
                                                                                   @"appversion": [WWKBundle appVersion],
                                                                                   @"buildcode" : [WWKBundle buildVersion],
                                                                                   @"channel"   : @"AppStore",
                                                                                   @"ip"        : [WWKDevice IPAddress],
                                                                                   @"site"      : @(self.appkey),
                                                                                   @"osname"    : @"iOS",
                                                                                   @"timestamp" : @(timestamp)
                                                                                   }];
    [dict addEntriesFromDictionary:parameters];
    
    WWKLogPARAMS(parameters);
    [manager GET:kAppTrackingURL parameters:dict progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        WWKLogSUCCESS(responseObject);
        return;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        WWKLogFAILURE(error);
        return;
    }];
}


@end
