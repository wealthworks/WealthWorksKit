//
//  TSURLNavigator.m
//
//  Created by XiaoShan on 10/19/15.
//

#import "WWKURLNavigator.h"
#import "WWKURLNavigatorMap.h"
#import "NSString+Compare.h"
#import "UIApplication+UINavigationController.h"

@interface WWKURLNavigator ()

@property (nonatomic, strong, readwrite) WWKURLNavigatorMap *urlNavigatorMap;

@end

@implementation WWKURLNavigator

+ (instancetype)navigator {
    static WWKURLNavigator *sharedNavigator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNavigator = [[WWKURLNavigator alloc] init];
    });
    
    return sharedNavigator;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _urlNavigatorMap = [[WWKURLNavigatorMap alloc] init];
    }
    return self;
}

- (BOOL)openURLAction:(WWKURLNavigatorAction *)action {
    if (!(action.parent)) {
        return [self doOpenURLAction:action];
    } else {
        [self openURLAction:action.parent];
        
        return [self doOpenURLAction:action];
    }
}

- (BOOL)hadOpenVC:(NSString *)pageURL {
    Class vcClass = nil;
    
    //查找是否是一个已注册的pageURL
    for (NSString *mappedLinkURLProtocol in _urlNavigatorMap.sharedURLMap) {
        BOOL eq = [pageURL isEqualToStringIgnoreCase:mappedLinkURLProtocol];
        
        if (eq) {
            vcClass = _urlNavigatorMap.sharedURLMap[mappedLinkURLProtocol];
            break;
        }
    }
    
    for (NSString *mappedLinkURLProtocol in _urlNavigatorMap.normalURLMap) {
        BOOL eq = [pageURL isEqualToStringIgnoreCase:mappedLinkURLProtocol];
        
        if (eq) {
            vcClass = _urlNavigatorMap.normalURLMap[mappedLinkURLProtocol];
            break;
        }
    }
    
    //是否可见
    BOOL isVisible = NO;
    if (!!vcClass) {
        NSArray *viewControllers = [UIApplication sharedApplication].visibleNavigationController.viewControllers;
        
        for (UIViewController *viewController in viewControllers) {
            if ([viewController isKindOfClass:vcClass]
                && [viewController conformsToProtocol:@protocol(WWKURLNavigatorViewControllerProtocol)]) {
                isVisible = YES;
                break;
            }
        }
    }
    
    return isVisible;
}

- (BOOL)doOpenURLAction:(WWKURLNavigatorAction *)action {
    if (action.openURLOutOfApp) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:action.urlPath]];
        return YES;
        
    } else {
        UIViewController<WWKURLNavigatorViewControllerProtocol> *vc = nil;
        
        //查找将被打开的页是否为Shared VC
        BOOL isVisible = NO;
        vc = [self findVCFromSharedURLMapByAction:action isVisible:&isVisible];
        UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
        if (!nav) {
            WWKLog(@"%@无法打开Action %@ 对应的页面。", NSStringFromClass(self.class), action);
            return NO;
        }
        
        if (!!vc && isVisible) {
            [nav popToViewController:vc animated:action.needAnimatedTransition];
            return YES;
        } else if (!!vc && !isVisible) {
            [nav pushViewController:vc animated:action.needAnimatedTransition];
            return YES;
        }
        
        //查找将被打开的页是否为Normal VC
        vc = [self findVCFromNormalURLMapByAction:action];
        
        if (!vc) {
            WWKLog(@"%@无法打开Action %@ 对应的页面。", NSStringFromClass(self.class), action);
            return NO;
        }
        
        [nav pushViewController:vc animated:action.needAnimatedTransition];
        
        return YES;
    }
}

- (UIViewController<WWKURLNavigatorViewControllerProtocol> *)findVCFromSharedURLMapByAction:(WWKURLNavigatorAction *)action
                                                                                 isVisible:(BOOL *)isVisible {
    *isVisible = NO;
    Class vcClass = nil;
    UIViewController<WWKURLNavigatorViewControllerProtocol> *vc = nil;
    NSString *toBeOpenLinkURLProtocol = [self composeLinkURLProtocolWithAction:action];
    
    for (NSString *mappedLinkURLProtocol in _urlNavigatorMap.sharedURLMap) {
        BOOL eq = [toBeOpenLinkURLProtocol isEqualToString:mappedLinkURLProtocol];
        
        if (eq) {
            vcClass = _urlNavigatorMap.sharedURLMap[mappedLinkURLProtocol];
            break;
        }
    }
    
    if (!!vcClass) {
        NSArray *viewControllers = [UIApplication sharedApplication].visibleNavigationController.viewControllers;
        
        for (UIViewController *viewController in viewControllers) {
            if ([viewController isKindOfClass:vcClass]
                && [viewController conformsToProtocol:@protocol(WWKURLNavigatorViewControllerProtocol)]) {
                vc = (UIViewController<WWKURLNavigatorViewControllerProtocol> *)viewController;
                *isVisible = YES;
                break;
            }
        }
        
        if (!vc) {
            if (![vcClass conformsToProtocol:@protocol(WWKURLNavigatorViewControllerProtocol)]) {
                NSAssert(NO, @"需要被TSURLNavigator导航的UIViewController以及其子类必须要\
                         实现TSURLNavigatorViewControllerProtocol。");
            }
            
            NSDictionary *queryOfURLPath = [self queryOfURLPath:action.urlPath];
            NSMutableDictionary *query = [NSMutableDictionary dictionary];
            [query setValuesForKeysWithDictionary:queryOfURLPath];
            [query setValuesForKeysWithDictionary:action.query];
            
            vc = [[vcClass alloc] initWithNavigatorURL:[NSURL URLWithString:action.urlPath] query:query];
        }
    }
    
    return vc;
}

