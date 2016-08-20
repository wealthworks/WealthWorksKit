//
//  WWKFormData.h
//  Pods
//
//  Created by guoyalun on 8/20/16.
//
//

#import <Foundation/Foundation.h>

@interface WWKFormData : NSObject

@property (nonatomic,strong) NSData *data;
@property (nonatomic,copy)   NSString *fileName;
@property (nonatomic,copy)   NSString *mimeType;

- (id)initWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end
