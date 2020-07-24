//
//  LZDeviceUnit.m
//  LZDeviceUnit
//
//  Created by Dear.Q on 2017/11/10.
//  Copyright © 2017年 Dear.Q. All rights reserved.
//

#import "LZDeviceUnit.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <sys/mount.h>
#import <sys/sysctl.h>
#import <mach/mach.h>

// MARK: - Private
/** 当前设备 */
UIDevice * _device(void) {
    
    static UIDevice *device;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [UIDevice currentDevice];
    });
    
    return device;
}

/** 获取设备标识 */
NSString * _deviceIdentifier(void) {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceIdentifier = [NSString stringWithCString:systemInfo.machine
                                                    encoding:NSUTF8StringEncoding];
    
    return deviceIdentifier;
}

// MARK: - 设备信息
/** 用户界面类型 */
LZUserInterfaceIdiom _userInterfaceIdiom(void) {

    UIUserInterfaceIdiom interfaceIdiom = UI_USER_INTERFACE_IDIOM();
    switch (interfaceIdiom) {
        case UIUserInterfaceIdiomPhone:
            return LZUserInterfaceIdiomPhone;
            break;
        case UIUserInterfaceIdiomPad:
            return LZUserInterfaceIdiomPad;
            break;
        default: {
            if (@available(iOS 9.0, *)) {
                if (interfaceIdiom == UIUserInterfaceIdiomTV) {
                    return LZUserInterfaceIdiomTV;
                } else if (interfaceIdiom == UIUserInterfaceIdiomCarPlay) {
                    return LZUserInterfaceIdiomCarPlay;
                }
            }
            return LZUserInterfaceIdiomUnspecified;
        }
            break;
    }
}

