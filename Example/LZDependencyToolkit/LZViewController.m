//
//  LZViewController.m
//  LZDependencyToolkit
//
//  Created by lilei_hapy@163.com on 11/14/2017.
//  Copyright (c) 2017 lilei_hapy@163.com. All rights reserved.
//

#import "LZViewController.h"
#import "LZDependencyToolkit.h"
#import <sys/mount.h>
#import <sys/sysctl.h>
#import <mach/mach.h>

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

    NSLog(@"App Name: %@", LZAppInfo.name());
    NSLog(@"App Bunle ID: %@", LZAppInfo.bundleID());
    NSLog(@"App Version: %@", LZAppInfo.version());
    NSLog(@"App Build: %@", LZAppInfo.build());
    NSLog(@"Build 比较: %@", LZAppInfo.compareBuild(@"12") ? @"YES" : @"NO");
    NSLog(@"Version 比较: %@", LZAppInfo.compareVersion(@"10.2.1") ? @"YES" : @"NO");
}

- (void)deviceInfo {
    
    NSLog(@"设备型号: %@",LZDeviceInfo.generation_desc());
    NSLog(@"手机别名: %@", LZDeviceInfo.name());
    NSLog(@"系统名称: %@", LZDeviceInfo.systemName());
    NSLog(@"手机系统版本: %@", LZDeviceInfo.systemVersion());
    NSLog(@"国际化区域名称: %@",LZDeviceInfo.localizedModel());
    NSLog(@"设备方向: %ld", (long)LZDeviceInfo.orientation());
    NSLog(@"运营商: %@", LZDeviceInfo.carrierName());
    NSLog(@"电池状态: %@", LZDeviceInfo.batteryState_desc());
    NSLog(@"电池电量: %@", LZDeviceInfo.batteryLevel_desc());
    NSLog(@"磁盘总空间: %@", LZDeviceInfo.diskTotalSpace_desc());
    NSLog(@"磁盘剩余空间: %@", LZDeviceInfo.diskFreeSpace_desc());
    NSLog(@"磁盘已用空间: %@", LZDeviceInfo.diskUsedSpace_desc());
    NSLog(@"CPU 核数: %@", LZDeviceInfo.CPUCount());
    NSLog(@"CPU 使用率: %@", LZDeviceInfo.CPUUsageRate());
    NSLog(@"最后一次重启时间: %@", [LZDeviceInfo.restartDate() dateFormat:@"yyyy-MM-dd aa HH:mm:ss.S EEEE Z"]);
}

@end
