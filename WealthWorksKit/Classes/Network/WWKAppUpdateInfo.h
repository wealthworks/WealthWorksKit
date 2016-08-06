//
//  WWKAppUpdateInfo.h
//  WealthWorksKit
//
//  Created by JianLei on 16/8/1.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWKAppUpdateInfo : NSObject

@property (nonatomic, copy  ) NSString *pkgName;        /**< 应用包名 */
@property (nonatomic, copy  ) NSString *version;        /**< 应用最新版本 */
@property (nonatomic, copy  ) NSNumber *versionCode;
@property (nonatomic, copy  ) NSNumber *platform;       /**< 操作系统类型 */
@property (nonatomic, copy  ) NSString *channel;        /**< 渠道名称 */
@property (nonatomic, copy  ) NSString *update;         /**< 更新类型 */
@property (nonatomic, assign) BOOL     force;           /**< 是否需要强制更新 */
@property (nonatomic, copy  ) NSString *md5;            /**< MD5 */
@property (nonatomic, copy  ) NSString *url;            /**< URL */
@property (nonatomic, copy  ) NSNumber *size;           /**< 文件大小 */
@property (nonatomic, copy  ) NSArray  *changlog;       /**< 更新日志 */

@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *desc;
@property (nonatomic, copy  ) NSString *image;

@end
