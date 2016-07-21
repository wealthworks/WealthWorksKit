//
//  JJDNavigator.h
//  Fund
//
//  Created by JiaLei on 6/20/16.
//  Copyright © 2016 WealthWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWKURLNavigatorAction.h"
#import "TestNavigationDefine.h"

@interface TestNavigator : NSObject

@property (nonatomic, strong) WWKURLNavigatorAction *cachedUrlAction;

+ (instancetype)navigator;

+ (void)setup;

@end
