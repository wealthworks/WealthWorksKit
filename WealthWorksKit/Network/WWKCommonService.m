//
//  WWKCommonService.m
//  WealthWorksKit
//
//  Created by JianLei on 16/7/7.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKCommonService.h"
#import "WWKDevice.h"
#import "WWKBundle.h"

@implementation WWKCommonService

+ (void)sendUserMetaDataWithSite:(WWKCommonServiceUserMetaDataSite)site
{
    switch (site) {
        case WWKCommonServiceUserMetaDataSiteTalicai:
        case WWKCommonServiceUserMetaDataSiteGuihua:
        case WWKCommonServiceUserMetaDataSiteTimi:
        case WWKCommonServiceUserMetaDataSiteFund:
            break;
        default:
            WWKLog(@"===== [WealthWorksKit] => %s : APPID ERROR", __FUNCTION__);
            return;
    }
    
    NSDictionary *paramsDict = @{
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
    
    NSMutableArray<NSString *> *paramsArray = [[NSMutableArray alloc] initWithCapacity:paramsDict.count];
    [paramsDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        [paramsArray addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    NSString *params = [[paramsArray componentsJoinedByString:@"&"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.lcgc.pub/r/app?%@", params]]];
    request.HTTPMethod = @"GET";
    
    WWKLog(@"===== [WealthWorksKit] => %s : PARAMS :", __FUNCTION__);
    WWKLog(@"%@", paramsDict);
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        WWKLog(@"===== [WealthWorksKit] => %s : RESPONSE :", __FUNCTION__);
        WWKLog(@"%@", response);
    }] resume];
}

@end
