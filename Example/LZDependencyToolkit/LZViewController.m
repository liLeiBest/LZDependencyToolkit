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
#import "LZPerson.h"

@interface LZViewController ()

@property (nonatomic, strong) id observer;

@end

@implementation LZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupNavBarItem];
    [self deviceInfo];
    [self appInfo];
	[self crypto];
	[self quick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		LZQuickUnit.notificationPost(@"abc", @"2", nil);
	}];
	LZQuickUnit.alert(@"title", @"message", @[ok]);
}

#pragma mark - -> UI Action
- (void)leftDidClick {
    
    NSLog(@"点击了左边按钮");
	
	LZPerson *person = [[LZPerson alloc] init];
	NSLog(@"%@", person.properties);
}

- (void)rightDidClick {
    
    NSLog(@"点击了右边按钮");
	
	NSDictionary *dict = @{@"key":@"value",@"key1":@"value1",@"key2":@"value2",@"key3":@"value3",};
	NSLog(@"%@", dict.description);
	
	NSArray *array = @[@"key", @"key1", @"key2", @"key3"];
	NSLog(@"%@", array.description);
}

- (void)sysDidClick {

	NSLog(@"==%@", [@" a b C D" trimmingAllWhitespaceAndNewline]);
}

// MARK: - Private
- (void)setupNavBarItem {
    
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithTitle:@"左边按钮"
                       normalImage:@"fda"
                    highlightImage:@"abc"
                      disableImage:@"egf"
                            target:self
                            action:@selector(leftDidClick)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}
                                                         forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]}
                                                         forState:UIControlStateDisabled];
    
    UIBarButtonItem *right1 =
    [UIBarButtonItem itemWithTitle:@"右边自定"
                            target:self
                            action:@selector(rightDidClick)];
    self.navigationItem.rightBarButtonItems = @[right1];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}
                                                          forState:UIControlStateDisabled];
    UIBarButtonItem *sys = [[UIBarButtonItem alloc] initWithTitle:@"右边系统" style:UIBarButtonItemStyleDone target:self action:@selector(sysDidClick)];
    self.navigationItem.rightBarButtonItems = @[right1, sys];
}

- (void)quick {
	
	NSLog(@"CacheDir: %@", LZQuickUnit.cacheDir());
	NSLog(@"%@", LZQuickUnit.toString(@{@"key1": @"value1", @"key2":@"value2"}));
	
	void (^a)(NSNotification *note) = ^(NSNotification *note) {
		NSLog(@"noti: %@", note);
	};
	self.observer = LZQuickUnit.notificationObserver(@"abc", a);
}

- (void)crypto {
	
	NSString *plaintext = @"lilei";
	NSLog(@"MD5: %@", LZCryptoUnit.MD5(plaintext));
}

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
	NSLog(@"是否是齐刘海: %@", LZDeviceInfo.is_notch() ? @"YES" : @"NO");
}

@end
