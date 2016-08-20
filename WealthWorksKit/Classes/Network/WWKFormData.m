//
//  WWKFormData.m
//  Pods
//
//  Created by guoyalun on 8/20/16.
//
//

#import "WWKFormData.h"

@implementation WWKFormData

- (id)initWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType
{
    if (self = [super init]) {
        _data = data;
        _fileName = fileName;
        _mimeType = mimeType;
    }
    return self;
}


@end
