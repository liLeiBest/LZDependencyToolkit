//
//  LZViewController.m
//  LZDependencyToolkit
//
//  Created by lilei_hapy@163.com on 11/14/2017.
//  Copyright (c) 2017 lilei_hapy@163.com. All rights reserved.
//

#import "LZViewController.h"
#import <sys/mount.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import "LZStudent.h"

@interface LZViewController ()

@property (nonatomic, weak) IBOutlet UIButton *eventClickTestBtn;
@property (nonatomic, weak) IBOutlet UIButton *touchExtendTestBtn;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) id observer;
@property (nonatomic, strong) LZWeakTimer *time;

@end

@implementation LZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self setupNavBarItem];
//    [self deviceInfo];
//    [self appInfo];
//    [self crypto];
//    [self quick];
//    [self customDescription];
}

#pragma mark - -> UI Action
- (IBAction)touchExtendTest:(UIButton *)sender {
    LZLog();
    [self crypto];
}

- (IBAction)eventIntervalTest:(UIButton *)sender {
    LZLog();
}

- (void)leftDidClick {
    LZLog(@"点击了左边按钮");
    
    NSDate *date = [NSDate dateFormatToDate:@"2020-5-24 00:01:00" formats:@[@"yyyy-MM-dd HH-mm-ss"]];
    NSString *timestamp = [date timeStamp];
    NSString *describe = [NSDate dateFormatToTimeIntervalOrYMDFromHistory:timestamp];
    NSLog(@"====%@", describe);
}

- (void)rightDidClick {
    LZLog(@"点击了右边按钮");
}

- (void)sysDidClick {
	LZLog(@"点击了右边系统按钮");
    
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
	
	NSLog(@"%@", LZQuickUnit.toString(@{@"key1": @"value1", @"key2":@"value2"}));
    NSLog(@"%@", LZQuickUnit.toString(@[@"key1", @"key2"]));
	
	void (^a)(NSNotification *note) = ^(NSNotification *note) {
		NSLog(@"noti: %@", note);
	};
	self.observer = LZQuickUnit.notificationObserver(@"abc", a);
}

- (void)crypto {
	
	NSString *plaintext = @"lilei";
	NSLog(@"MD5: %@", LZCryptoUnit.MD5(plaintext));
    
    NSString *key = @"abcdefghijklmn";
    key = @"123456789";
//    key = @"12345";
    NSString *des = LZCryptoUnit.DES_Encrypt(plaintext, key);
    NSLog(@"\nDES_Encrypt: %@", des);
    NSLog(@"\nDES_Decrypt: %@", LZCryptoUnit.DES_Decrypt(des, key));
    
    NSString *des3 = LZCryptoUnit.TDES_Encrypt(plaintext, key);
    NSLog(@"\nDES3_Encrypt: %@", des3);
    NSLog(@"\nDES3_Decrypt: %@", LZCryptoUnit.TDES_Decrypt(des3, key));
}

- (void)appInfo {

    NSLog(@"App Name: %@", LZAppUnit.name());
    NSLog(@"App Bunle ID: %@", LZAppUnit.bundleID());
    NSLog(@"App Version: %@", LZAppUnit.version());
    NSLog(@"App Build: %@", LZAppUnit.build());
    NSLog(@"Build 比较: %@", LZAppUnit.compareBuild(@"12") ? @"YES" : @"NO");
    NSLog(@"Version 比较: %@", LZAppUnit.compareVersion(@"10.2.1") ? @"YES" : @"NO");
    
    NSLog(@"\nCacheDir: %@", LZAppUnit.cacheDir());
    
    NSLog(@"\nLibraryDirectory: %@", LZAppUnit.searchDir(NSLibraryDirectory));
    NSLog(@"\nLibraryDirectory: %@", LZAppUnit.searchDir(NSLibraryDirectory));
    NSLog(@"\nSDocumentationDirectory: %@", LZAppUnit.searchDir(NSDocumentationDirectory));
    NSLog(@"\nLibrarySubDirectory: %@", LZAppUnit.searchSubDir(NSLibraryDirectory, @"abc"));
    
    NSString *fullPath;
    BOOL success = LZAppUnit.createCacheSubDir(@"abc/efg", &fullPath);
    NSLog(@"Crate Cache SubPath: %@ \n%@", success?@"成功":@"失败", fullPath);
    success = LZAppUnit.createDocumentSubDir(@"abc/哈哈", &fullPath);
    NSLog(@"Crate Document SubPath: %@ \n%@", success?@"成功":@"失败", fullPath);
    success = LZAppUnit.createDocumentSubDir(@"abc/哈哈/efg", &fullPath);
       NSLog(@"Crate Document SubPath: %@ \n%@", success?@"成功":@"失败", fullPath);
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

- (void)customDescription {
    
    NSDictionary *dict = @{@"key":@"value",@"key1":@"value1",@"key2":@"value2",@"key3":@"value3",};
    NSLog(@"%@", dict.description);
    NSLog(@"%@", dict.lz_parameterString);
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSLog(@"%@", dictM.description);
    
    NSArray *array = @[@"key", @"key1", @"key2", @"key3"];
    NSLog(@"%@", array.description);
    NSLog(@"%@", array.lz_parameterString);
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
    NSLog(@"%@", arrayM.description);
    
    LZPerson *person = [[LZPerson alloc] init];
    person.name = @"Zhangsan";
    person.age = 20;
    person.sex = @"1";
    NSLog(@"%@", person);
    
    LZStudent *student = [[LZStudent alloc] init];
    student.name = @"Lisi";
    student.age = 18;
    student.sex = @"0";
    student.school = @"xxx";
    student.grade = @"5";
    student.graduation = YES;
    student.graduateCallback = ^{
    };
    LZBook *book = [[LZBook alloc] init];
    book.name = @"正面教育 100 讲";
    book.author = @"阿三";
    book.price = 10.00;
    student.book = book;
    NSLog(@"%@", student);
}

- (void)roundImageView {
    
    UIImage *image = [UIImage imageWithColor:LZOrangeColor size:CGSizeMake(100, 100) isRound:YES];
    self.imgView.image = image;
}

- (void)weakTimer {
    self.time =
    [[LZWeakTimer alloc] initWithTimeInterval:1 repeats:YES dispatchQueue:dispatch_get_main_queue() eventHandler:^{
        
        self.time.tolerance = 1.0f;
        static NSUInteger number = 0;
        number++;
        NSLog(@"%@ %@", @"============", LZQuickUnit.toString(@(number)));
        if (number >= 10) {
            [self.time invalidate];
        }
    }];
    self.time.tolerance = 1.0f;
    [self.time schedule];
}

- (void)machineCode {
    
    self.imgView.image = [UIImage barCodeImageWithString:@"123456"];
    
    UIImage *centerImg = [UIImage imageNamed:@"timg"];
    self.imgView.image = [centerImg QRCodeImageWithString:@"只是一个羊" size:500 fillColor:[UIColor magentaColor]];
}

- (void)sreenShort {
    
    self.imgView.image = [self.imgView onScreenShort];
}

- (void)extendBtnHit {
    
    self.eventClickTestBtn.eventInterval = 2.0f;
    self.touchExtendTestBtn.hitEdgeInsets = UIEdgeInsetsMake(-50, -20, -20, -20);
}

@end