/** 型号 */
LZDeviceGeneration _generation(void) {

    NSString *deviceIdentifier = _deviceIdentifier();
    
    // 模拟器
    if ([deviceIdentifier isEqualToString:@"i386"] ||
        [deviceIdentifier isEqualToString:@"x86_64"]) return LZDeviceGenerationSimulator;
    
    // 真机
    // iPhone 型号
    if ([deviceIdentifier isEqualToString:@"iPhone1,1"]) return LZDeviceGenerationiPhone1G;
    if ([deviceIdentifier isEqualToString:@"iPhone1,2"]) return LZDeviceGenerationiPhone3G;
    if ([deviceIdentifier isEqualToString:@"iPhone2,1"]) return LZDeviceGenerationiPhone3GS;
    if ([deviceIdentifier isEqualToString:@"iPhone3,1"] ||
        [deviceIdentifier isEqualToString:@"iPhone3,2"] ||
        [deviceIdentifier isEqualToString:@"iPhone3,3"]) return LZDeviceGenerationiPhone4;
    if ([deviceIdentifier isEqualToString:@"iPhone4,1"]) return LZDeviceGenerationiPhone4S;
    if ([deviceIdentifier isEqualToString:@"iPhone5,1"] ||
        [deviceIdentifier isEqualToString:@"iPhone5,2"]) return LZDeviceGenerationiPhone5;
    if ([deviceIdentifier isEqualToString:@"iPhone5,3"] ||
        [deviceIdentifier isEqualToString:@"iPhone5,4"]) return LZDeviceGenerationiPhone5c;
    if ([deviceIdentifier isEqualToString:@"iPhone6,1"] ||
        [deviceIdentifier isEqualToString:@"iPhone6,2"]) return LZDeviceGenerationiPhone5s;
    if ([deviceIdentifier isEqualToString:@"iPhone7,2"]) return LZDeviceGenerationiPhone6;
    if ([deviceIdentifier isEqualToString:@"iPhone7,1"]) return LZDeviceGenerationiPhone6_plus;
    if ([deviceIdentifier isEqualToString:@"iPhone8,1"]) return LZDeviceGenerationiPhone6s;
    if ([deviceIdentifier isEqualToString:@"iPhone8,2"]) return LZDeviceGenerationiPhone6s_plus;
    if ([deviceIdentifier isEqualToString:@"iPhone8,4"]) return LZDeviceGenerationiPhoneSE1st;
    if ([deviceIdentifier isEqualToString:@"iPhone12,8"]) return LZDeviceGenerationiPhoneSE2nd;
    if ([deviceIdentifier isEqualToString:@"iPhone9,1"] ||
        [deviceIdentifier isEqualToString:@"iPhone9,3"]) return LZDeviceGenerationiPhone7;
    if ([deviceIdentifier isEqualToString:@"iPhone9,2"] ||
        [deviceIdentifier isEqualToString:@"iPhone9,4"]) return LZDeviceGenerationiPhone7_plus;
    if ([deviceIdentifier isEqualToString:@"iPhone10,1"] ||
        [deviceIdentifier isEqualToString:@"iPhone10,4"]) return LZDeviceGenerationiPhone8;
    if ([deviceIdentifier isEqualToString:@"iPhone10,2"] ||
        [deviceIdentifier isEqualToString:@"iPhone10,5"]) return LZDeviceGenerationiPhone8_plus;
    if ([deviceIdentifier isEqualToString:@"iPhone10,3"] ||
        [deviceIdentifier isEqualToString:@"iPhone10,6"]) return LZDeviceGenerationiPhoneX;
	if ([deviceIdentifier isEqualToString:@"iPhone11,8"]) return LZDeviceGenerationiPhoneXR;
	if ([deviceIdentifier isEqualToString:@"iPhone11,2"]) return LZDeviceGenerationiPhoneXS;
	if ([deviceIdentifier isEqualToString:@"iPhone11,4"] ||
		[deviceIdentifier isEqualToString:@"iPhone11,6"]) return LZDeviceGenerationiPhoneXS_max;
    if ([deviceIdentifier isEqualToString:@"iPhone12,1"]) return LZDeviceGenerationiPhone11;
    if ([deviceIdentifier isEqualToString:@"iPhone12,3"]) return LZDeviceGenerationiPhone11_pro;
    if ([deviceIdentifier isEqualToString:@"iPhone12,5"]) return LZDeviceGenerationiPhone11_pro_max;
    // iPod 型号
    if ([deviceIdentifier isEqualToString:@"iPod1,1"]) return LZDeviceGenerationiPodtouch1st;
    if ([deviceIdentifier isEqualToString:@"iPod2,1"]) return LZDeviceGenerationiPodtouch2nd;
    if ([deviceIdentifier isEqualToString:@"iPod3,1"]) return LZDeviceGenerationiPodtouch3rd;
    if ([deviceIdentifier isEqualToString:@"iPod4,1"]) return LZDeviceGenerationiPodtouch4th;
    if ([deviceIdentifier isEqualToString:@"iPod5,1"]) return LZDeviceGenerationiPodtouch5th;
    if ([deviceIdentifier isEqualToString:@"iPod7,1"]) return LZDeviceGenerationiPodtouch6th;
	if ([deviceIdentifier isEqualToString:@"iPod9,1"]) return LZDeviceGenerationiPodtouch7th;
    // iWatch 型号
    if ([deviceIdentifier isEqualToString:@"Watch1,1"] ||
        [deviceIdentifier isEqualToString:@"Watch1,2"]) return LZDeviceGenerationiWatch1st;
    if ([deviceIdentifier isEqualToString:@"Watch2,6"] ||
        [deviceIdentifier isEqualToString:@"Watch2,7"]) return LZDeviceGenerationiWatch_series1;
    if ([deviceIdentifier isEqualToString:@"Watch2,3"] ||
        [deviceIdentifier isEqualToString:@"Watch2,4"]) return LZDeviceGenerationiWatch_series2;
    if ([deviceIdentifier isEqualToString:@"Watch3,1"] ||
        [deviceIdentifier isEqualToString:@"Watch3,2"] ||
        [deviceIdentifier isEqualToString:@"Watch3,3"] ||
        [deviceIdentifier isEqualToString:@"Watch3,4"]) return LZDeviceGenerationiWatch_series3;
	if ([deviceIdentifier isEqualToString:@"Watch4,1"] ||
		[deviceIdentifier isEqualToString:@"Watch4,2"] ||
		[deviceIdentifier isEqualToString:@"Watch4,3"] ||
		[deviceIdentifier isEqualToString:@"Watch4,4"]) return LZDeviceGenerationiWatch_series4;
    if ([deviceIdentifier isEqualToString:@"Watch5,1"] ||
        [deviceIdentifier isEqualToString:@"Watch5,2"] ||
        [deviceIdentifier isEqualToString:@"Watch5,3"] ||
        [deviceIdentifier isEqualToString:@"Watch5,4"]) return LZDeviceGenerationiWatch_series5;
    // iPad 型号
    if ([deviceIdentifier isEqualToString:@"iPad1,1"]) return LZDeviceGenerationiPad;
    if ([deviceIdentifier isEqualToString:@"iPad2,1"] ||
        [deviceIdentifier isEqualToString:@"iPad2,2"] ||
        [deviceIdentifier isEqualToString:@"iPad2,3"] ||
        [deviceIdentifier isEqualToString:@"iPad2,4"]) return LZDeviceGenerationiPad2;
    if ([deviceIdentifier isEqualToString:@"iPad3,1"] ||
        [deviceIdentifier isEqualToString:@"iPad3,2"] ||
        [deviceIdentifier isEqualToString:@"iPad3,3"]) return LZDeviceGenerationiPad3;
    if ([deviceIdentifier isEqualToString:@"iPad3,4"] ||
        [deviceIdentifier isEqualToString:@"iPad3,5"] ||
        [deviceIdentifier isEqualToString:@"iPad3,6"]) return LZDeviceGenerationiPad4;
    if ([deviceIdentifier isEqualToString:@"iPad6,11"] ||
        [deviceIdentifier isEqualToString:@"iPad6,12"]) return LZDeviceGenerationiPad5;
	if ([deviceIdentifier isEqualToString:@"iPad7,5"] ||
		[deviceIdentifier isEqualToString:@"iPad7,6"]) return LZDeviceGenerationiPad6;
    if ([deviceIdentifier isEqualToString:@"iPad7,11"] ||
        [deviceIdentifier isEqualToString:@"iPad7,12"]) return LZDeviceGenerationiPad7;
    if ([deviceIdentifier isEqualToString:@"iPad4,1"] ||
        [deviceIdentifier isEqualToString:@"iPad4,2"] ||
        [deviceIdentifier isEqualToString:@"iPad4,3"]) return LZDeviceGenerationiPad_air;
    if ([deviceIdentifier isEqualToString:@"iPad5,3"] ||
        [deviceIdentifier isEqualToString:@"iPad5,4"]) return LZDeviceGenerationiPad_air2;
	if ([deviceIdentifier isEqualToString:@"iPad11,3"] ||
		[deviceIdentifier isEqualToString:@"iPad11,4"]) return LZDeviceGenerationiPad_air3;
    if ([deviceIdentifier isEqualToString:@"iPad6,3"] ||
        [deviceIdentifier isEqualToString:@"iPad6,4"]) return LZDeviceGenerationiPad_pro_inch_9__7;
    if ([deviceIdentifier isEqualToString:@"iPad6,7"] ||
        [deviceIdentifier isEqualToString:@"iPad6,8"]) return LZDeviceGenerationiPad_pro_inch_12__9;
    if ([deviceIdentifier isEqualToString:@"iPad7,1"] ||
        [deviceIdentifier isEqualToString:@"iPad7,2"]) return LZDeviceGenerationiPad_pro_inch_12__9_2nd;
	if ([deviceIdentifier isEqualToString:@"iPad8,5"] ||
		[deviceIdentifier isEqualToString:@"iPad8,6"] ||
		[deviceIdentifier isEqualToString:@"iPad8,7"] ||
		[deviceIdentifier isEqualToString:@"iPad8,8"]) return LZDeviceGenerationiPad_pro_inch_12__9_3nd;
    if ([deviceIdentifier isEqualToString:@"iPad7,3"] ||
        [deviceIdentifier isEqualToString:@"iPad7,4"]) return LZDeviceGenerationiPad_pro_inch_10__5;
	if ([deviceIdentifier isEqualToString:@"iPad8,1"] ||
		[deviceIdentifier isEqualToString:@"iPad8,2"] ||
		[deviceIdentifier isEqualToString:@"iPad8,3"] ||
		[deviceIdentifier isEqualToString:@"iPad8,4"]) return LZDeviceGenerationiPad_pro_inch_11;
    if ([deviceIdentifier isEqualToString:@"iPad2,5"] ||
        [deviceIdentifier isEqualToString:@"iPad2,6"] ||
        [deviceIdentifier isEqualToString:@"iPad2,7"]) return LZDeviceGenerationiPad_mini;
    if ([deviceIdentifier isEqualToString:@"iPad4,4"] ||
        [deviceIdentifier isEqualToString:@"iPad4,5"] ||
        [deviceIdentifier isEqualToString:@"iPad4,6"]) return LZDeviceGenerationiPad_mini2;
    if ([deviceIdentifier isEqualToString:@"iPad4,7"] ||
        [deviceIdentifier isEqualToString:@"iPad4,8"] ||
        [deviceIdentifier isEqualToString:@"iPad4,9"]) return LZDeviceGenerationiPad_mini3;
    if ([deviceIdentifier isEqualToString:@"iPad5,1"] ||
        [deviceIdentifier isEqualToString:@"iPad5,2"]) return LZDeviceGenerationiPad_mini4;
	if ([deviceIdentifier isEqualToString:@"iPad11,1"] ||
		[deviceIdentifier isEqualToString:@"iPad11,2"]) return LZDeviceGenerationiPad_mini5;
    // iTV 型号
    if ([deviceIdentifier isEqualToString:@"AppleTV1,1"]) return LZDeviceGenerationiTV1st;
    if ([deviceIdentifier isEqualToString:@"AppleTV2,1"]) return LZDeviceGenerationiTV2nd;
    if ([deviceIdentifier isEqualToString:@"AppleTV3,1"] ||
        [deviceIdentifier isEqualToString:@"AppleTV3,2"]) return LZDeviceGenerationiTV3rd;
    if ([deviceIdentifier isEqualToString:@"AppleTV5,3"]) return LZDeviceGenerationiTV4th;
    if ([deviceIdentifier isEqualToString:@"AppleTV6,2"]) return LZDeviceGenerationiTV4K;
    // AirPods 型号
    if ([deviceIdentifier isEqualToString:@"AirPods1,1"]) return LZDeviceGenerationAirPods1st;
    if ([deviceIdentifier isEqualToString:@"AirPods2,1"]) return LZDeviceGenerationAirPods2nd;
    if ([deviceIdentifier isEqualToString:@"iProd8,1"]) return LZDeviceGenerationAirPods_pro;
    // 未知
    return LZDeviceGenerationUnspecified;
}

