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
    LZUserInterfaceIdiomPhone API_AVAILABLE(ios(3.2)),
    /// iPad 风格的界面
    LZUserInterfaceIdiomPad API_AVAILABLE(ios(3.2)),
    /// Apple 风格的界面
    LZUserInterfaceIdiomTV API_AVAILABLE(ios(9.0)),
    /// CarPlay 风格的界面
    LZUserInterfaceIdiomCarPlay API_AVAILABLE(ios(9.0)),
    /// Mac
    LZUserInterfaceIdiomMac API_AVAILABLE(ios(14.0))
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
    LZDeviceGenerationiPhoneSE3rd,
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
    LZDeviceGenerationiPhone13_mini,
    LZDeviceGenerationiPhone13,
    LZDeviceGenerationiPhone13_pro,
    LZDeviceGenerationiPhone13_pro_max,
    LZDeviceGenerationiPhone14,
    LZDeviceGenerationiPhone14_plus,
    LZDeviceGenerationiPhone14_pro,
    LZDeviceGenerationiPhone14_pro_max,
    LZDeviceGenerationiPhone15,
    LZDeviceGenerationiPhone15_plus,
    LZDeviceGenerationiPhone15_pro,
    LZDeviceGenerationiPhone15_pro_max,
    LZDeviceGenerationiPhone16,
    LZDeviceGenerationiPhone16_plus,
    LZDeviceGenerationiPhone16_pro,
    LZDeviceGenerationiPhone16_pro_max,
    LZDeviceGenerationiPhone16e,
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
    LZDeviceGenerationiWatch_SE_1st,
    LZDeviceGenerationiWatch_SE_2nd,
    LZDeviceGenerationiWatch_series6,
    LZDeviceGenerationiWatch_series7,
    LZDeviceGenerationiWatch_series8,
    LZDeviceGenerationiWatch_ultra_1st,
    // iPad 型号
    LZDeviceGenerationiPad1st,
    LZDeviceGenerationiPad2nd,
    LZDeviceGenerationiPad3rd,
    LZDeviceGenerationiPad4th,
    LZDeviceGenerationiPad5th,
	LZDeviceGenerationiPad6th,
    LZDeviceGenerationiPad7th,
    LZDeviceGenerationiPad8th,
    LZDeviceGenerationiPad9th,
    LZDeviceGenerationiPad10th,
    LZDeviceGenerationiPad_air1st,
    LZDeviceGenerationiPad_air2nd,
	LZDeviceGenerationiPad_air3rd,
    LZDeviceGenerationiPad_air4th,
    LZDeviceGenerationiPad_air5th,
    LZDeviceGenerationiPad_pro_inch_12__9_1st,
    LZDeviceGenerationiPad_pro_inch_12__9_2nd,
    LZDeviceGenerationiPad_pro_inch_12__9_3rd,
    LZDeviceGenerationiPad_pro_inch_12__9_4th,
    LZDeviceGenerationiPad_pro_inch_12__9_5th,
    LZDeviceGenerationiPad_pro_inch_9__7,
    LZDeviceGenerationiPad_pro_inch_10__5,
    LZDeviceGenerationiPad_pro_inch_11_1st,
    LZDeviceGenerationiPad_pro_inch_11_2nd,
    LZDeviceGenerationiPad_pro_inch_11_3rd,
    LZDeviceGenerationiPad_mini1st,
    LZDeviceGenerationiPad_mini2nd,
    LZDeviceGenerationiPad_mini3rd,
    LZDeviceGenerationiPad_mini4th,
	LZDeviceGenerationiPad_mini5th,
    LZDeviceGenerationiPad_mini6th,
    // HomePod 型号
    LZDeviceGenerationiHomePod_1st,
    LZDeviceGenerationiHomePod_mini1st,
    // iTV 型号
    LZDeviceGenerationiTV1st,
    LZDeviceGenerationiTV2nd,
    LZDeviceGenerationiTV3rd,
    LZDeviceGenerationiTV4th,
    LZDeviceGenerationiTV4K_1st,
    LZDeviceGenerationiTV4K_2nd,
    // AirPods 型号
    LZDeviceGenerationAirPods_1st,
    LZDeviceGenerationAirPods_2nd,
    LZDeviceGenerationAirPods_3rd,
    LZDeviceGenerationAirPods_pro_1st,
    LZDeviceGenerationAirPods_pro_2nd,
    LZDeviceGenerationAirPods_max,
    // AirTag 型号
    LZDeviceGenerationAirTag_1st,
    // Mac 型号
    LZDeviceGenerationiMac_Y2009,
    LZDeviceGenerationiMac_inch_21__5_Y2010,
    LZDeviceGenerationiMac_inch_27_Y2010,
    LZDeviceGenerationiMac_inch_21__5_Y2011,
    LZDeviceGenerationiMac_inch_27_Y2011,
    LZDeviceGenerationiMac_inch_21__5_Y2012,
    LZDeviceGenerationiMac_inch_27_Y2012,
    LZDeviceGenerationiMac_inch_21__5_Y2013,
    LZDeviceGenerationiMac_inch_27_Y2013,
    LZDeviceGenerationiMac_inch_21__5_Y2014,
    LZDeviceGenerationiMac_inch_27_5K_Y2014,
    LZDeviceGenerationiMac_inch_21__5_Y2015,
    LZDeviceGenerationiMac_inch_21__5_4K_Y2015,
    LZDeviceGenerationiMac_inch_27_5K_Y2015,
    LZDeviceGenerationiMac_inch_21__5_Y2017,
    LZDeviceGenerationiMac_inch_21__5_4K_Y2017,
    LZDeviceGenerationiMac_inch_27_5K_Y2017,
    LZDeviceGenerationiMac_pro_inch_27_5K_Y2017,
    LZDeviceGenerationiMac_inch_21__5_4K_Y2019,
    LZDeviceGenerationiMac_inch_27_5K_Y2019,
    LZDeviceGenerationiMac_inch_27_5K_Y2020,
    LZDeviceGenerationiMac_inch_24_m1_Y2021,
    LZDeviceGenerationiMac_inch_24_m3_Y2023,
    LZDeviceGenerationiMac_inch_24_m4_Y2024,
    
    LZDeviceGenerationMacBook_inch_13_Y2009,
    LZDeviceGenerationMacBook_inch_13_Y2010,
    LZDeviceGenerationMacBook_inch_12_Y2015,
    LZDeviceGenerationMacBook_inch_12_Y2016,
    LZDeviceGenerationMacBook_inch_12_Y2017,
    
    LZDeviceGenerationMacBook_air_inch_13_Y2009,
    LZDeviceGenerationMacBook_air_inch_11_Y2010,
    LZDeviceGenerationMacBook_air_inch_13_Y2010,
    LZDeviceGenerationMacBook_air_inch_11_Y2011,
    LZDeviceGenerationMacBook_air_inch_13_Y2011,
    LZDeviceGenerationMacBook_air_inch_11_Y2012,
    LZDeviceGenerationMacBook_air_inch_13_Y2012,
    LZDeviceGenerationMacBook_air_inch_11_Y2013,
    LZDeviceGenerationMacBook_air_inch_13_Y2013,
    LZDeviceGenerationMacBook_air_inch_11_Y2014,
    LZDeviceGenerationMacBook_air_inch_13_Y2014,
    LZDeviceGenerationMacBook_air_inch_11_Y2015,
    LZDeviceGenerationMacBook_air_inch_13_Y2015,
    LZDeviceGenerationMacBook_air_inch_13_Y2017,
    LZDeviceGenerationMacBook_air_inch_13_Y2018,
    LZDeviceGenerationMacBook_air_inch_13_Y2019,
    LZDeviceGenerationMacBook_air_inch_13_Y2020,
    LZDeviceGenerationMacBook_air_inch_13_m1_Y2020,
    LZDeviceGenerationMacBook_air_inch_13_m2_Y2022,
    LZDeviceGenerationMacBook_air_inch_15_m2_Y2023,
    LZDeviceGenerationMacBook_air_inch_13_m3_Y2024,
    LZDeviceGenerationMacBook_air_inch_15_m3_Y2024,
    LZDeviceGenerationMacBook_air_inch_13_m4_Y2025,
    LZDeviceGenerationMacBook_air_inch_15_m4_Y2025,
    
    LZDeviceGenerationMac_pro_m1_inch_13_1st,
    LZDeviceGenerationMac_pro_m1_inch_14_1st,
    LZDeviceGenerationMac_pro_m1_inch_16_1st,
    
    LZDeviceGenerationMacMini_Y2009,
    LZDeviceGenerationMacMini_Y2010,
    LZDeviceGenerationMacMini_Y2011,
    LZDeviceGenerationMacMini_Y2012,
    LZDeviceGenerationMacMini_Y2014,
    LZDeviceGenerationMacMini_Y2018,
    LZDeviceGenerationMacMini_Y2020,
    LZDeviceGenerationMacMini_m1_Y2020,
    LZDeviceGenerationMacMini_m2_Y2023,
    LZDeviceGenerationMacMini_m2_pro_Y2023,
    LZDeviceGenerationMacMini_m4_Y2024,
    
    LZDeviceGenerationMacStudio_m1_ultra_Y2022,
    LZDeviceGenerationMacStudio_m1_max_Y2022,
    LZDeviceGenerationMacStudio_m2_ultra_Y2023,
    LZDeviceGenerationMacStudio_m2_max_Y2023,
    LZDeviceGenerationMacStudio_m3_ultra_Y2025,
    LZDeviceGenerationMacStudio_m4_max_Y2025,
    
    LZDeviceGenerationMacPro_Y2009,
    LZDeviceGenerationMacPro_Y2010,
    LZDeviceGenerationMacPro_Y2012,
    LZDeviceGenerationMacPro_Y2013,
    LZDeviceGenerationMacPro_Y2019,
    LZDeviceGenerationMacPro_Y2023,
    
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
    
    /// 创建 UUID
    NSString * (* uuid_create)(void);
    
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
    int64_t (* diskTotalSpace)(void);
    /// 总磁盘空间描述,单位:G
    NSString * (* diskTotalSpace_desc)(void);
    /// 剩余磁盘空间,单位:Byte
    int64_t (* diskFreeSpace)(void);
    /// 剩余磁盘空间描述,单位:G
    NSString * (* diskFreeSpace_desc)(void);
    /// 已使用磁盘空间,单位:Byte
    int64_t (* diskUsedSpace)(void);
    /// 已使用磁盘空间描述,单位:G
    NSString * (* diskUsedSpace_desc)(void);
    
    /// 总内存
    UInt64 (* memoryTotalSpace)(void);
    /// 总内存描述,单位:G
    NSString * (* memoryTotalSpace_desc)(void);
    /// 可用内存
    UInt64 (* memoryAvaiableSpace)(void);
    /// 可用内存描述,单位:M
    NSString * (* memoryAvaiableSpace_desc)(void);
    /// 内存使用
    UInt64 (* memoryUsedSpace)(void);
    /// 内存使用描述,单位:M
    NSString * (* memoryUsedSpace_desc)(void);
    
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
    /// 是否是iTV,
    BOOL (* is_iTV)(void);
    /// 是否是 CarPlay
    BOOL (* is_carPlay)(void);
    /// 是否是 Mac,仅支持 iOS14 以上
    BOOL (* is_mac)(void);
    
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
    /// 获取当前网速，上行：upSpeed；下行：downSpeed
    NSDictionary * (* currentNetSpeed)(void);
};

FOUNDATION_EXTERN struct LZDeviceUnit_type LZDeviceInfo;

#endif
