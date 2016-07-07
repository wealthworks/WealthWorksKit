//
//  WWKCommonService.h
//  WealthWorksKit
//
//  Created by JianLei on 16/7/7.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WWKCommonServiceUserMetaDataAppID) {
    WWKCommonServiceUserMetaDataAppIDTalicai = 1,
    WWKCommonServiceUserMetaDataAppIDTimi    = 3,
    WWKCommonServiceUserMetaDataAppIDGuihua  = 5,
    WWKCommonServiceUserMetaDataAppIDFund    = 7,
};

@interface WWKCommonService : NSObject

+ (void)sendUserMetaDataWithAppID:(WWKCommonServiceUserMetaDataAppID)appID;

@end