/** 型号描述 */
NSString * _generation_desc(void) {
    
    switch (_generation()) {
            // 模拟器
        case LZDeviceGenerationSimulator:
            return @"Simulator";
            break;
            // iPhone 型号
        case LZDeviceGenerationiPhone1G:
            return @"iPhone 1G";
            break;
        case LZDeviceGenerationiPhone3G:
            return @"iPhone 3G";
            break;
        case LZDeviceGenerationiPhone3GS:
            return @"iPhone 3GS";
            break;
        case LZDeviceGenerationiPhone4:
            return @"iPhone 4";
            break;
        case LZDeviceGenerationiPhone4S:
            return @"iPhone 4S";
            break;
        case LZDeviceGenerationiPhone5:
            return @"iPhone 5";
            break;
        case LZDeviceGenerationiPhone5c:
            return @"iPhone 5c";
            break;
        case LZDeviceGenerationiPhone5s:
            return @"iPhone 5s";
            break;
        case LZDeviceGenerationiPhone6:
            return @"iPhone 6";
            break;
        case LZDeviceGenerationiPhone6_plus:
            return @"iPhone 6 Plus";
            break;
        case LZDeviceGenerationiPhone6s:
            return @"iPhone 6s";
            break;
        case LZDeviceGenerationiPhone6s_plus:
            return @"iPhone 6s Plus";
            break;
        case LZDeviceGenerationiPhoneSE1st:
            return @"iPhone SE (1st generation)";
            break;
        case LZDeviceGenerationiPhoneSE2nd:
            return @"iPhone SE (2nd generation)";
            break;
        case LZDeviceGenerationiPhone7:
            return @"iPhone 7";
            break;
        case LZDeviceGenerationiPhone7_plus:
            return @"iPhone 7 Plus";
            break;
        case LZDeviceGenerationiPhone8:
            return @"iPhone 8";
            break;
        case LZDeviceGenerationiPhone8_plus:
            return @"iPhone 8 Plus";
            break;
        case LZDeviceGenerationiPhoneX:
            return @"iPhone X";
            break;
		case LZDeviceGenerationiPhoneXR:
			return @"iPhone XR";
			break;
		case LZDeviceGenerationiPhoneXS:
			return @"iPhone XS";
			break;
		case LZDeviceGenerationiPhoneXS_max:
			return @"iPhone XS Max";
			break;
        case LZDeviceGenerationiPhone11:
            return @"iPhone 11";
            break;
        case LZDeviceGenerationiPhone11_pro:
            return @"iPhone 11 Pro";
            break;
        case LZDeviceGenerationiPhone11_pro_max:
            return @"iPhone 11 Pro Max";
            break;
            // iPod 型号
        case LZDeviceGenerationiPodtouch1st:
            return @"iPod touch";
            break;
        case LZDeviceGenerationiPodtouch2nd:
            return @"iPod touch (2nd generation)";
            break;
        case LZDeviceGenerationiPodtouch3rd:
            return @"iPod touch (3rd generation)";
            break;
        case LZDeviceGenerationiPodtouch4th:
            return @"iPod touch (4th generation)";
            break;
        case LZDeviceGenerationiPodtouch5th:
            return @"iPod touch (5th generation)";
            break;
        case LZDeviceGenerationiPodtouch6th:
            return @"iPod touch (6th generation)";
            break;
        case LZDeviceGenerationiPodtouch7th:
            return @"iPod touch (7th generation)";
            break;
            // iWatch 型号
        case LZDeviceGenerationiWatch1st:
            return @"Apple Watch (1st generation)";
            break;
        case LZDeviceGenerationiWatch_series1:
            return @"Apple Watch Series 1";
            break;
        case LZDeviceGenerationiWatch_series2:
            return @"Apple Watch Series 2";
            break;
        case LZDeviceGenerationiWatch_series3:
            return @"Apple Watch Series 3";
            break;
		case LZDeviceGenerationiWatch_series4:
			return @"Apple Watch Series 4";
			break;
        case LZDeviceGenerationiWatch_series5:
            return @"Apple Watch Series 5";
            break;
            // iPad 型号
        case LZDeviceGenerationiPad:
            return @"iPad 1";
            break;
        case LZDeviceGenerationiPad2:
            return @"iPad 2";
            break;
        case LZDeviceGenerationiPad3:
            return @"iPad (3rd generation)";
            break;
        case LZDeviceGenerationiPad4:
            return @"iPad (4th generation)";
            break;
        case LZDeviceGenerationiPad5:
            return @"iPad (5th generation)";
            break;
        case LZDeviceGenerationiPad6:
            return @"iPad (6th generation)";
            break;
        case LZDeviceGenerationiPad7:
            return @"iPad (7th generation)";
            break;
        case LZDeviceGenerationiPad_air:
            return @"iPad Air 1";
            break;
        case LZDeviceGenerationiPad_air2:
            return @"iPad Air 2";
            break;
        case LZDeviceGenerationiPad_air3:
            return @"iPad Air 3";
            break;
        case LZDeviceGenerationiPad_pro_inch_9__7:
            return @"iPad Pro (9.7-inch)";
            break;
        case LZDeviceGenerationiPad_pro_inch_12__9:
            return @"iPad Pro (12.9-inch)";
            break;
        case LZDeviceGenerationiPad_pro_inch_12__9_2nd:
            return @"iPad Pro (12.9-inch, 2nd generation)";
            break;
        case LZDeviceGenerationiPad_pro_inch_10__5:
            return @"iPad Pro (10.5-inch)";
            break;
        case LZDeviceGenerationiPad_pro_inch_11:
            return @"iPad Pro (11.0-inch)";
            break;
        case LZDeviceGenerationiPad_pro_inch_12__9_3nd:
            return @"iPad Pro (12.9-inch, 3nd generation)";
            break;
        case LZDeviceGenerationiPad_mini:
            return @"iPad mini 1";
            break;
        case LZDeviceGenerationiPad_mini2:
            return @"iPad mini 2";
            break;
        case LZDeviceGenerationiPad_mini3:
            return @"iPad mini 3";
            break;
        case LZDeviceGenerationiPad_mini4:
            return @"iPad mini 4";
            break;
        case LZDeviceGenerationiPad_mini5:
            return @"iPad mini 5";
            break;
            // iTV 型号
        case LZDeviceGenerationiTV1st:
            return @"Apple TV (1st generation)";
            break;
        case LZDeviceGenerationiTV2nd:
            return @"Apple TV (2nd generation)";
            break;
        case LZDeviceGenerationiTV3rd:
            return @"Apple TV (3rd generation)";
            break;
        case LZDeviceGenerationiTV4th:
            return @"Apple TV (4th generation)";
            break;
        case LZDeviceGenerationiTV4K:
            return @"Apple TV 4K";
            break;
        case LZDeviceGenerationAirPods1st:
            return @"AirPods (1st generation)";
            break;
        case LZDeviceGenerationAirPods2nd:
            return @"AirPods (2nd generation)";
            break;
        case LZDeviceGenerationAirPods_pro:
            return @"AirPods Pro";
            break;
        case LZDeviceGenerationUnspecified:
        default:
            return @"设备类型未知";
            break;
    }
}

