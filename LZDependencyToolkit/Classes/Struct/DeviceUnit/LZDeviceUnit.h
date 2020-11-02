//
//  LZDeviceUnit.h
//  LZDeviceUnit
//
//  Created by Dear.Q on 2017/11/10.
//  Copyright © 2017年 Dear.Q. All rights reserved.
//

#ifndef LZDeviceUnit_h
#define LZDeviceUnit_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

// MARK: - 类型定义 -
/// 设备朝向
typedef NS_ENUM(NSInteger, LZDeviceOrientation) {
    /// 未知
    LZDeviceOrientationUnknown = 0,
    /// 竖屏,home 键在下面
    LZDeviceOrientationPortrait,
    /// 竖屏,home 键在上面
    LZDeviceOrientationPortraitUpsideDown,
    /// 横屏,home 键在右面
    LZDeviceOrientationLandscapeLeft,
    /// 横屏,home 键在左面
    LZDeviceOrientationLandscapeRight,
    /// 正面朝上
    LZDeviceOrientationFaceUp,
    /// 正面朝下
    LZDeviceOrientationFaceDown
} __TVOS_PROHIBITED;

/// 设备界面类型
typedef NS_ENUM(NSInteger, LZUserInterfaceIdiom) {
    // 未知
    LZUserInterfaceIdiomUnspecified = -1,
    /// iPhone 和 iPod touch 风格的界面
    LZUserInterfaceIdiomPhone NS_ENUM_AVAILABLE_IOS(3_2),
    /// iPad 风格的界面
    LZUserInterfaceIdiomPad NS_ENUM_AVAILABLE_IOS(3_2),
    /// Apple 风格的界面
    LZUserInterfaceIdiomTV NS_ENUM_AVAILABLE_IOS(9_0),
    /// CarPlay 风格的界面
    LZUserInterfaceIdiomCarPlay NS_ENUM_AVAILABLE_IOS(9_0),
};

/// 设备电量状态
typedef NS_ENUM(NSInteger, LZDeviceBatteryState) {
    /// 未知
    LZDeviceBatteryStateUnknown = 0,
    /// 放电中,使用中
    LZDeviceBatteryStateUnplugged,
    /// 充电中,小于 100%
    LZDeviceBatteryStateCharging,
    /// 充电完毕,100%
    LZDeviceBatteryStateFull,
} __TVOS_PROHIBITED;

/// 设备型号
typedef NS_ENUM(NSInteger, LZDeviceGeneration) {
    // 模拟器
    LZDeviceGenerationSimulator = -1,
    // 真机
    // iPhone 型号
    LZDeviceGenerationiPhone1G = 0,
    LZDeviceGenerationiPhone3G,
    LZDeviceGenerationiPhone3GS,
    LZDeviceGenerationiPhone4,
    LZDeviceGenerationiPhone4S,
    LZDeviceGenerationiPhone5,
    LZDeviceGenerationiPhone5c,
    LZDeviceGenerationiPhone5s,
    LZDeviceGenerationiPhone6,
    LZDeviceGenerationiPhone6_plus,
    LZDeviceGenerationiPhone6s,
    LZDeviceGenerationiPhone6s_plus,
    LZDeviceGenerationiPhoneSE1st,
    LZDeviceGenerationiPhoneSE2nd,
    LZDeviceGenerationiPhone7,
    LZDeviceGenerationiPhone7_plus,
    LZDeviceGenerationiPhone8,
    LZDeviceGenerationiPhone8_plus,
    LZDeviceGenerationiPhoneX,
	LZDeviceGenerationiPhoneXR,
	LZDeviceGenerationiPhoneXS,
	LZDeviceGenerationiPhoneXS_max,
    LZDeviceGenerationiPhone11,
    LZDeviceGenerationiPhone11_pro,
    LZDeviceGenerationiPhone11_pro_max,
    LZDeviceGenerationiPhone12_mini,
    LZDeviceGenerationiPhone12,
    LZDeviceGenerationiPhone12_pro,
    LZDeviceGenerationiPhone12_pro_max,
    // iPod 型号
    LZDeviceGenerationiPodtouch1st,
    LZDeviceGenerationiPodtouch2nd,
    LZDeviceGenerationiPodtouch3rd,
    LZDeviceGenerationiPodtouch4th,
    LZDeviceGenerationiPodtouch5th,
    LZDeviceGenerationiPodtouch6th,
	LZDeviceGenerationiPodtouch7th,
    // iWatch 型号
    LZDeviceGenerationiWatch1st,
    LZDeviceGenerationiWatch_series1,
    LZDeviceGenerationiWatch_series2,
    LZDeviceGenerationiWatch_series3,
	LZDeviceGenerationiWatch_series4,
    LZDeviceGenerationiWatch_series5,
    LZDeviceGenerationiWatch_SE,
    LZDeviceGenerationiWatch_series6,
    // iPad 型号
    LZDeviceGenerationiPad1st,
    LZDeviceGenerationiPad2nd,
    LZDeviceGenerationiPad3rd,
    LZDeviceGenerationiPad4th,
    LZDeviceGenerationiPad5th,
	LZDeviceGenerationiPad6th,
    LZDeviceGenerationiPad7th,
    LZDeviceGenerationiPad8th,
    LZDeviceGenerationiPad_air1st,
    LZDeviceGenerationiPad_air2nd,
	LZDeviceGenerationiPad_air3rd,
    LZDeviceGenerationiPad_air4th,
    LZDeviceGenerationiPad_pro_inch_12__9_1st,
    LZDeviceGenerationiPad_pro_inch_12__9_2nd,
    LZDeviceGenerationiPad_pro_inch_12__9_3rd,
    LZDeviceGenerationiPad_pro_inch_12__9_4th,
    LZDeviceGenerationiPad_pro_inch_9__7,
    LZDeviceGenerationiPad_pro_inch_10__5,
    LZDeviceGenerationiPad_pro_inch_11_1st,
    LZDeviceGenerationiPad_pro_inch_11_2nd,
    LZDeviceGenerationiPad_mini1st,
    LZDeviceGenerationiPad_mini2nd,
    LZDeviceGenerationiPad_mini3rd,
    LZDeviceGenerationiPad_mini4th,
	LZDeviceGenerationiPad_mini5th,
    // iTV 型号
    LZDeviceGenerationiTV1st,
    LZDeviceGenerationiTV2nd,
    LZDeviceGenerationiTV3rd,
    LZDeviceGenerationiTV4th,
    LZDeviceGenerationiTV4K,
    // AirPods 型号
    LZDeviceGenerationAirPods1st,
    LZDeviceGenerationAirPods2nd,
    LZDeviceGenerationAirPods_pro,
    // 未知
    LZDeviceGenerationUnspecified,
};

