//
//  WWKURLNavigator.h
//
//  Created by XiaoShan on 10/19/15.
//  controller导航类，用于客户端外部和内部解耦方式打开对应的controller
//  协议格式   scheme://path?param1=123&param2=abc  例子： jijindou://buy_detail?apply_serial=20160629004892
//

#import <UIKit/UIKit.h>
#import "WWKURLNavigatorMap.h"
#import "WWKURLNavigatorAction.h"
#import "WWKURLNavigatorViewControllerProtocol.h"

@interface WWKURLNavigator : NSObject

@property (nonatomic, strong, readonly) WWKURLNavigatorMap *urlNavigatorMap;

/**
 *  导航器单例
 *
 *  @return 导航器实例
 */
+ (instancetype)navigator;

/**
 *  打开协议对应的controller
 *
 *  @param action 导航器属性封装类
 *
 *  @return 是否成功打开对应controller
 */
- (BOOL)openURLAction:(WWKURLNavigatorAction *)action;

@end