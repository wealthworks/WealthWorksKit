//
//  WWKURLNavigatorViewControllerProtocol.h
//
//  Created by XiaoShan on 10/20/15.
//  Copyright © 2015 Higegou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WWKURLNavigatorViewControllerProtocol <NSObject>

@optional

/**
 *  通过storyboard创建的controller，实现此协议方法接受参数
 *
 *  @param dic 参数字典，接受WWWKURLNavigatorAction传过来的参数
 */
- (void)setQuery:(NSDictionary *)dic;

/**
 *  不是通过storyboard创建的controller，实现此协议方法来初始化，并传入参数
 *
 *  @param URL      controller对应的协议URL
 *  @param query    controller需要的参数字典
 *
 *  @return         需要打开的controller实例
 */
- (instancetype)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query;

@end