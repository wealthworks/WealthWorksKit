//
//  TSURLNavigatorAction.m
//
//  Created by XiaoShan on 10/19/15.
//

#import "WWKURLNavigatorAction.h"

@interface WWKURLNavigatorAction ()

@property (nonatomic, copy, readwrite) NSString *urlPath;
@property (nonatomic, strong, readwrite) NSDictionary *query;
@property (nonatomic, assign, readwrite) BOOL needAnimatedTransition;
@property (nonatomic, assign, readwrite) BOOL openURLOutOfApp;

@end

@implementation WWKURLNavigatorAction

+ (instancetype)actionWithURLPath:(NSString*)urlPath {
    WWKURLNavigatorAction *urlNavigatorAction = [[WWKURLNavigatorAction alloc] initWithURLPath:urlPath];
    
    return urlNavigatorAction;
}

- (instancetype)initWithURLPath:(NSString*)urlPath {
    if (self = [super init]) {
        _needAnimatedTransition = YES;
        _urlPath = urlPath;
    }
    
    return self;
}

- (void)applyAnimated:(BOOL)animated {
    _needAnimatedTransition = animated;
}

- (void)applyQuery:(NSDictionary*)query {
    _query = query;
}

- (void)applyOpenURLOutOfApp:(BOOL)openURLOutOfApp {
    _openURLOutOfApp = openURLOutOfApp;
}

@end