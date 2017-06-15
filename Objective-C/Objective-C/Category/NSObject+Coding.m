//
//  NSObject+Coding.m
//  Objective-C
//
//  Created by Johnson on 2017/5/26.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "NSObject+Coding.h"
#import "NSObject+Runtime.h"

@implementation NSObject (Coding)

#pragma Private Methods

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    __weak typeof(self) wself = self;
    [self enumerateIvarsWithBlock:^(NSUInteger idx, NSString *ivar, BOOL *stop) {
        [aCoder encodeObject:[wself valueForKey:ivar] forKey:ivar];
    }];
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder;
{
    if (self = [self init]) {
        
        __weak typeof(self) wself = self;
        [self enumerateIvarsWithBlock:^(NSUInteger idx, NSString *ivar, BOOL *stop) {
            [wself setValue:[aDecoder decodeObjectForKey:ivar] forKey:ivar];
        }];
        
    }
    return self;
}

@end
