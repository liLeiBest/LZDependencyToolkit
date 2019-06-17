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

typedef NS_ENUM(NSInteger, LZDeviceOrientation) {
    LZDeviceOrientationUnknown = 0,
    LZDeviceOrientationPortrait,            // 竖屏,home 键在下面
    LZDeviceOrientationPortraitUpsideDown,  // 竖屏,home 键在上面
    LZDeviceOrientationLandscapeLeft,       // 横屏,home 键在右面
    LZDeviceOrientationLandscapeRight,      // 横屏,home 键在左面
    LZDeviceOrientationFaceUp,              // 正面朝上
    LZDeviceOrientationFaceDown             // 正面朝下
} __TVOS_PROHIBITED;

typedef NS_ENUM(NSInteger, LZUserInterfaceIdiom) {
    LZUserInterfaceIdiomUnspecified = -1,
    LZUserInterfaceIdiomPhone NS_ENUM_AVAILABLE_IOS(3_2),   // iPhone 和 iPod touch 风格的界面
    LZUserInterfaceIdiomPad NS_ENUM_AVAILABLE_IOS(3_2),     // iPad 风格的界面
    LZUserInterfaceIdiomTV NS_ENUM_AVAILABLE_IOS(9_0),      // Apple 风格的界面
    LZUserInterfaceIdiomCarPlay NS_ENUM_AVAILABLE_IOS(9_0), // CarPlay 风格的界面
};

typedef NS_ENUM(NSInteger, LZDeviceBatteryState) {
    LZDeviceBatteryStateUnknown = 0,
    LZDeviceBatteryStateUnplugged,   // 放电中,使用中
    LZDeviceBatteryStateCharging,    // 充电中,小于 100%
    LZDeviceBatteryStateFull,        // 充电完毕,100%
} __TVOS_PROHIBITED;

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
    LZDeviceGenerationiPhoneSE,
    LZDeviceGenerationiPhone7,
    LZDeviceGenerationiPhone7_plus,
    LZDeviceGenerationiPhone8,
    LZDeviceGenerationiPhone8_plus,
    LZDeviceGenerationiPhoneX,
	LZDeviceGenerationiPhoneXR,
	LZDeviceGenerationiPhoneXS,
	LZDeviceGenerationiPhoneXS_max,
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
    // iPad 型号
    LZDeviceGenerationiPad,
    LZDeviceGenerationiPad2,
    LZDeviceGenerationiPad3,
    LZDeviceGenerationiPad4,
    LZDeviceGenerationiPad5,
	LZDeviceGenerationiPad6,
    LZDeviceGenerationiPad_air,
    LZDeviceGenerationiPad_air2,
	LZDeviceGenerationiPad_air3,
    LZDeviceGenerationiPad_pro_inch_9__7,
    LZDeviceGenerationiPad_pro_inch_12__9,
    LZDeviceGenerationiPad_pro_inch_12__9_2nd,
    LZDeviceGenerationiPad_pro_inch_10__5,
	LZDeviceGenerationiPad_pro_inch_11,
	LZDeviceGenerationiPad_pro_inch_12__9_3nd,
    LZDeviceGenerationiPad_mini,
    LZDeviceGenerationiPad_mini2,
    LZDeviceGenerationiPad_mini3,
    LZDeviceGenerationiPad_mini4,
	LZDeviceGenerationiPad_mini5,
    // iTV 型号
    LZDeviceGenerationiTV2nd,
    LZDeviceGenerationiTV3rd,
    LZDeviceGenerationiTV4th,
    LZDeviceGenerationiTV4K,
    // 未知
    LZDeviceGenerationUnspecified,
};

struct LZDeviceUnit_type {
    
    // MARK: - • 设备信息
    /** 
     *  用户界面类型
     */
    LZUserInterfaceIdiom (* userInterfaceIdiom)(void);
    
    /**
     *  型号
     */
    LZDeviceGeneration (* generation)(void);
    
    /** 
     *  型号描述
     */
    NSString * (* generation_desc)(void);
    
    /** 
     *  UUID
     */
    NSString * (* UUID)(void);
    
    /** 
     *  别名,用户定义的名称
     */
    NSString * (* name)(void);
    
    /** 
     *  设备类型名称
     */
    NSString * (* model)(void);
    
