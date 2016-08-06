//
//  WWKTestNavigator.h
//  WealthWorksKit
//
//  Created by JianLei on 16/8/6.
//  Copyright © 2016年 张建磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWKTestNavigator : NSObject

@property (nonatomic, strong) WWKURLNavigatorAction *cachedUrlAction;

+ (instancetype)navigator;

+ (void)setup;

@end
