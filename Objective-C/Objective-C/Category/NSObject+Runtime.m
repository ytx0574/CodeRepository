//
//  NSObject+Runtime.m
//  Objective-C
//
//  Created by Johnson on 2017/5/12.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (NSArray *)enumerateIvarsFromClass:(Class)class block:(void(^)(NSUInteger idx, NSString *ivar))block;
{
    unsigned int outCount;
    
    NSMutableArray *ay = [NSMutableArray array];
    
    Ivar *ivars = class_copyIvarList(class, &outCount);
    
    for (NSUInteger i = 0; i < outCount; i++) {
        
        NSString *ivar = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        
        [ay addObject:ivar];
        
        block ? block(i, ivar) : nil;
        
    }
    
    return ay;
}

+ (NSArray *)enumeratePropertiesFromClass:(Class)class block:(void(^)(NSUInteger idx, NSString *property))block;
{
    unsigned int outCount;
    
    NSMutableArray *ay = [NSMutableArray array];
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        NSString *property = [NSString stringWithUTF8String:property_getName(properties[i])];
        
        [ay addObject:property];
        
        block ? block(i, property) : nil;
    }
    
    return ay;
}



- (NSArray *)enumerateIvarsWithBlock:(void(^)(NSUInteger idx, NSString *ivar, BOOL *stop))block;
{
    __block BOOL stop = NO;
    
    return [NSObject enumerateIvarsFromClass:[self class] block:^(NSUInteger idx, NSString *ivar) {
        
        if (!stop) {block ? block(idx, ivar, &stop) : nil;}
        
    }];
    
}

- (NSArray *)enumeratePropertiesWithBlock:(void(^)(NSUInteger idx, NSString *property, BOOL *stop))block;
{
    __block BOOL stop = NO;
    
    return [NSObject enumeratePropertiesFromClass:[self class] block:^(NSUInteger idx, NSString *property) {
        if (!stop) {block ? block(idx, property, &stop) : nil;}
    }];
    
}

@end
