//
//  NSString+Compare.h
//  Fund
//
//  Created by JiaLei on 6/20/16.
//  Copyright © 2016 WealthWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Compare)

- (BOOL)startWith:(NSString *)s1;

- (BOOL)endWith:(NSString *)s1;

- (NSString *)trim;

- (BOOL)isEqualToStringIgnoreCase:(NSString *)aString;

@end