/** UUID */
NSString * _DeviceUUID(void) {
	return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

/** 别名，用户定义的名称 */
NSString * _name(void) {
    return _device().name;
}

/** 类型名称 */
NSString * _model(void) {
    return _device().model;
}

/** 国际化区域名称 */
NSString * _localizedModel(void) {
    return _device().localizedModel;
}

/** 系统名称，e.g iOS */
NSString * _systemName(void) {
    return _device().systemName;
}

/** 系统版本 */
static NSString * _systemVersion(void) {
    
    static NSString *systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = _device().systemVersion;
    });
    
    return systemVersion;
}

/** 方向 */
LZDeviceOrientation _orientation(void) {
    
    switch (_device().orientation) {
        case UIDeviceOrientationPortrait:
            return LZDeviceOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            return LZDeviceOrientationPortraitUpsideDown;
            break;
        case UIDeviceOrientationLandscapeLeft:
            return LZDeviceOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationLandscapeRight:
            return LZDeviceOrientationLandscapeRight;
            break;
        case UIDeviceOrientationFaceUp:
            return LZDeviceOrientationFaceUp;
            break;
        case UIDeviceOrientationFaceDown:
            return LZDeviceOrientationFaceDown;
            break;
        default:
            return LZDeviceOrientationUnknown;
            break;
    }
}

