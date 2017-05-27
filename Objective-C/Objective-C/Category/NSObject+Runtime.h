//
//  NSObject+Runtime.h
//  Objective-C
//
//  Created by Johnson on 2017/5/12.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

/**
 *  获取class所有的ivar
 *
 *  @param class class
 *  @param block 获取字段时的循环回调
 *
 *  @return class的ivar数组
 */
+ (NSArray *)enumerateIvarsFromClass:(Class)class block:(void(^)(NSUInteger idx, NSString *ivar))block;

/**
 *  获取class所有的property
 *
 *  @param class class
 *  @param block 获取字段时的循环回调
 *
 *  @return class的property数组
 */
+ (NSArray *)enumeratePropertiesFromClass:(Class)class block:(void(^)(NSUInteger idx, NSString *property))block;

/**
 *  获取当前对象所有的ivar
 *
 *  @param block 获取字段时的循环回调, stop为YES, block不再回调.
 *
 *  @return 当前对象的ivar数组
 */
- (NSArray *)enumerateIvarsWithBlock:(void(^)(NSUInteger idx, NSString *ivar, BOOL *stop))block;

/**
 *  获取当前对象所有的property
 *
 *  @param block 获取字段时的循环回调, stop为YES, block不再回调.
 *
 *  @return 当前对象的property数组
 */
- (NSArray *)enumeratePropertiesWithBlock:(void(^)(NSUInteger idx, NSString *property, BOOL *stop))block;


@end
