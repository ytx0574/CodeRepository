//
//  NSObject+Copying.h
//  Objective-C
//
//  Created by Johnson on 2017/5/26.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  如NSArray NSDictionary等自实现了copy, 而且优先级比这个方法高, 不用担心出问题
 */

@interface NSObject (Copying)

/**
 *  从其他的实例复制ivar字段到本类
 *
 *  @param instance      被复制的对象
 *  @param onlySelfClass 是否仅从instance复制本类包含的ivar字段, 如果为NO, 会继续从instance复制superclass的ivar字段
 *  @param block         选择性复制字段, 为nil则复制所有
 */
- (void)copyValuesFromInstance:(id)instance
                 onlySelfClass:(BOOL)onlySelfClass
                        filter:(BOOL(^)(NSUInteger idx, NSString *ivar))block;

@end
