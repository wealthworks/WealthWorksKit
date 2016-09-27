//
//  WWKJPushManager.h
//  Pods
//
//  Created by guoyalun on 9/27/16.
//
//

#import <Foundation/Foundation.h>
#import <JPush/JPUSHService.h>


@interface WWKJPushManager : NSObject

/**
 *  推送单例
 *
 *  @return 推送全局唯一实例
 */
+ (instancetype)sharedInstance;

- (void)registerForRemoteNotification;

- (void)registJPushAppKey:(NSString *)appKey apsForProduction:(BOOL)production debugMode:(BOOL)debug launchOptions:(NSDictionary *)launchOptions;

- (void)uploadPushTokenToServerIfNeeded:(NSData *)deviceToken;

- (void)didReceiveRomoteNotification:(NSDictionary *)pushData;


@end
