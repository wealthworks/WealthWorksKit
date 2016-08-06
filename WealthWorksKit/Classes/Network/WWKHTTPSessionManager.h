//
//  WWKHTTPSessionManager.h
//  WealthWorksKit
//
//  Created by JianLei on 16/8/1.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


#define WWKLogFUNCTION WWKLog(@"===== [WealthWorksKit] ===== %s =====", __FUNCTION__)

#define WWKLogPARAMS(params)    WWKLogFUNCTION; WWKLog(@"PARAMS :\n%@", params);
#define WWKLogSUCCESS(object)   WWKLogFUNCTION; WWKLog(@"RESPONSE : SUCCESS :\n%@", object);
#define WWKLogFAILURE(error)    WWKLogFUNCTION; WWKLog(@"RESPONSE : FAILURE :\n%@", error);


@interface WWKHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)wwk_manager;
+ (instancetype)wwk_managerWithBaseURL:(NSString *)baseURL;

@end
