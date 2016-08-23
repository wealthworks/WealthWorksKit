//
//  WWKURLNavigatorMap.h
//
//  Created by XiaoShan on 10/19/15.
//

#import <Foundation/Foundation.h>

@interface WWKURLNavigatorMap : NSObject

@property (nonatomic, strong, readonly) NSDictionary *normalURLMap;

@property (nonatomic, strong, readonly) NSDictionary *modelURLMap;

@property (nonatomic, strong, readonly) NSDictionary *stoaryboardMap;

/**
 *  设置以push方式打开controller映射关系
 *
 *  @param urlPath     对应controller的协议
 *  @param targetClass 对应controller的类名
 *  @param stoaryBoard 对应controller的stoaryboard名
 */
- (void)from:(NSString*)urlPath toViewController:(Class)targetClass stoaryboardName:(NSString *)stoaryBoard;

/**
 *  设置以model方式打开controller映射关系
 *
 *  @param urlPath     对应controller的协议
 *  @param targetClass 对应controller的类名
 */
- (void)from:(NSString*)urlPath toModelViewController:(Class)targetClass;

@end