/** 电池状态 */
LZDeviceBatteryState _batteryState(void) {

    if (NO == _device().isBatteryMonitoringEnabled) [_device() setBatteryMonitoringEnabled:YES];
    switch (_device().batteryState) {
        case UIDeviceBatteryStateUnplugged:
            return LZDeviceBatteryStateUnplugged;
            break;
        case UIDeviceBatteryStateCharging:
            return LZDeviceBatteryStateCharging;
            break;
        case UIDeviceBatteryStateFull:
            return LZDeviceBatteryStateFull;
            break;
        default:
            return LZDeviceBatteryStateUnknown;
            break;
    }
}

/** 电池状态描述 */
NSString * _batteryState_desc(void) {
    
    switch (_batteryState()) {
        case UIDeviceBatteryStateUnplugged:
            return @"电池使用中";
            break;
        case UIDeviceBatteryStateCharging:
            return @"电池充电中";
            break;
        case UIDeviceBatteryStateFull:
            return @"电池充满电";
            break;
        default:
            return @"电池状态未知";
            break;
    }
}

/** 电池电量 */
float _batteryLevel(void) {

    if (NO == _device().isBatteryMonitoringEnabled) [_device() setBatteryMonitoringEnabled:YES];
    float batteryLevel = _device().batteryLevel;
    
    return batteryLevel;
}

