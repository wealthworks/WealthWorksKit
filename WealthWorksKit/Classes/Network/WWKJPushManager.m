//
//  WWKJPushManager.m
//  Pods
//
//  Created by guoyalun on 9/27/16.
//
//

#import "WWKJPushManager.h"
#import "WWKDevice.h"
#import "WWKBundle.h"

@interface WWKJPushManager() {
    
    BOOL  debugMode;
}

@end

@implementation WWKJPushManager

+ (instancetype)sharedInstance {
    static WWKJPushManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WWKJPushManager alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self
                          selector:@selector(networkDidSetup:)
                              name:kJPFNetworkDidSetupNotification
                            object:nil];
        [defaultCenter addObserver:self
                          selector:@selector(networkDidClose:)
                              name:kJPFNetworkDidCloseNotification
                            object:nil];
        [defaultCenter addObserver:self
                          selector:@selector(networkDidRegister:)
                              name:kJPFNetworkDidRegisterNotification
                            object:nil];
        [defaultCenter addObserver:self
                          selector:@selector(networkDidLogin:)
                              name:kJPFNetworkDidLoginNotification
                            object:nil];
        [defaultCenter addObserver:self
                          selector:@selector(networkDidReceiveMessage:)
                              name:kJPFNetworkDidReceiveMessageNotification
                            object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * 注册APNS推送
 * 此方法会回调到AppDelegate的APNS推送注册区段的delegate代码
 */
- (void)registerForRemoteNotification {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }  else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}


- (void)registJPushAppKey:(NSString *)appKey apsForProduction:(BOOL)production debugMode:(BOOL)debug launchOptions:(NSDictionary *)launchOptions {
    
    [self registerForRemoteNotification];
    
    debugMode = debug;
    
    if (debugMode) {
        [JPUSHService setDebugMode];
    } else {
        [JPUSHService setLogOFF];
    }
    
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                          categories:nil];
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:appKey
                          channel:@"AppStore"
                 apsForProduction:production
            advertisingIdentifier:[WWKDevice IDFA]];
    [JPUSHService resetBadge];
}


- (void)didReceiveRomoteNotification:(NSDictionary *)pushData {
    [JPUSHService handleRemoteNotification:pushData];
}

/**
 *  上传最新的push token到服务器
 *
 *  @param latestPushToken 最新从APNS服务器下发的push token
 */
- (void)uploadPushTokenToServerIfNeeded:(NSData *)deviceToken {
    NSString *pushNotificationToken = [[NSString stringWithFormat:@"%@", deviceToken] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
    NSString *pushToken = [pushNotificationToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    //非法token
    if (pushToken.length <= 0) {
        NSLog(@"Invalid latestPushToken: empty string.");
        return;
    }
    NSLog(@"Upload DeviceToken deviceToken:%@", deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark - notification JPush

- (void)networkDidSetup:(NSNotification *)notification {
    [JPUSHService setTags:[NSSet setWithObject:[WWKBundle jpushVersionForDebug:debugMode]]
                    alias:[WWKDevice identifier]
         fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
             NSLog(@"极光设置tag,别名成功tags: %@alias：%@  iResCode:%d", iTags, iAlias,iResCode);
         }];
    NSLog(@"极光已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"极光未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"极光已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"极光已登录");
    if ([JPUSHService registrationID]) {
        NSLog(@"get RegistrationID %@", [JPUSHService registrationID]);
        [JPUSHService setTags:[NSSet setWithObject:[WWKBundle jpushVersionForDebug:debugMode]]
                        alias:[WWKDevice identifier]fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                                NSLog(@"极光设置tag,别名成功tags: %@alias：%@  iResCode:%d", iTags, iAlias,iResCode);
                        }];
    }
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
}


@end
