//
//  WWKURLNavigatorAction.h
//
//  Created by XiaoShan on 10/19/15.
//

#import <Foundation/Foundation.h>

@interface WWKURLNavigatorAction : NSObject

@property (nonatomic, strong) WWKURLNavigatorAction *parent;
@property (nonatomic, copy, readonly) NSString *urlPath;
@property (nonatomic, strong, readonly) NSDictionary *query;
@property (nonatomic, assign, readonly) BOOL needAnimatedTransition;
@property (nonatomic, assign, readonly) BOOL openURLOutOfApp;

/**
 *  获取导航器属性实例
 *
 *  @param urlPath controller对应的协议
 *
 *  @return 导航属性实例
 */
+ (instancetype)actionWithURLPath:(NSString*)urlPath;

/**
 *  设置导航动画属性
 *
 *  @param animated 是否动画方式打开controller
 *
 */
- (void)applyAnimated:(BOOL)animated;

/**
 *  设置导航参数，可通过此方法传递弹出controller需要的参数
 *
 *  @param query 参数字典
 */
- (void)applyQuery:(NSDictionary*)query;


@end