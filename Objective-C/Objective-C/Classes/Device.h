//
//  Device.h
//  Objective-C
//
//  Created by Johnson on 2017/5/26.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject

/**
 *  获取当前设备的名称 http://theiphonewiki.com/wiki/Models
 *
 *  @return 返回设备名称
 */
+ (NSString *)deviceType;

/**
 *  设备当前网络IP地址
 *
 *  @param preferIPv4 是否优先IPv4
 *
 *  @return IP
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/**
 *  验证IP格式
 *
 *  @param ipAddress 被验证的地址
 *
 *  @return yes/no
 */
+ (BOOL)isValidatIP:(NSString *)ipAddress;

/**
 *  获取ip详细信息
 *
 *  @return dictinfo
 */
+ (NSDictionary *)getIPAddresses;

/**
 *  判断VPN是否连接
 *
 *  @return yes/no
 */
+ (BOOL)isVPNConnected;

/**
 *  是否越狱
 *
 *  @return yes/no
 */
+ (BOOL)isJailbroken;

/**
 *  是否是App Store版本
 *
 *  @return yes/no
 */
+ (BOOL)isAppStoreVersion;

/**
 *  是否是破解包
 *
 *  @return yes/no
 */
+ (BOOL)isAppCracked;

/**
 *  获取当前设备可用内存(单位：MB）    该函数在运行时会有变化，得到的是应用当前的可用内存；应用的实际运行内存不等于 availableMemory + usedMemory
 *
 *  @return memory
 */
+ (double)availableMemory;

/**
 *  获取当前任务所占用的内存（单位：MB）
 *
 *  @return use memory
 */
+ (double)usedMemory;

/**
 *  当前Cpu使用情况
 *
 *  @return cpu use percentage
 */
+ (float)cpu_usage;

@end
