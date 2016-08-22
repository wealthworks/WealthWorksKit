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

#pragma mark - Override
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (error) {
                               if (failure) {
                                   NSError *msg = [self getErrorMessage:responseObject];
                                   failure(dataTask, msg!=nil?msg:error);
                               }
                           } else {
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                       }];
    
    return dataTask;
}

#pragma mark - Private
- (NSError *)getErrorMessage:(NSDictionary *)responseObject {
    
    NSDictionary *messages = [responseObject objectForKey:@"messages"];
    NSString *errorMessage = nil;
    if ([messages count] > 0) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSArray *values in messages.allValues) {
            [array addObject:[values componentsJoinedByString:@"\n"]];
        }
        errorMessage = [array componentsJoinedByString:@"\n"];
    } else if (messages == nil) {
        errorMessage = [responseObject objectForKey:@"message"];
    }
    
    if(errorMessage) {
        NSNumber *codeNumber = responseObject[@"code"];
        NSError *error = [NSError errorWithDomain:@"WWKErrorDomainAFNetworking" code:[codeNumber integerValue] userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
        return error;
    }
    
    return nil;
    
}


@end
