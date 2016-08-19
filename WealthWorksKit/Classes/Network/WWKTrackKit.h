//
//  WWKTrackKit.h
//  WealthWorksKit
//
//  Created by JianLei on 16/7/7.
//  Copyright © 2016年 WealthWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WWKAppKey) {
    WWKAppKeyTalicai = 1,
    WWKAppKeyGuihua  = 2,
    WWKAppKeyTimi    = 3,
    WWKAppKeyFund    = 4
};

typedef NS_ENUM(NSUInteger, WWKTransactionState) {
    WWKTransactionStateSuccess = 0,
    WWKTransactionStateFailure = 1
};


@class WWKAppUpdateInfo;

@interface WWKTrackKit : NSObject

/**
 *  单例方法
 *
 *  @return instance
 */
+ (instancetype)shareInstance;

/**
 *  初始化的时候调用
 *
 *  @param appkey appkey
 */
+ (void)startWithAppKey:(WWKAppKey)appkey;

/**
 *  用户激活
 */
- (void)userDidActivate;

/**
 *  用户登录
 *
 *  @param userId 用户id
 */
- (void)userDidLoginWithUserId:(NSString *)userId;

/**
 *  用户注册
 *
 *  @param userId 用户id
 */
- (void)userDidRegistWithUserId:(NSString *)userId;

/**
 *  用户退出
 *
 *  @param userId 用户id
 */
- (void)userDidLogoutWithUserId:(NSString *)userId;

/**
 *  用户购买产品
 *
 *  @param userId    用户编号
 *  @param productId 商品编号
 *  @param shares    份额
 *  @param cost      金额
 *  @param status    状态
 */
- (void)userDidPurchase:(NSString *)userId product:(NSString *)productId shares:(CGFloat)shares cost:(CGFloat)cost status:(WWKTransactionState)status;


/**
 *  用户赎回产品
 *
 *  @param userId    用户编号
 *  @param productId 商品编号
 *  @param shares    份额
 *  @param cost      金额
 *  @param status    状态
 */
- (void)userDidRedeem:(NSString *)userId product:(NSString *)productId shares:(CGFloat)shares cost:(CGFloat)cost status:(WWKTransactionState)status;

/**
 *  检查版本升级
 *
 *  @param success 成功
 */
- (void)checkAppUpdateWithSuccess:(void (^)(WWKAppUpdateInfo *appUpdateInfo))success;

@end