struct LZDeviceUnit_type {
    /// 用户界面类型
    LZUserInterfaceIdiom (* userInterfaceIdiom)(void);
    
    /// 设备型号
    LZDeviceGeneration (* generation)(void);
    /// 设备型号描述
    NSString * (* generation_desc)(void);
    
    /// 设备 UUID
    NSString * (* UUID)(void);
    
    /// 设备别名，或者用户定义的名称
    NSString * (* name)(void);
    
    /// 设备类型名称
    NSString * (* model)(void);
    
    /// 国际化区域名称
    NSString * (* localizedModel)(void);
    
    /// 系统名称 e.g iOS
    NSString * (* systemName)(void);
    
    /// 系统版本
    NSString * (* systemVersion)(void);
    
    /// 设备朝向
    LZDeviceOrientation (* orientation)(void);
    
    /// 电池状态
    LZDeviceBatteryState (* batteryState)(void);
    /// 电池状态描述
    NSString * (* batteryState_desc)(void);
    
    /// 电池电量,0 .. 1.0. -1.0 if LZDeviceBatteryStateUnknown
    float (* batteryLevel)(void);
    /// 电池电量描述,百分比
    NSString * (* batteryLevel_desc)(void);
    
    /// 总磁盘空间,单位:Byte
    long long (* diskTotalSpace)(void);
    /// 总磁盘空间描述,单位:G
    NSString * (* diskTotalSpace_desc)(void);
    /// 剩余磁盘空间,单位:Byte
    long long (* diskFreeSpace)(void);
    /// 剩余磁盘空间描述,单位:G
    NSString * (* diskFreeSpace_desc)(void);
    
    /// 已使用磁盘空间,单位:Byte
    long long (* diskUsedSpace)(void);
    /// 已使用磁盘空间描述,单位:G
    NSString * (* diskUsedSpace_desc)(void);
    /// CPU 核数
    NSString * (* CPUCount)(void);
    /// CPU 使用率
    NSString * (* CPUUsageRate)(void);
    
    /// 最后一次重启时间
    NSDate * (* restartDate)(void);
    
    /// 是否是越狱设备
    BOOL (* is_jailbreak)(void);
    
    /// 是否是模拟器
    BOOL (* is_simulator)(void);
    /// 是否是 iPhone
    BOOL (* is_iPhone)(void);
    /// 是否是 iPad
    BOOL (* is_iPad)(void);
    /// 是否是iTV,仅支持 iOS9 以上
    BOOL (* is_iTV)(void);
    /// 是否是 CarPlay,仅支持 iOS9 以上
    BOOL (* is_carPlay)(void);
    
    /// ==，等于指定版本号
    BOOL (* version_equal_to)(NSString *version);
    /// >，大于指定版本号
    BOOL (* version_greater_than)(NSString *version);
    /// >=，大于等于指定版本号
    BOOL (* version_greater_than_or_equal_to)(NSString *version);
    /// <，小于指定版本号
    BOOL (* version_less_than)(NSString *version);
    /// <=，小于等于指定版本号
    BOOL (* version_less_than_or_equal_to)(NSString *version);
    
    /// 支持的语言列表
    NSArray * (* languages_support)(void);
    /// 当前语言全名,e.g zh-Hans-CN
    NSString * (* language_full_name)(void);
    /// 当前语言简写,e.g zh
    NSString * (* language_short_name)(void);
    
    /// 屏幕尺寸
    CGSize (* screen_size)(void);
    /// 屏幕的宽
    CGFloat (* screen_width)(void);
    /// 屏幕的高
    CGFloat (* screen_height)(void);
    /// 屏幕的最大长度
    CGFloat (* screen_max_lenght)(void);
    /// 屏幕的最小长度
    CGFloat (* screen_min_lenght)(void);
    /// 屏幕的 Scale
    CGFloat (* screen_scale)(void);
    /// 屏幕是否是 Retina
    BOOL (* screen_retina)(void);
	/// 屏幕是否是齐刘海
	BOOL (* is_notch)(void);
    
    /// 运营商名称 e.g 中国联通
    NSString * (* carrierName)(void);
};

FOUNDATION_EXTERN struct LZDeviceUnit_type LZDeviceInfo;

#endif
