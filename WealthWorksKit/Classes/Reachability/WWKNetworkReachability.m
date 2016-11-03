//
//  WWKNetworkReachability.m
//  Fund
//
//  Created by JiaLei on 11/2/16.
//  Copyright © 2016 WealthWork. All rights reserved.
//

#import "WWKNetworkReachability.h"
#import <CoreTelephony/CTCellularData.h>
#import "UIApplication+UINavigationController.h"
#import "WWKDevice.h"
#import "AFNetworking.h"

@implementation WWKNetworkReachability

+ (void)alertIfNetworkNotConnect {
    if ([WWKDevice systemVersion].floatValue < 10.0) {
        return;
    }
    
    NSString *lanuchTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"WWKLanuchTime"];
    if (!lanuchTime) {
        [[NSUserDefaults standardUserDefaults] setObject:@"WWKLanuchSecond" forKey:@"WWKLanuchTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([lanuchTime isEqualToString:@"WWKLanuchSecond"]) {
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
            //获取联网状态
            switch (state) {
                case kCTCellularDataRestricted:
                    NSLog(@"限制蜂窝或全限制");
                    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
                    if (![AFNetworkReachabilityManager sharedManager].isReachableViaWiFi) {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"已为“基金豆”关闭网络"
                                                                                                 message:@"您可以在“设置”中为此应用打开无线局域网。"
                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                            [[UIApplication sharedApplication] openURL:url];
                        }]];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }]];
                        UINavigationController *nav = [UIApplication sharedApplication].visibleNavigationController;
                        [nav presentViewController:alertController animated:YES completion:nil];
                    }
                    break;
                case kCTCellularDataNotRestricted:
                    NSLog(@"全不限制");
                    break;
                case kCTCellularDataRestrictedStateUnknown:
                    NSLog(@"Unknown");
                    break;
                default:
                    break;
            };
        };
        
        [[NSUserDefaults standardUserDefaults] setObject:@"WWKLanuchMorethenSecond" forKey:@"WWKLanuchTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
