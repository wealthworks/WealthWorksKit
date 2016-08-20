//
//  WWKHTTPSessionManager.m
//  WealthWorksKit
//
//  Created by JianLei on 16/8/1.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKHTTPSessionManager.h"

@implementation WWKHTTPSessionManager

+ (instancetype)wwk_managerWithBaseURL:(NSString *)baseURL
{
    NSURL *URL = [NSURL URLWithString:baseURL];
    WWKHTTPSessionManager *manager = [[self alloc] initWithBaseURL:URL];
    return manager;
}

- (NSURLSessionDataTask *)wwk_GET:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [super GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSNumber *successNumber = responseObject[@"success"];
        if (!successNumber || [successNumber boolValue]) {
            if (success) success(task, responseObject);
        } else {
            NSNumber *codeNumber = responseObject[@"code"];
            NSInteger code = codeNumber ? [codeNumber integerValue] : 0;
            NSString *messageString = responseObject[@"message"];
            NSString *message = messageString ? : @"";
            
            NSError *error = [NSError errorWithDomain:@"WWKErrorDomainAFNetworking" code:code userInfo:@{NSLocalizedDescriptionKey: message}];
            if (failure) failure(task, error);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) failure(task, error);
    }];
}

- (NSURLSessionDataTask *)wwk_POST:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                           success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [super POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSNumber *successNumber = responseObject[@"success"];
        if (!successNumber || [successNumber boolValue]) {
            if (success) success(task, responseObject);
        } else {
            NSNumber *codeNumber = responseObject[@"code"];
            NSInteger code = codeNumber ? [codeNumber integerValue] : 0;
            NSString *messageString = responseObject[@"message"];
            NSString *message = messageString ? : @"";
            
            NSError *error = [NSError errorWithDomain:@"WWKErrorDomainAFNetworking" code:code userInfo:@{NSLocalizedDescriptionKey: message}];
            if (failure) failure(task, error);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) failure(task, error);
    }];
}


- (NSURLSessionDataTask *)wwk_POST:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                          formData:(WWKFormData *)imageData
                           success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    return [super POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:imageData.data name:@"file" fileName:imageData.fileName mimeType:imageData.mimeType];

    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *successNumber = responseObject[@"success"];
        if (!successNumber || [successNumber boolValue]) {
            if (success) success(task, responseObject);
        } else {
            NSNumber *codeNumber = responseObject[@"code"];
            NSInteger code = codeNumber ? [codeNumber integerValue] : 0;
            NSString *messageString = responseObject[@"message"];
            NSString *message = messageString ? : @"";
            
            NSError *error = [NSError errorWithDomain:@"WWKErrorDomainAFNetworking" code:code userInfo:@{NSLocalizedDescriptionKey: message}];
            if (failure) failure(task, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(task, error);
    }];
    
}


@end