/** 电池电量描述，百分比 */
NSString * _batteryLevel_desc(void) {

    float batteryLevel = _batteryLevel();
    if (-1 == batteryLevel) return @"未知";
    NSString *percentPower = [NSString stringWithFormat:@"%.0f%%", batteryLevel * 100];
    
    return percentPower;
}

/** 总磁盘空间 */
int64_t _diskTotalSpace(void) {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory()
                                                                       error:&error];
    if (error) {
        return -1;
    }
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    
    return space;
}

/** 总磁盘空间描述 */
NSString * _diskTotalSpace_desc(void) {

    int64_t totalSpace = _diskTotalSpace();
    if (totalSpace == -1) {
        return @"未知";
    }
    NSString *totalSpaceDesc = [NSString stringWithFormat:@"%.2lfG", totalSpace * 0.001 * 0.001 * 0.001];
    
    return totalSpaceDesc;
}

/** 剩余磁盘空间 */
int64_t _diskFreeSpace(void) {
    
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory()
                                                                                  error:&error];
    if (error) {
        return -1;
    }
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) {
        space = -1;
    }
    
    return space;
}

/** 剩余磁盘空间描述 */
NSString * _diskFreeSpace_desc(void) {

    int64_t freeSpace = _diskFreeSpace();
    if (freeSpace == -1) {
        return @"未知";
    }
    NSString *freeSpaceDesc = [NSString stringWithFormat:@"%.2lfG", freeSpace * 0.001 * 0.001 * 0.001];
    
    return freeSpaceDesc;
}