    /** 
     *  国际化区域名称
     */
    NSString * (* localizedModel)(void);
    
    /** 
     *  系统名称 e.g iOS
     */
    NSString * (* systemName)(void);
    
    /** 
     *  系统版本
     */
    NSString * (* systemVersion)(void);
    
    /** 
     *  朝向
     */
    LZDeviceOrientation (* orientation)(void);
    
    /** 
     *  电池状态
     */
    LZDeviceBatteryState (* batteryState)(void);
    
    /** 
     *  电池状态描述
     */
    NSString * (* batteryState_desc)(void);
    
    /** 
     *  电池电量,0 .. 1.0. -1.0 if LZDeviceBatteryStateUnknown
     */
    float (* batteryLevel)(void);
    
    /** 
     *  电池电量描述,百分比
     */
    NSString * (* batteryLevel_desc)(void);
    
    /** 
     *  总磁盘空间,单位:Byte
     */
    long long (* diskTotalSpace)(void);
    
    /** 
     *  总磁盘空间描述,单位:G
     */
    NSString * (* diskTotalSpace_desc)(void);
    
    /** 
     *  剩余磁盘空间,单位:Byte
     */
    long long (* diskFreeSpace)(void);
    
    /** 
     *  剩余磁盘空间描述,单位:G 
     */
    NSString * (* diskFreeSpace_desc)(void);
    
    /** 
     *  已使用磁盘空间,单位:Byte
     */
    long long (* diskUsedSpace)(void);
    
    /** 
     *  已使用磁盘空间描述,单位:G 
     */
    NSString * (* diskUsedSpace_desc)(void);
    
    /** 
     *  CPU 核数
     */
    NSString * (* CPUCount)(void);
    
    /** 
     *  CPU 使用率
     */
    NSString * (* CPUUsageRate)(void);
    
    /**
     *  最后一次重启时间
     */
    NSDate * (* restartDate)(void);
    
    // MARK: 设备类型判断
    /** iPhone */
    BOOL (* is_iPhone)(void);
    /** iPad */
    BOOL (* is_iPad)(void);
    /** iTV,仅支持 iOS9 以上 */
    BOOL (* is_iTV)(void);
    /** carPlay,仅支持 iOS9 以上 */
    BOOL (* is_carPlay)(void);
    
    // MARK: 系统版本比较
    /** == */
    BOOL (* version_equal_to)(NSString *version);
    /** > */
    BOOL (* version_greater_than)(NSString *version);
    /** >= */
    BOOL (* version_greater_than_or_equal_to)(NSString *version);
    /** < */
    BOOL (* version_less_than)(NSString *version);
    /** <= */
    BOOL (* version_less_than_or_equal_to)(NSString *version);
    
    // MARK: - • 系统语言
    /** 
     *  支持的语言列表
     */
    NSArray * (* languages_support)(void);
    
    /** 
     *  当前语言全名,e.g zh-Hans-CN 
     */
    NSString * (* language_full_name)(void);
    
    /** 
     *  当前语言简写,e.g zh
     */
    NSString * (* language_short_name)(void);
    
    // MARK: - • 设备屏幕
    /** 
     *  屏幕尺寸 
     */
    CGSize (* screen_size)(void);
    
    /** 
     *  屏幕的宽 
     */
    CGFloat (* screen_width)(void);
    
    /** 
     *  屏幕的高
     */
    CGFloat (* screen_height)(void);
    
    /** 
     *  屏幕的最大长度
     */
    CGFloat (* screen_max_lenght)(void);
    
    /** 
     *  屏幕的最小长度
     */
    CGFloat (* screen_min_lenght)(void);
    
    /** 
     *  屏幕的 Scale 
     */
    CGFloat (* screen_scale)(void);
    
    /** 
     *  屏幕是否是 Retina 
     */
    BOOL (* screen_retina)(void);
	
	/**
	 *  屏幕是否是齐刘海
	 */
	BOOL (* is_notch)(void);
    
    // MARK: - • 运营商
    /** 
     *  运营商名称 e.g 中国联通 
     */
    NSString * (* carrierName)(void);
	
};

FOUNDATION_EXTERN struct LZDeviceUnit_type LZDeviceInfo;

#endif