- (UIViewController<WWKURLNavigatorViewControllerProtocol> *)findVCFromNormalURLMapByAction:(WWKURLNavigatorAction *)action {
    
    Class vcClass = nil;
    NSString *stoaryBoardName = nil;
    NSString *toBeOpenLinkURLProtocol = [self composeLinkURLProtocolWithAction:action];
    
    for (NSString *mappedLinkURLProtocol in _urlNavigatorMap.normalURLMap) {
        BOOL eq = [toBeOpenLinkURLProtocol isEqualToString:mappedLinkURLProtocol];
        
        if (eq) {
            vcClass = _urlNavigatorMap.normalURLMap[mappedLinkURLProtocol];
            stoaryBoardName = _urlNavigatorMap.stoaryboardMap[mappedLinkURLProtocol];
            break;
        }
    }
    
    if (!vcClass) {
        NSLog(@"未能打开url path [%@] 对应的页面。", action.urlPath);
        return nil;
    }
    
//    if (![vcClass conformsToProtocol:@protocol(TSURLNavigatorViewControllerProtocol)]) {
//        NSAssert(NO, @"需要被TSURLNavigator导航的UIViewController以及其子类必须要\
//                 实现TSURLNavigatorViewControllerProtocol。");
//    }
    
    NSDictionary *queryOfURLPath = [self queryOfURLPath:action.urlPath];
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    [query setValuesForKeysWithDictionary:queryOfURLPath];
    [query setValuesForKeysWithDictionary:action.query];
    
    UIViewController<WWKURLNavigatorViewControllerProtocol> *vc = nil;
    if (stoaryBoardName.length > 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:stoaryBoardName bundle:nil];
        if (storyboard) {
            vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(vcClass)];
            if ([vc respondsToSelector:@selector(setQuery:)]) {
                [vc setValue:query forKey:@"query"];
            }
        }
    }

    if (!vc) {
        if ([[[vcClass alloc] init] respondsToSelector:@selector(initWithNavigatorURL:query:)]) {
            vc = [[vcClass alloc] initWithNavigatorURL:[NSURL URLWithString:action.urlPath] query:query];
        } else {
            NSLog(@"未能打开url path [%@] 对应的页面。", action.urlPath);
        }
    }
    
    return vc;
}

- (NSString *)composeLinkURLProtocolWithAction:(WWKURLNavigatorAction *)action {
    NSURL *url = [NSURL URLWithString:[action.urlPath trim]];
    NSRange range = [url.absoluteString rangeOfString:@"?"];
    if ([url.absoluteString hasPrefix:@"http://"] || [url.absoluteString hasPrefix:@"https://"]) {
        return [[url.scheme stringByAppendingString:@"://"] lowercaseString];
    } else if (range.location != NSNotFound) {
        return [url.absoluteString substringToIndex:(range.location+range.length)];
    } else if ([url.absoluteString hasSuffix:@".html"]) {
        return @".html";
    }
    else {
        return url.absoluteString;
    }
}

- (NSDictionary *)queryOfURLPath:(NSString *)urlPath {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *slashSymbol = @"://";
    NSString *querySymbol = @"?";
    NSString *paramMapStr = nil;
    
    NSRange querySymbolRange = [urlPath rangeOfString:querySymbol];
    
    if (querySymbolRange.location != NSNotFound) {//带有问号
        paramMapStr = [urlPath substringFromIndex:querySymbolRange.location + 1];
    } else {//不带问号
        NSRange slashSymbolRange = [urlPath rangeOfString:slashSymbol];
        
        if (slashSymbolRange.location != NSNotFound) {//带有"//"
            paramMapStr = [urlPath substringFromIndex:slashSymbolRange.location + 3];
        } else {//不带"//"
            paramMapStr = urlPath;
        }
    }
    
    NSArray *paramertsMapArray = [paramMapStr componentsSeparatedByString:@"&"];
    
    for (NSString *parameterMap in paramertsMapArray) {
        NSArray *parametersArray = [parameterMap componentsSeparatedByString:@"="];
        
        if (parametersArray.count == 2) {
            NSString *key = parametersArray[0];
            NSString *value = parametersArray[1];
            
            if (key.length > 0 && value.length > 0) {
                parameters[key] = value;
            }
        }
    }
    
    return parameters;
}

@end