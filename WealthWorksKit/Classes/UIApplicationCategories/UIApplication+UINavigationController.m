//
//  UIApplication+UINavigationController.m
//  Fund
//
//  Created by JiaLei on 6/20/16.
//  Copyright © 2016 WealthWork. All rights reserved.
//

#import "UIApplication+UINavigationController.h"

@implementation UIApplication (UINavigationController)

- (UINavigationController *)visibleNavigationController {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow *appDelegateWindow = [appDelegate window];
        UIViewController *rootVC = appDelegateWindow.rootViewController;
        UINavigationController *navController = [self recursiveGetNavController:rootVC];
        return navController;
    }
    return nil;
}

#pragma mark - private - 递归获取可见UIViewController的UINavigationController

- (UINavigationController *)recursiveGetNavController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)vc;
        UIViewController *subVC = navController.visibleViewController;//modal vc. Otherwise top vc.
        return [self recursiveGetNavController:subVC];
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)vc;
        UIViewController *selectedVC = tabbarController.selectedViewController;
        return [self recursiveGetNavController:selectedVC];
        
    } else if ([vc isKindOfClass:[UIViewController class]]) {
        UIViewController *presentedVC = vc.presentedViewController;
        
        if (!presentedVC) {
            return vc.navigationController;
        } else {
            return [self recursiveGetNavController:presentedVC];
        }
    }
    
    return nil;
}


@end
