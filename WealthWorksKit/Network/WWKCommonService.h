//
//  WWKCommonService.h
//  WealthWorksKit
//
//  Created by JianLei on 16/7/7.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WWKCommonServiceUserMetaDataSite) {
    WWKCommonServiceUserMetaDataSiteTalicai = 1,
    WWKCommonServiceUserMetaDataSiteGuihua  = 2,
    WWKCommonServiceUserMetaDataSiteTimi    = 3,
    WWKCommonServiceUserMetaDataSiteFund    = 4,
};

@interface WWKCommonService : NSObject

/**
 *  理财工场广告跟踪数据统计
 */
+ (void)sendUserMetaDataWithSite:(WWKCommonServiceUserMetaDataSite)site;

@end