/** 已使用磁盘空间 */
int64_t _diskusedSpace(void) {
    
    int64_t totalSpace = _diskTotalSpace();
    int64_t freeSpace = _diskFreeSpace();
    if (totalSpace < 0 || freeSpace < 0) {
        return -1;
    }
    int64_t usedSpace = totalSpace - freeSpace;
    if (usedSpace < 0) {
        usedSpace = -1;
    }

    return usedSpace;
}

/** 已使用磁盘空间描述 */
NSString * _diskUsedSpace_desc(void) {

    int64_t usedSpace = _diskusedSpace();
    if (usedSpace == -1) {
        return @"未知";
    }
    NSString *usedSpaceDesc = [NSString stringWithFormat:@"%.2lfG", usedSpace * 0.001 * 0.001 * 0.001];
    
    return usedSpaceDesc;
}

/** CPU 核数 */
NSString * _CPUCount(void) {

    NSUInteger CPUCount = [NSProcessInfo processInfo].activeProcessorCount;
	NSString *CPUCountDesc = [NSString stringWithFormat:@"%lu", (unsigned long)CPUCount];
    
    return CPUCountDesc;
}

/** 获取每个 CPU 的使用比例 */
NSArray * _PerCPUUsage(void) {
    
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status) {
        _numCPUs = 1;
    }
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        
        return cpus;
    } else {
        return nil;
    }
}

/** CPU 使用率 */
NSString * _CPUUsageRate(void) {

    float cpu = 0;
    NSArray *cpus = _PerCPUUsage();
    if (cpus.count == 0) {
        return @"未知";
    }
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    NSString *CPUUsageRateDesc = [NSString stringWithFormat:@"%.2f%%", cpu * 100];
    
    return CPUUsageRateDesc;
}

/** 最后一次重启时间 */
NSDate * _restartDate(void) {

    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    NSDate *lastRestartDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
    
    return lastRestartDate;
}

/** iPhone */
BOOL _is_iPhone(void) {
    return (_userInterfaceIdiom() == LZUserInterfaceIdiomPhone ? YES : NO);
}

/** iPad */
BOOL _is_iPad(void) {
    return (_userInterfaceIdiom() == LZUserInterfaceIdiomPad ? YES : NO);
}

/** iTV */
BOOL _is_iTV(void) {
    
    if (@available(iOS 9, *)) {
        return (_userInterfaceIdiom() == LZUserInterfaceIdiomTV ? YES : NO);
    } else {
        return NO;
    }
}

/** carPlay */
BOOL _is_carPlay(void) {
    
    if (@available(iOS 9, *)) {
        return (_userInterfaceIdiom() == LZUserInterfaceIdiomCarPlay ? YES : NO);
    } else {
        return NO;
    }
}

/** == */
BOOL _version_equal_to(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] == NSOrderedSame);
}

/** > */
BOOL _version_greater_than(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] == NSOrderedDescending);
}

/** >= */
BOOL _version_greater_than_or_equal_to(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] != NSOrderedAscending);
}

/** < */
BOOL _version_less_than(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] == NSOrderedAscending);
}

/** <= */
BOOL _version_less_than_or_equal_to(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] != NSOrderedDescending);
}

