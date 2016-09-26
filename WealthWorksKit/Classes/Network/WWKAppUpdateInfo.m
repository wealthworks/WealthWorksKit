//
//  WWKAppUpdateInfo.m
//  WealthWorksKit
//
//  Created by JianLei on 16/8/1.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import "WWKAppUpdateInfo.h"
#import "NSString+MJExtension.h"


@implementation WWKAppUpdateInfo

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName mj_underlineFromCamel];
}

@end
