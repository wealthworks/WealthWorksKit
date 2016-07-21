//
//  TSURLNavigatorMap.m
//
//  Created by XiaoShan on 10/19/15.
//  Copyright © 2015 Higegou. All rights reserved.
//

#import "WWKURLNavigatorMap.h"

@interface WWKURLNavigatorMap () {
    NSMutableDictionary *_normalURLMap;
    NSMutableDictionary *_sharedURLMap;
    NSMutableDictionary *_stoaryboardMap;
}
@end

@implementation WWKURLNavigatorMap

- (instancetype)init {
    self = [super init];
    if (self) {
        _normalURLMap = [[NSMutableDictionary alloc] init];
        _sharedURLMap = [[NSMutableDictionary alloc] init];
        _stoaryboardMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)from:(NSString*)urlPath toViewController:(Class)targetClass stoaryboardName:(NSString *)stoaryBoard {
    if (!!urlPath && !!targetClass && !!targetClass) {
        [self removeMappingIfNeededForKey:urlPath];
        [_normalURLMap setObject:targetClass forKey:urlPath];//不区分大小写
        [_stoaryboardMap setObject:stoaryBoard forKey:urlPath];
    }
}

- (void)from:(NSString*)urlPath toSharedViewController:(Class)targetClass {
    if (!!urlPath && !!targetClass && !!targetClass) {
        NSString *key = [urlPath lowercaseString];
        [self removeMappingIfNeededForKey:key];
        [_sharedURLMap setObject:targetClass forKey:key];//不区分大小写
    }
}

#pragma mark - ################## Private methods ##################

- (void)removeMappingIfNeededForKey:(NSString *)key {
    [_normalURLMap removeObjectForKey:key];
    [_sharedURLMap removeObjectForKey:key];
    [_stoaryboardMap removeObjectForKey:key];
}

#pragma mark - ################## Getter & setter ##################

- (NSDictionary *)normalURLMap {
    return _normalURLMap;
}

- (NSDictionary *)sharedURLMap {
    return _sharedURLMap;
}

- (NSDictionary *)stoaryboardMap {
    return _stoaryboardMap;
}

@end