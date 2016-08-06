//
//  WWKAppDelegate.m
//  WealthWorksKit
//
//  Created by 张建磊 on 08/06/2016.
//  Copyright (c) 2016 张建磊. All rights reserved.
//

#import "WWKAppDelegate.h"
#import "WWKTestNavigator.h"
#import "WWKViewController.h"

@implementation WWKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [WWKTestNavigator setup];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WWKViewController *rootViewController = (WWKViewController *)[storyboard instantiateViewControllerWithIdentifier:@"WWKViewController"];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    // 设置KeyWindow
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