// MARK: - 系统语言
/** 支持的语言列表 */
NSArray * _languages_support(void) {
    
    static NSArray *languageArrI;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        languageArrI = [NSLocale preferredLanguages];
    });
    
    return languageArrI;
}

/** 当前语言全名,e.g zh-Hans-CN */
NSString * _language_full_name(void) {
    return ([_languages_support() objectAtIndex:0]);
}

/** 当前语言简写,e.g  zh */
NSString * _language_short_name(void) {
    
    static NSString *languageShortName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        languageShortName = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    });
    
    return languageShortName;
}

// MARK: - 设备屏幕
/** 屏幕尺寸 */
CGSize _screen_size(void) {
    
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    
    return size;
}

/** 屏幕的宽 */
CGFloat _screen_width(void) {
    return (_screen_size().width);
}

/** 屏幕的高 */
CGFloat _screen_height(void) {
    return (_screen_size().height);
}

/** 屏幕的最大长度 */
CGFloat _screen_max_lenght(void) {
    return (MAX(_screen_width(), _screen_height()));
}

/** 屏幕的最小长度 */
CGFloat _screen_min_lenght(void) {
    return (MIN(_screen_width(), _screen_height()));
}

/** 屏幕的 Scale */
CGFloat _screen_scale(void) {

    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [[UIScreen mainScreen] scale];
    });
    
    return scale;
}

/** 屏幕是否是 Retina */
BOOL _screen_retina(void) {
    return (_screen_scale() > 1 ? YES : NO);
}

/** 屏幕是否是齐刘海 */
BOOL _is_notch(void) {
    
    BOOL isNotch = NO;
    if (NO == _is_iPhone()) {
        return isNotch;
    }
    if (@available(iOS 11.0, *)) {
        
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (nil == mainWindow) {
            mainWindow = [UIApplication sharedApplication].keyWindow;
        }
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            isNotch = YES;
        }
    }
	return isNotch;
}

// MARK: - 运营商
NSString * _carrierName(void) {
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSString *carrierName = carrier.carrierName;

	return carrierName ? carrierName : @"未知";
}

/** 初始化结构体 */
struct LZDeviceUnit_type LZDeviceInfo = {
    
    .userInterfaceIdiom = _userInterfaceIdiom,
    .generation = _generation,
    .generation_desc = _generation_desc,
    .UUID = _DeviceUUID,
    .name = _name,
    .model = _model,
    .localizedModel = _localizedModel,
    .systemName = _systemName,
    .systemVersion = _systemVersion,
    .orientation = _orientation,
    .batteryState = _batteryState,
    .batteryState_desc = _batteryState_desc,
    .batteryLevel = _batteryLevel,
    .batteryLevel_desc = _batteryLevel_desc,
    .diskTotalSpace = _diskTotalSpace,
    .diskTotalSpace_desc = _diskTotalSpace_desc,
    .diskFreeSpace = _diskFreeSpace,
    .diskFreeSpace_desc = _diskFreeSpace_desc,
    .diskUsedSpace = _diskusedSpace,
    .diskUsedSpace_desc = _diskUsedSpace_desc,
    .CPUCount = _CPUCount,
    .CPUUsageRate = _CPUUsageRate,
    .restartDate= _restartDate,
    .is_iPad = _is_iPad,
    .is_iPhone = _is_iPhone,
    .is_iTV = _is_iTV,
    .is_carPlay = _is_carPlay,
    .version_equal_to = _version_equal_to,
    .version_greater_than = _version_greater_than,
    .version_greater_than_or_equal_to = _version_greater_than_or_equal_to,
    .version_less_than = _version_less_than,
    .version_less_than_or_equal_to = _version_less_than_or_equal_to,
    
    .languages_support = _languages_support,
    .language_full_name = _language_full_name,
    .language_short_name = _language_short_name,
    
    .screen_size = _screen_size,
    .screen_width = _screen_width,
    .screen_height = _screen_height,
    .screen_max_lenght = _screen_max_lenght,
    .screen_min_lenght = _screen_min_lenght,
    .screen_scale = _screen_scale,
    .screen_retina = _screen_retina,
	.is_notch = _is_notch,
    
    .carrierName = _carrierName,
};
