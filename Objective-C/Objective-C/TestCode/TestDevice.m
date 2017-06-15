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
    
    NSLog(@"===%f  %f",  [Device usedMemory], [Device availableMemory]);
    
//    for (int i = 0; i < 5; i++) {
//        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"NSLogger-master" ofType:@"zip"] toPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/%d", i]  error:nil];
//    }
    
    

//    NSString *str = @"";
    static NSData *data = nil;
    static NSData *data1 = nil;
    static NSData *data2 = nil;
    static NSData *data3 = nil;
    static NSData *data4 = nil;
    static NSData *data5 = nil;
    
    data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"笑你妹c" ofType:@"txt"]];
    data1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"笑你妹c" ofType:@"txt"]];
    data2 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"笑你妹c" ofType:@"txt"]];
//    data3 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"笑你妹c" ofType:@"txt"]];
//    data4 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"笑你妹c" ofType:@"txt"]];
//    data5 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"笑你妹c" ofType:@"txt"]];
    NSLog(@"===%f  %f",  [Device usedMemory], [Device availableMemory]);
    
    
    NSLog(@"cpu usage:%f", [Device cpu_usage]);
    
//    while (true) {  //死循环的Cpu使用率竟然没有超过%60。。
//        NSLog(@"cpu usage:%f", [Device cpu_usage]);
//    }
    
}

@end
