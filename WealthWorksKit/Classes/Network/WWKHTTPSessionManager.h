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

- (NSURLSessionDataTask *)wwk_GET:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)wwk_POST:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                           success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
