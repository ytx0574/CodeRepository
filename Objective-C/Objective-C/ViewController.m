//
//  ViewController.m
//  Objective-C
//
//  Created by Johnson on 2017/5/26.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSThread *_thread;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMethod) object:nil];
    [_thread start];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)threadMethod
{
    @autoreleasepool {
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(xx) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)xx
{
    NSLog(@"________");
}


@end
