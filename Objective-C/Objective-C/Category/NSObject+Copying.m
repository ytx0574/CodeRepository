//
//  NSObject+Copying.m
//  Objective-C
//
//  Created by Johnson on 2017/5/26.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "NSObject+Copying.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Copying)

- (void)copyValuesFromInstance:(id)instance
                 onlySelfClass:(BOOL)onlySelfClass
                        filter:(BOOL(^)(NSUInteger idx, NSString *ivar))block;
{
    
    void (^cycleBlock)(Class class) = ^(Class class){
        
        [NSObject enumerateIvarsFromClass:class block:^(NSUInteger idx, NSString *ivar) {
            
            Ivar ivar_instance = class_getInstanceVariable([instance class], [ivar UTF8String]);
            Ivar ivar_self = class_getInstanceVariable(class, [ivar UTF8String]);
            
            const char *ivar_instanceTypeEncoding = ivar_getTypeEncoding(ivar_instance);
            const char *ivar_selfTypeEncoding = ivar_getTypeEncoding(ivar_self);
            
            //如果被复制的对象没有对应的字段 或者 两者对应的字段编码类型不一致, 则不进行值得复制
            if (ivar_getName(ivar_instance) && ivar_instanceTypeEncoding == ivar_selfTypeEncoding) {
                
                //通过block控制哪些字段值 不复制
                BOOL flag = block ? block(idx, ivar) : YES;
                
                flag ? [self setValue:[instance valueForKey:ivar] forKey:ivar] : nil;
                
            }
            
        }];
        
    };
    
    
    cycleBlock([self class]);
    
    
    //onlySelfClass为真, 仅从当前对象类中获取ivar, 反之递归父类的ivar列表进行复制
    if (onlySelfClass) {
        return;
    }
    
    Class class = [self superclass];
    while (class != [NSObject class]) {
        
        cycleBlock(class);
        class = [class superclass];
    }
    
}


#pragma Private Methods

- (id)copyWithZone:(nullable NSZone *)zone;
{
    return self;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone;
{
    id value = [[[self class] allocWithZone:zone] init];
    
    __weak typeof(self) wself = self;
    [self enumerateIvarsWithBlock:^(NSUInteger idx, NSString *ivar, BOOL *stop) {
        [value setValue:[wself valueForKey:ivar] forKey:ivar];
    }];
    
    return value;
}

@end
