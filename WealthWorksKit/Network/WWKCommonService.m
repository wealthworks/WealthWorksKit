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

+ (void)sendUserMetaDataWithAppID:(WWKCommonServiceUserMetaDataAppID)appID
{
    if (appID != WWKCommonServiceUserMetaDataAppIDTalicai &&
        appID != WWKCommonServiceUserMetaDataAppIDTimi    &&
        appID != WWKCommonServiceUserMetaDataAppIDGuihua  &&
        appID != WWKCommonServiceUserMetaDataAppIDFund) {
        
        WWKLog(@"======================================== WWKCommonService -sendUserMetaDataWithAppID: APPID ERROR ========================================\n");
        
        return;
    }
    
    NSDictionary *paramsDict = @{
                                @"appid"      : @(appID),
                                @"idfa"       : [WWKDevice IDFA],
                                @"model"      : [WWKDevice model],
                                @"openudid"   : [WWKDevice openUDID],
                                @"os"         : [NSString stringWithFormat:@"%@ %@", [WWKDevice systemName], [WWKDevice systemVersion]],
                                @"app_domain" : @"AppStore",
                                @"app_version": [WWKBundle appVersion]
                                };
    
    NSMutableArray<NSString *> *paramsArray = [[NSMutableArray alloc] initWithCapacity:paramsDict.count];
    [paramsDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        [paramsArray addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    NSString *params = [[paramsArray componentsJoinedByString:@"&"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://click.licaigc.cn/r/app?%@", params]]];
    request.HTTPMethod = @"GET";
    
    WWKLog(@"======================================== WWKCommonService -sendUserMetaDataWithAppID: PARAMS ========================================\n");
    WWKLog(@"%@", paramsDict);
    WWKLog(@"======================================== WWKCommonService -sendUserMetaDataWithAppID: PARAMS ========================================\n");
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        WWKLog(@"======================================== WWKCommonService -sendUserMetaDataWithAppID: RESPONSE ========================================\n");
        WWKLog(@"%@", response);
        WWKLog(@"======================================== WWKCommonService -sendUserMetaDataWithAppID: RESPONSE ========================================\n");
    }] resume];
}

@end
