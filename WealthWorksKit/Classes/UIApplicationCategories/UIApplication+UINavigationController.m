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
        UIViewController *viewController = [self recursiveGetViewController:rootVC];
        return viewController.navigationController;
    }
    return nil;
}

- (UIViewController *)currentTopViewController {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow *appDelegateWindow = [appDelegate window];
        UIViewController *rootVC = appDelegateWindow.rootViewController;
        UIViewController *viewController = [self recursiveGetViewController:rootVC];
        return viewController;
    }
    return nil;
}

#pragma mark - private - 递归获取可见UIViewController的UINavigationController

- (UIViewController *)recursiveGetViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)vc;
        UIViewController *subVC = navController.visibleViewController;//modal vc. Otherwise top vc.
        return [self recursiveGetViewController:subVC];
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)vc;
        UIViewController *selectedVC = tabbarController.selectedViewController;
        return [self recursiveGetViewController:selectedVC];
        
    } else if ([vc isKindOfClass:[UIViewController class]]) {
        UIViewController *presentedVC = vc.presentedViewController;
        
        if (!presentedVC) {
            return vc;
        } else {
            return [self recursiveGetViewController:presentedVC];
        }
    }
    
    return nil;
}


@end
