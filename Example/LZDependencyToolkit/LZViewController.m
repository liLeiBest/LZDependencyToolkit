//
//  LZViewController.m
//  LZDependencyToolkit
//
//  Created by lilei_hapy@163.com on 11/14/2017.
//  Copyright (c) 2017 lilei_hapy@163.com. All rights reserved.
//

#import "LZViewController.h"
#import <LZDependencyToolKit/LZDependencyUnit.h>

@interface LZViewController ()

@end

@implementation LZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self deviceInfo];
    [self appInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

// MARK: - Private
- (void)appInfo {
    
    NSLog(@"%@", LZAppInfo.name());
    NSLog(@"%@", LZAppInfo.bundleID());
    NSLog(@"%@", LZAppInfo.version());
    NSLog(@"%@", LZAppInfo.build());
    NSLog(@"%@", LZAppInfo.compareBuild(@"12") ? @"YES" : @"NO");
    NSLog(@"%@", LZAppInfo.compareVersion(@"10.2.1") ? @"YES" : @"NO");
}

- (void)deviceInfo {
    
    NSLog(@"设备型号:%@",LZDeviceInfo.generation_string());
    NSLog(@"手机别名: %@", LZDeviceInfo.name());
    NSLog(@"系统名称: %@", LZDeviceInfo.systemName());
    NSLog(@"手机系统版本: %@", LZDeviceInfo.systemVersion());
    NSLog(@"国际化区域名称: %@",LZDeviceInfo.localizedModel());
    NSLog(@"运营商:%@", LZDeviceInfo.carrierName());
    NSLog(@"电池状态：%@", LZDeviceInfo.batteryState_string());
    NSLog(@"电池电量%@", LZDeviceInfo.batteryLevel_string());
    NSLog(@"设备方向%ld", (long)LZDeviceInfo.orientation());
}

@end
