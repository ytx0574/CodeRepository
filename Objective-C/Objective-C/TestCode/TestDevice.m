//
//  TestDevice.m
//  Objective-C
//
//  Created by Johnson on 2017/5/26.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "TestDevice.h"
#import "Device.h"

@implementation TestDevice

+ (void)test;
{
    NSLog(@"%@ %d  %@", [Device getIPAddresses], [Device isVPNConnected], [Device getIPAddress:NO]);
}

@end
