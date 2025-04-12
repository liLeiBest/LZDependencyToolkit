//
//  LZDeviceUnit.m
//  LZDeviceUnit
//
//  Created by Dear.Q on 2017/11/10.
//  Copyright © 2017年 Dear.Q. All rights reserved.
//

#import "LZDeviceUnit.h"
#import "LZAppUnit.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <sys/mount.h>
#import <sys/sysctl.h>
#import <sys/stat.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <mach/mach.h>
#import <os/proc.h>

#include <arpa/inet.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <net/if_dl.h>

// MARK: - Private -
UIDevice * _device(void) {
    
    static UIDevice *device;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [UIDevice currentDevice];
    });
    return device;
}

NSString * _deviceIdentifier(void) {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceIdentifier = [NSString stringWithCString:systemInfo.machine
                                                    encoding:NSUTF8StringEncoding];
    return deviceIdentifier;
}

LZUserInterfaceIdiom _userInterfaceIdiom(void) {

    UIUserInterfaceIdiom interfaceIdiom = UI_USER_INTERFACE_IDIOM();
    switch (interfaceIdiom) {
        case UIUserInterfaceIdiomPhone:
            return LZUserInterfaceIdiomPhone;
            break;
        case UIUserInterfaceIdiomPad:
            return LZUserInterfaceIdiomPad;
            break;
        case UIUserInterfaceIdiomTV:
            return LZUserInterfaceIdiomTV;
            break;
        case UIUserInterfaceIdiomCarPlay:
            return LZUserInterfaceIdiomCarPlay;
            break;
        default: {
            if (@available(iOS 14.0, *)) {
                if (interfaceIdiom == UIUserInterfaceIdiomMac) {
                    return LZUserInterfaceIdiomMac;
                }
            }
            return LZUserInterfaceIdiomUnspecified;
        }
            break;
    }
}

LZDeviceGeneration _generation(void) {

    NSString *deviceIdentifier = _deviceIdentifier();
    // 模拟器
    if ([deviceIdentifier isEqualToString:@"i386"] ||
        [deviceIdentifier isEqualToString:@"x86_64"] ||
        [deviceIdentifier isEqualToString:@"arm64"]) return LZDeviceGenerationSimulator;
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
    if ([deviceIdentifier isEqualToString:@"iPhone14,6"]) return LZDeviceGenerationiPhoneSE3rd;
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
    if ([deviceIdentifier isEqualToString:@"iPhone13,1"]) return LZDeviceGenerationiPhone12_mini;
    if ([deviceIdentifier isEqualToString:@"iPhone13,2"]) return LZDeviceGenerationiPhone12;
    if ([deviceIdentifier isEqualToString:@"iPhone13,3"]) return LZDeviceGenerationiPhone12_pro;
    if ([deviceIdentifier isEqualToString:@"iPhone13,4"]) return LZDeviceGenerationiPhone12_pro_max;
    if ([deviceIdentifier isEqualToString:@"iPhone14,4"]) return LZDeviceGenerationiPhone13_mini;
    if ([deviceIdentifier isEqualToString:@"iPhone14,5"]) return LZDeviceGenerationiPhone13;
    if ([deviceIdentifier isEqualToString:@"iPhone14,2"]) return LZDeviceGenerationiPhone13_pro;
    if ([deviceIdentifier isEqualToString:@"iPhone14,3"]) return LZDeviceGenerationiPhone13_pro_max;
    if ([deviceIdentifier isEqualToString:@"iPhone14,7"]) return LZDeviceGenerationiPhone14;
    if ([deviceIdentifier isEqualToString:@"iPhone14,8"]) return LZDeviceGenerationiPhone14_plus;
    if ([deviceIdentifier isEqualToString:@"iPhone15,2"]) return LZDeviceGenerationiPhone14_pro;
    if ([deviceIdentifier isEqualToString:@"iPhone15,3"]) return LZDeviceGenerationiPhone14_pro_max;
    if ([deviceIdentifier isEqualToString:@"iPhone15,4"]) return LZDeviceGenerationiPhone15;
    if ([deviceIdentifier isEqualToString:@"iPhone15,5"]) return LZDeviceGenerationiPhone15_plus;
    if ([deviceIdentifier isEqualToString:@"iPhone16,1"]) return LZDeviceGenerationiPhone15_pro;
    if ([deviceIdentifier isEqualToString:@"iPhone16,2"]) return LZDeviceGenerationiPhone15_pro_max;
    if ([deviceIdentifier isEqualToString:@"iPhone17,1"]) return LZDeviceGenerationiPhone16;
    if ([deviceIdentifier isEqualToString:@"iPhone17,2"]) return LZDeviceGenerationiPhone16_plus;
    if ([deviceIdentifier isEqualToString:@"iPhone17,3"]) return LZDeviceGenerationiPhone16_pro;
    if ([deviceIdentifier isEqualToString:@"iPhone17,4"]) return LZDeviceGenerationiPhone16_pro_max;
    if ([deviceIdentifier isEqualToString:@"iPhone17,5"]) return LZDeviceGenerationiPhone16e;
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
    if ([deviceIdentifier isEqualToString:@"Watch5,9"] ||
        [deviceIdentifier isEqualToString:@"Watch5,10"] ||
        [deviceIdentifier isEqualToString:@"Watch5,11"] ||
        [deviceIdentifier isEqualToString:@"Watch5,12"]) return LZDeviceGenerationiWatch_SE_1st;
    if ([deviceIdentifier isEqualToString:@"Watch6,10"] ||
        [deviceIdentifier isEqualToString:@"Watch6,11"] ||
        [deviceIdentifier isEqualToString:@"Watch6,12"] ||
        [deviceIdentifier isEqualToString:@"Watch6,13"]) return LZDeviceGenerationiWatch_SE_2nd;
    if ([deviceIdentifier isEqualToString:@"Watch6,1"] ||
        [deviceIdentifier isEqualToString:@"Watch6,2"] ||
        [deviceIdentifier isEqualToString:@"Watch6,3"] ||
        [deviceIdentifier isEqualToString:@"Watch6,4"]) return LZDeviceGenerationiWatch_series6;
    if ([deviceIdentifier isEqualToString:@"Watch6,6"] ||
        [deviceIdentifier isEqualToString:@"Watch6,7"] ||
        [deviceIdentifier isEqualToString:@"Watch6,8"] ||
        [deviceIdentifier isEqualToString:@"Watch6,9"]) return LZDeviceGenerationiWatch_series7;
    if ([deviceIdentifier isEqualToString:@"Watch6,14"] ||
        [deviceIdentifier isEqualToString:@"Watch6,15"] ||
        [deviceIdentifier isEqualToString:@"Watch6,16"] ||
        [deviceIdentifier isEqualToString:@"Watch6,17"]) return LZDeviceGenerationiWatch_series8;
    if ([deviceIdentifier isEqualToString:@"Watch6,18"]) return LZDeviceGenerationiWatch_ultra_1st;
    // iPad 型号
    if ([deviceIdentifier isEqualToString:@"iPad1,1"]) return LZDeviceGenerationiPad1st;
    if ([deviceIdentifier isEqualToString:@"iPad2,1"] ||
        [deviceIdentifier isEqualToString:@"iPad2,2"] ||
        [deviceIdentifier isEqualToString:@"iPad2,3"] ||
        [deviceIdentifier isEqualToString:@"iPad2,4"]) return LZDeviceGenerationiPad2nd;
    if ([deviceIdentifier isEqualToString:@"iPad3,1"] ||
        [deviceIdentifier isEqualToString:@"iPad3,2"] ||
        [deviceIdentifier isEqualToString:@"iPad3,3"]) return LZDeviceGenerationiPad3rd;
    if ([deviceIdentifier isEqualToString:@"iPad3,4"] ||
        [deviceIdentifier isEqualToString:@"iPad3,5"] ||
        [deviceIdentifier isEqualToString:@"iPad3,6"]) return LZDeviceGenerationiPad4th;
    if ([deviceIdentifier isEqualToString:@"iPad6,11"] ||
        [deviceIdentifier isEqualToString:@"iPad6,12"]) return LZDeviceGenerationiPad5th;
	if ([deviceIdentifier isEqualToString:@"iPad7,5"] ||
		[deviceIdentifier isEqualToString:@"iPad7,6"]) return LZDeviceGenerationiPad6th;
    if ([deviceIdentifier isEqualToString:@"iPad7,11"] ||
        [deviceIdentifier isEqualToString:@"iPad7,12"]) return LZDeviceGenerationiPad7th;
    if ([deviceIdentifier isEqualToString:@"iPad11,6"] ||
        [deviceIdentifier isEqualToString:@"iPad11,7"]) return LZDeviceGenerationiPad8th;
    if ([deviceIdentifier isEqualToString:@"iPad12,1"] ||
        [deviceIdentifier isEqualToString:@"iPad12,2"]) return LZDeviceGenerationiPad9th;
    if ([deviceIdentifier isEqualToString:@"iPad13,18"] ||
        [deviceIdentifier isEqualToString:@"iPad13,19"]) return LZDeviceGenerationiPad10th;
    if ([deviceIdentifier isEqualToString:@"iPad4,1"] ||
        [deviceIdentifier isEqualToString:@"iPad4,2"] ||
        [deviceIdentifier isEqualToString:@"iPad4,3"]) return LZDeviceGenerationiPad_air1st;
    if ([deviceIdentifier isEqualToString:@"iPad5,3"] ||
        [deviceIdentifier isEqualToString:@"iPad5,4"]) return LZDeviceGenerationiPad_air2nd;
	if ([deviceIdentifier isEqualToString:@"iPad11,3"] ||
		[deviceIdentifier isEqualToString:@"iPad11,4"]) return LZDeviceGenerationiPad_air3rd;
    if ([deviceIdentifier isEqualToString:@"iPad13,1"] ||
        [deviceIdentifier isEqualToString:@"iPad13,2"]) return LZDeviceGenerationiPad_air4th;
    if ([deviceIdentifier isEqualToString:@"iPad13,16"] ||
        [deviceIdentifier isEqualToString:@"iPad13,17"]) return LZDeviceGenerationiPad_air5th;
    if ([deviceIdentifier isEqualToString:@"iPad6,7"] ||
        [deviceIdentifier isEqualToString:@"iPad6,8"]) return LZDeviceGenerationiPad_pro_inch_12__9_1st;
    if ([deviceIdentifier isEqualToString:@"iPad7,1"] ||
        [deviceIdentifier isEqualToString:@"iPad7,2"]) return LZDeviceGenerationiPad_pro_inch_12__9_2nd;
    if ([deviceIdentifier isEqualToString:@"iPad8,5"] ||
        [deviceIdentifier isEqualToString:@"iPad8,6"] ||
        [deviceIdentifier isEqualToString:@"iPad8,7"] ||
        [deviceIdentifier isEqualToString:@"iPad8,8"]) return LZDeviceGenerationiPad_pro_inch_12__9_3rd;
    if ([deviceIdentifier isEqualToString:@"iPad8,11"] ||
        [deviceIdentifier isEqualToString:@"iPad8,12"]) return LZDeviceGenerationiPad_pro_inch_12__9_4th;
    if ([deviceIdentifier isEqualToString:@"iPad13,8"] ||
        [deviceIdentifier isEqualToString:@"iPad13,9"] ||
        [deviceIdentifier isEqualToString:@"iPad13,10"] ||
        [deviceIdentifier isEqualToString:@"iPad13,11"]) return LZDeviceGenerationiPad_pro_inch_12__9_5th;
    if ([deviceIdentifier isEqualToString:@"iPad6,3"] ||
        [deviceIdentifier isEqualToString:@"iPad6,4"]) return LZDeviceGenerationiPad_pro_inch_9__7;
    if ([deviceIdentifier isEqualToString:@"iPad7,3"] ||
        [deviceIdentifier isEqualToString:@"iPad7,4"]) return LZDeviceGenerationiPad_pro_inch_10__5;
	if ([deviceIdentifier isEqualToString:@"iPad8,1"] ||
		[deviceIdentifier isEqualToString:@"iPad8,2"] ||
		[deviceIdentifier isEqualToString:@"iPad8,3"] ||
		[deviceIdentifier isEqualToString:@"iPad8,4"]) return LZDeviceGenerationiPad_pro_inch_11_1st;
    if ([deviceIdentifier isEqualToString:@"iPad8,9"] ||
        [deviceIdentifier isEqualToString:@"iPad8,10"]) return LZDeviceGenerationiPad_pro_inch_11_2nd;
    if ([deviceIdentifier isEqualToString:@"iPad13,4"] ||
        [deviceIdentifier isEqualToString:@"iPad13,5"] ||
        [deviceIdentifier isEqualToString:@"iPad13,6"] ||
        [deviceIdentifier isEqualToString:@"iPad13,7"]) return LZDeviceGenerationiPad_pro_inch_11_3rd;
    if ([deviceIdentifier isEqualToString:@"iPad2,5"] ||
        [deviceIdentifier isEqualToString:@"iPad2,6"] ||
        [deviceIdentifier isEqualToString:@"iPad2,7"]) return LZDeviceGenerationiPad_mini1st;
    if ([deviceIdentifier isEqualToString:@"iPad4,4"] ||
        [deviceIdentifier isEqualToString:@"iPad4,5"] ||
        [deviceIdentifier isEqualToString:@"iPad4,6"]) return LZDeviceGenerationiPad_mini2nd;
    if ([deviceIdentifier isEqualToString:@"iPad4,7"] ||
        [deviceIdentifier isEqualToString:@"iPad4,8"] ||
        [deviceIdentifier isEqualToString:@"iPad4,9"]) return LZDeviceGenerationiPad_mini3rd;
    if ([deviceIdentifier isEqualToString:@"iPad5,1"] ||
        [deviceIdentifier isEqualToString:@"iPad5,2"]) return LZDeviceGenerationiPad_mini4th;
	if ([deviceIdentifier isEqualToString:@"iPad11,1"] ||
		[deviceIdentifier isEqualToString:@"iPad11,2"]) return LZDeviceGenerationiPad_mini5th;
    if ([deviceIdentifier isEqualToString:@"iPad14,1"] ||
        [deviceIdentifier isEqualToString:@"iPad14,2"]) return LZDeviceGenerationiPad_mini6th;
    // HomePod 型号
    if ([deviceIdentifier isEqualToString:@"AudioAccessory1,1"] ||
        [deviceIdentifier isEqualToString:@"AudioAccessory1,2"]) return LZDeviceGenerationiHomePod_1st;
    if ([deviceIdentifier isEqualToString:@"AudioAccessory5,1"]) return LZDeviceGenerationiHomePod_mini1st;
    // iTV 型号
    if ([deviceIdentifier isEqualToString:@"AppleTV1,1"]) return LZDeviceGenerationiTV1st;
    if ([deviceIdentifier isEqualToString:@"AppleTV2,1"]) return LZDeviceGenerationiTV2nd;
    if ([deviceIdentifier isEqualToString:@"AppleTV3,1"] ||
        [deviceIdentifier isEqualToString:@"AppleTV3,2"]) return LZDeviceGenerationiTV3rd;
    if ([deviceIdentifier isEqualToString:@"AppleTV5,3"]) return LZDeviceGenerationiTV4th;
    if ([deviceIdentifier isEqualToString:@"AppleTV6,2"]) return LZDeviceGenerationiTV4K_1st;
    if ([deviceIdentifier isEqualToString:@"AppleTV11,1"]) return LZDeviceGenerationiTV4K_2nd;
    // AirPods 型号
    if ([deviceIdentifier isEqualToString:@"AirPods1,1"]) return LZDeviceGenerationAirPods_1st;
    if ([deviceIdentifier isEqualToString:@"AirPods1,2"] ||
        [deviceIdentifier isEqualToString:@"AirPods2,1"]) return LZDeviceGenerationAirPods_2nd;
    if ([deviceIdentifier isEqualToString:@"AirPods1,3"] ||
        [deviceIdentifier isEqualToString:@"Audio2,1"]) return LZDeviceGenerationAirPods_3rd;
    if ([deviceIdentifier isEqualToString:@"AirPods2,2"] ||
        [deviceIdentifier isEqualToString:@"AirPodsPro1,1"] ||
        [deviceIdentifier isEqualToString:@"iProd8,1"]) return LZDeviceGenerationAirPods_pro_1st;
    if ([deviceIdentifier isEqualToString:@"AirPodsPro1,2"]) return LZDeviceGenerationAirPods_pro_2nd;
    if ([deviceIdentifier isEqualToString:@"AirPodsMax1,1"] ||
        [deviceIdentifier isEqualToString:@"iProd8,6"]) return LZDeviceGenerationAirPods_max;
    // AirTag 型号
    if ([deviceIdentifier isEqualToString:@"AirTag1,1"]) return LZDeviceGenerationAirTag_1st;
    // Mac 型号
    if ([deviceIdentifier isEqualToString:@"iMac9,1"] ||
        [deviceIdentifier isEqualToString:@"iMac10,1"]) return LZDeviceGenerationiMac_Y2009;
    if ([deviceIdentifier isEqualToString:@"iMac11,2"]) return LZDeviceGenerationiMac_inch_21__5_Y2010;
    if ([deviceIdentifier isEqualToString:@"iMac11,3"]) return LZDeviceGenerationiMac_inch_27_Y2010;
    if ([deviceIdentifier isEqualToString:@"iMac12,1"]) return LZDeviceGenerationiMac_inch_21__5_Y2011;
    if ([deviceIdentifier isEqualToString:@"iMac12,2"]) return LZDeviceGenerationiMac_inch_27_Y2011;
    if ([deviceIdentifier isEqualToString:@"iMac13,1"]) return LZDeviceGenerationiMac_inch_21__5_Y2012;
    if ([deviceIdentifier isEqualToString:@"iMac13,2"]) return LZDeviceGenerationiMac_inch_27_Y2012;
    if ([deviceIdentifier isEqualToString:@"iMac14,1"]) return LZDeviceGenerationiMac_inch_21__5_Y2013;
    if ([deviceIdentifier isEqualToString:@"iMac14,2"]) return LZDeviceGenerationiMac_inch_27_Y2013;
    if ([deviceIdentifier isEqualToString:@"iMac14,4"]) return LZDeviceGenerationiMac_inch_21__5_Y2014;
    if ([deviceIdentifier isEqualToString:@"iMac15,1"]) return LZDeviceGenerationiMac_inch_27_5K_Y2014;
    if ([deviceIdentifier isEqualToString:@"iMac16,1"]) return LZDeviceGenerationiMac_inch_21__5_Y2015;
    if ([deviceIdentifier isEqualToString:@"iMac16,2"]) return LZDeviceGenerationiMac_inch_21__5_4K_Y2015;
    if ([deviceIdentifier isEqualToString:@"iMac17,1"]) return LZDeviceGenerationiMac_inch_27_5K_Y2015;
    if ([deviceIdentifier isEqualToString:@"iMac18,1"]) return LZDeviceGenerationiMac_inch_21__5_Y2017;
    if ([deviceIdentifier isEqualToString:@"iMac18,2"]) return LZDeviceGenerationiMac_inch_21__5_4K_Y2017;
    if ([deviceIdentifier isEqualToString:@"iMac18,3"]) return LZDeviceGenerationiMac_inch_27_5K_Y2017;
    if ([deviceIdentifier isEqualToString:@"iMacPro1,1"]) return LZDeviceGenerationiMac_pro_inch_27_5K_Y2017;
    if ([deviceIdentifier isEqualToString:@"iMac19,2"]) return LZDeviceGenerationiMac_inch_21__5_4K_Y2019;
    if ([deviceIdentifier isEqualToString:@"iMac19,1"]) return LZDeviceGenerationiMac_inch_27_5K_Y2019;
    if ([deviceIdentifier isEqualToString:@"iMac20,1"] ||
        [deviceIdentifier isEqualToString:@"iMac20,2"]) return LZDeviceGenerationiMac_inch_27_5K_Y2020;
    if ([deviceIdentifier isEqualToString:@"iMac21,1"] ||
        [deviceIdentifier isEqualToString:@"iMac21,2"]) return LZDeviceGenerationiMac_inch_24_m1_Y2021;
    if ([deviceIdentifier isEqualToString:@"Mac15,4"] ||
        [deviceIdentifier isEqualToString:@"Mac15,5"]) return LZDeviceGenerationiMac_inch_24_m3_Y2023;
    if ([deviceIdentifier isEqualToString:@"Mac16,2"] ||
        [deviceIdentifier isEqualToString:@"Mac16,3"]) return LZDeviceGenerationiMac_inch_24_m4_Y2024;
    
    if ([deviceIdentifier isEqualToString:@"MacBook5,2"] ||
        [deviceIdentifier isEqualToString:@"MacBook6,1"]) return LZDeviceGenerationMacBook_inch_13_Y2009;
    if ([deviceIdentifier isEqualToString:@"MacBook7,1"]) return LZDeviceGenerationMacBook_inch_13_Y2010;
    if ([deviceIdentifier isEqualToString:@"MacBook8,1"]) return LZDeviceGenerationMacBook_inch_12_Y2015;
    if ([deviceIdentifier isEqualToString:@"MacBook9,1"]) return LZDeviceGenerationMacBook_inch_12_Y2016;
    if ([deviceIdentifier isEqualToString:@"MacBook10,1"]) return LZDeviceGenerationMacBook_inch_12_Y2017;
    
    if ([deviceIdentifier isEqualToString:@"MacBookAir2,1"]) return LZDeviceGenerationMacBook_air_inch_13_Y2009;
    if ([deviceIdentifier isEqualToString:@"MacBookAir3,1"]) return LZDeviceGenerationMacBook_air_inch_11_Y2010;
    if ([deviceIdentifier isEqualToString:@"MacBookAir3,2"]) return LZDeviceGenerationMacBook_air_inch_13_Y2010;
    if ([deviceIdentifier isEqualToString:@"MacBookAir4,1"]) return LZDeviceGenerationMacBook_air_inch_11_Y2011;
    if ([deviceIdentifier isEqualToString:@"MacBookAir4,2"]) return LZDeviceGenerationMacBook_air_inch_13_Y2011;
    if ([deviceIdentifier isEqualToString:@"MacBookAir5,1"]) return LZDeviceGenerationMacBook_air_inch_11_Y2012;
    if ([deviceIdentifier isEqualToString:@"MacBookAir5,2"]) return LZDeviceGenerationMacBook_air_inch_13_Y2012;
    if ([deviceIdentifier isEqualToString:@"MacBookAir6,1"]) return LZDeviceGenerationMacBook_air_inch_11_Y2013;
    if ([deviceIdentifier isEqualToString:@"MacBookAir6,2"]) return LZDeviceGenerationMacBook_air_inch_13_Y2013;
    if ([deviceIdentifier isEqualToString:@"MacBookAir7,1"]) return LZDeviceGenerationMacBook_air_inch_11_Y2015;
    if ([deviceIdentifier isEqualToString:@"MacBookAir7,2"]) return LZDeviceGenerationMacBook_air_inch_13_Y2015;
    if ([deviceIdentifier isEqualToString:@"MacBookAir8,1"]) return LZDeviceGenerationMacBook_air_inch_13_Y2018;
    if ([deviceIdentifier isEqualToString:@"MacBookAir8,2"]) return LZDeviceGenerationMacBook_air_inch_13_Y2019;
    if ([deviceIdentifier isEqualToString:@"MacBookAir9,1"]) return LZDeviceGenerationMacBook_air_inch_13_Y2020;
    if ([deviceIdentifier isEqualToString:@"MacBookAir10,1"]) return LZDeviceGenerationMacBook_air_inch_13_m1_Y2020;
    if ([deviceIdentifier isEqualToString:@"Mac14,2"]) return LZDeviceGenerationMacBook_air_inch_13_m2_Y2022;
    if ([deviceIdentifier isEqualToString:@"Mac14,15"]) return LZDeviceGenerationMacBook_air_inch_15_m2_Y2023;
    if ([deviceIdentifier isEqualToString:@"Mac15,12"]) return LZDeviceGenerationMacBook_air_inch_13_m3_Y2024;
    if ([deviceIdentifier isEqualToString:@"Mac15,13"]) return LZDeviceGenerationMacBook_air_inch_15_m3_Y2024;
    if ([deviceIdentifier isEqualToString:@"Mac16,12"]) return LZDeviceGenerationMacBook_air_inch_13_m4_Y2025;
    if ([deviceIdentifier isEqualToString:@"Mac16,13"]) return LZDeviceGenerationMacBook_air_inch_15_m4_Y2025;
    
    if ([deviceIdentifier isEqualToString:@"MacBookPro17,1"]) return LZDeviceGenerationMac_pro_m1_inch_13_1st;
    if ([deviceIdentifier isEqualToString:@"MacBookPro18,3"] ||
        [deviceIdentifier isEqualToString:@"MacBookPro18,4"]) return LZDeviceGenerationMac_pro_m1_inch_14_1st;
    if ([deviceIdentifier isEqualToString:@"MacBookPro18,1"] ||
        [deviceIdentifier isEqualToString:@"MacBookPro18,2"]) return LZDeviceGenerationMac_pro_m1_inch_16_1st;
    
    if ([deviceIdentifier isEqualToString:@"Macmini3,1"]) return LZDeviceGenerationMacMini_Y2009;
    if ([deviceIdentifier isEqualToString:@"Macmini4,1"]) return LZDeviceGenerationMacMini_Y2010;
    if ([deviceIdentifier isEqualToString:@"Macmini5,1"] ||
        [deviceIdentifier isEqualToString:@"Macmini5,2"]) return LZDeviceGenerationMacMini_Y2011;
    if ([deviceIdentifier isEqualToString:@"Macmini6,1"] ||
        [deviceIdentifier isEqualToString:@"Macmini6,2"]) return LZDeviceGenerationMacMini_Y2012;
    if ([deviceIdentifier isEqualToString:@"Macmini7,1"]) return LZDeviceGenerationMacMini_Y2014;
    if ([deviceIdentifier isEqualToString:@"Macmini8,1"]) return LZDeviceGenerationMacMini_Y2018;
    if ([deviceIdentifier isEqualToString:@"Macmini9,1"]) return LZDeviceGenerationMacMini_m1_Y2020;
    if ([deviceIdentifier isEqualToString:@"Mac14,3"]) return LZDeviceGenerationMacMini_m2_Y2023;
    if ([deviceIdentifier isEqualToString:@"Mac14,12"]) return LZDeviceGenerationMacMini_m2_pro_Y2023;
    if ([deviceIdentifier isEqualToString:@"Mac16,10"] ||
        [deviceIdentifier isEqualToString:@"Mac16,11"]) return LZDeviceGenerationMacMini_m4_Y2024;
    
    if ([deviceIdentifier isEqualToString:@"Mac13,2"]) return LZDeviceGenerationMacStudio_m1_ultra_Y2022;
    if ([deviceIdentifier isEqualToString:@"Mac13,1"]) return LZDeviceGenerationMacStudio_m1_max_Y2022;
    if ([deviceIdentifier isEqualToString:@"Mac14,14"]) return LZDeviceGenerationMacStudio_m2_ultra_Y2023;
    if ([deviceIdentifier isEqualToString:@"Mac14,13"]) return LZDeviceGenerationMacStudio_m2_max_Y2023;
    if ([deviceIdentifier isEqualToString:@"Mac15,14"]) return LZDeviceGenerationMacStudio_m3_ultra_Y2025;
    if ([deviceIdentifier isEqualToString:@"Mac16,9"]) return LZDeviceGenerationMacStudio_m4_max_Y2025;

    if ([deviceIdentifier isEqualToString:@"MacPro4,1"]) return LZDeviceGenerationMacPro_Y2009;
    if ([deviceIdentifier isEqualToString:@"MacPro5,1"]) return LZDeviceGenerationMacPro_Y2010;
    if ([deviceIdentifier isEqualToString:@"MacPro6,1"]) return LZDeviceGenerationMacPro_Y2013;
    if ([deviceIdentifier isEqualToString:@"MacPro7,1"]) return LZDeviceGenerationMacPro_Y2019;
    if ([deviceIdentifier isEqualToString:@"Mac14,8"]) return LZDeviceGenerationMacPro_Y2023;
    
    // 未知
    return LZDeviceGenerationUnspecified;
}

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
        case LZDeviceGenerationiPhoneSE3rd:
            return @"iPhone SE (3rd generation)";
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
        case LZDeviceGenerationiPhone12_mini:
            return @"iPhone 12 mini";
            break;
        case LZDeviceGenerationiPhone12:
            return @"iPhone 12";
            break;
        case LZDeviceGenerationiPhone12_pro:
            return @"iPhone 12 Pro";
            break;
        case LZDeviceGenerationiPhone12_pro_max:
            return @"iPhone 12 Pro Max";
            break;
        case LZDeviceGenerationiPhone13_mini:
            return @"iPhone 13 mini";
            break;
        case LZDeviceGenerationiPhone13:
            return @"iPhone 13";
            break;
        case LZDeviceGenerationiPhone13_pro:
            return @"iPhone 13 Pro";
            break;
        case LZDeviceGenerationiPhone13_pro_max:
            return @"iPhone 13 Pro Max";
            break;
        case LZDeviceGenerationiPhone14:
            return @"iPhone 14";
            break;
        case LZDeviceGenerationiPhone14_plus:
            return @"iPhone 14 Plus";
            break;
        case LZDeviceGenerationiPhone14_pro:
            return @"iPhone 14 Pro";
            break;
        case LZDeviceGenerationiPhone14_pro_max:
            return @"iPhone 14 Pro Max";
            break;
        case LZDeviceGenerationiPhone15:
            return @"iPhone 15";
            break;
        case LZDeviceGenerationiPhone15_plus:
            return @"iPhone 15 Plus";
            break;
        case LZDeviceGenerationiPhone15_pro:
            return @"iPhone 15 Pro";
            break;
        case LZDeviceGenerationiPhone15_pro_max:
            return @"iPhone 15 Pro Max";
            break;
        case LZDeviceGenerationiPhone16:
            return @"iPhone 16";
            break;
        case LZDeviceGenerationiPhone16_plus:
            return @"iPhone 16 Plus";
            break;
        case LZDeviceGenerationiPhone16_pro:
            return @"iPhone 16 Pro";
            break;
        case LZDeviceGenerationiPhone16_pro_max:
            return @"iPhone 16 Pro Max";
            break;
        case LZDeviceGenerationiPhone16e:
            return @"iPhone 16e";
            // iPod 型号
        case LZDeviceGenerationiPodtouch1st:
            return @"iPod touch (1st generation)";
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
        case LZDeviceGenerationiWatch_SE_1st:
            return @"Apple Watch SE (1st generation)";
            break;
        case LZDeviceGenerationiWatch_SE_2nd:
            return @"Apple Watch SE (2nd generation)";
            break;
        case LZDeviceGenerationiWatch_series6:
            return @"Apple Watch Series 6";
            break;
        case LZDeviceGenerationiWatch_series7:
            return @"Apple Watch Series 7";
            break;
        case LZDeviceGenerationiWatch_series8:
            return @"Apple Watch Series 8";
            break;
        case LZDeviceGenerationiWatch_ultra_1st:
            return @"Apple Watch Ultra (1st generation)";
            break;
            // iPad 型号
        case LZDeviceGenerationiPad1st:
            return @"iPad (1st generation)";
            break;
        case LZDeviceGenerationiPad2nd:
            return @"iPad (2nd generation)";
            break;
        case LZDeviceGenerationiPad3rd:
            return @"iPad (3rd generation)";
            break;
        case LZDeviceGenerationiPad4th:
            return @"iPad (4th generation)";
            break;
        case LZDeviceGenerationiPad5th:
            return @"iPad (5th generation)";
            break;
        case LZDeviceGenerationiPad6th:
            return @"iPad (6th generation)";
            break;
        case LZDeviceGenerationiPad7th:
            return @"iPad (7th generation)";
            break;
        case LZDeviceGenerationiPad8th:
            return @"iPad (8th generation)";
            break;
        case LZDeviceGenerationiPad9th:
            return @"iPad (9th generation)";
            break;
        case LZDeviceGenerationiPad10th:
            return @"iPad (10th generation)";
            break;
        case LZDeviceGenerationiPad_air1st:
            return @"iPad Air (1st generation)";
            break;
        case LZDeviceGenerationiPad_air2nd:
            return @"iPad Air (2nd generation)";
            break;
        case LZDeviceGenerationiPad_air3rd:
            return @"iPad Air (3rd generation)";
            break;
        case LZDeviceGenerationiPad_air4th:
            return @"iPad Air (4th generation)";
            break;
        case LZDeviceGenerationiPad_pro_inch_12__9_1st:
            return @"iPad Pro (12.9-inch, 1st generation)";
            break;
        case LZDeviceGenerationiPad_pro_inch_12__9_2nd:
            return @"iPad Pro (12.9-inch, 2nd generation)";
            break;
        case LZDeviceGenerationiPad_pro_inch_12__9_3rd:
            return @"iPad Pro (12.9-inch, 3rd generation)";
            break;
        case LZDeviceGenerationiPad_pro_inch_12__9_4th:
            return @"iPad Pro (12.9-inch, 4th generation)";
            break;
        case LZDeviceGenerationiPad_pro_inch_12__9_5th:
            return @"iPad Pro (12.9-inch, 5th generation)";
            break;
        case LZDeviceGenerationiPad_pro_inch_9__7:
            return @"iPad Pro (9.7-inch)";
            break;
        case LZDeviceGenerationiPad_pro_inch_10__5:
            return @"iPad Pro (10.5-inch)";
            break;
        case LZDeviceGenerationiPad_pro_inch_11_1st:
            return @"iPad Pro (11-inch, 1st generation)";
            break;
        case LZDeviceGenerationiPad_pro_inch_11_2nd:
            return @"iPad Pro (11-inch, 2nd generation)";
            break;
        case LZDeviceGenerationiPad_pro_inch_11_3rd:
            return @"iPad Pro (11-inch, 3rd generation)";
            break;
        case LZDeviceGenerationiPad_mini1st:
            return @"iPad mini (1st generation)";
            break;
        case LZDeviceGenerationiPad_mini2nd:
            return @"iPad mini (2nd generation)";
            break;
        case LZDeviceGenerationiPad_mini3rd:
            return @"iPad mini (3rd generation)";
            break;
        case LZDeviceGenerationiPad_mini4th:
            return @"iPad mini (4th generation)";
            break;
        case LZDeviceGenerationiPad_mini5th:
            return @"iPad mini (5th generation)";
            break;
        case LZDeviceGenerationiPad_mini6th:
            return @"iPad mini (6th generation)";
            break;
            // HomePod 型号
        case LZDeviceGenerationiHomePod_1st:
            return @"HomePod";
            break;
        case LZDeviceGenerationiHomePod_mini1st:
            return @"HomePod mini";
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
        case LZDeviceGenerationiTV4K_1st:
            return @"Apple TV 4K";
            break;
        case LZDeviceGenerationiTV4K_2nd:
            return @"Apple TV 4K (2nd generation";
            break;
        case LZDeviceGenerationAirPods_1st:
            return @"AirPods (1st generation)";
            break;
        case LZDeviceGenerationAirPods_2nd:
            return @"AirPods (2nd generation)";
            break;
        case LZDeviceGenerationAirPods_3rd:
            return @"AirPods (3rd generation)";
            break;
        case LZDeviceGenerationAirPods_pro_1st:
            return @"AirPods Pro (1st generation)";
            break;
        case LZDeviceGenerationAirPods_pro_2nd:
            return @"AirPods Pro (2nd generation)";
            break;
        case LZDeviceGenerationAirPods_max:
            return @"AirPods Max";
            break;
            // AirTag 型号
        case LZDeviceGenerationAirTag_1st:
            return @"AirTag";
            break;
            // Mac 型号
        case LZDeviceGenerationiMac_Y2009:
            return @"iMac (21.5~27-inch, 2009)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_Y2010:
            return @"iMac (21.5-inch, 2010)";
            break;
        case LZDeviceGenerationiMac_inch_27_Y2010:
            return @"iMac (27-inch, 2010)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_Y2011:
            return @"iMac (21.5-inch, 2011)";
            break;
        case LZDeviceGenerationiMac_inch_27_Y2011:
            return @"iMac (27-inch, 2011)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_Y2012:
            return @"iMac (21.5-inch, 2012)";
            break;
        case LZDeviceGenerationiMac_inch_27_Y2012:
            return @"iMac (27-inch, 2012)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_Y2013:
            return @"iMac (21.5-inch, 2013)";
            break;
        case LZDeviceGenerationiMac_inch_27_Y2013:
            return @"iMac (27-inch, 2013)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_Y2014:
            return @"iMac (21.5-inch, 2014)";
            break;
        case LZDeviceGenerationiMac_inch_27_5K_Y2014:
            return @"iMac (27-inch, 5K, 2014)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_Y2015:
            return @"iMac (21.5-inch, 2015)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_4K_Y2015:
            return @"iMac (21.5-inch, 4K, 2015)";
            break;
        case LZDeviceGenerationiMac_inch_27_5K_Y2015:
            return @"iMac (27-inch, 5K, 2015)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_Y2017:
            return @"iMac (21.5-inch, 2017)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_4K_Y2017:
            return @"iMac (21.5-inch, 4K, 2017)";
            break;
        case LZDeviceGenerationiMac_inch_27_5K_Y2017:
            return @"iMac (27-inch, 5K, 2017)";
            break;
        case LZDeviceGenerationiMac_pro_inch_27_5K_Y2017:
            return @"iMac Pro (27-inch, 5K, 2017)";
            break;
        case LZDeviceGenerationiMac_inch_21__5_4K_Y2019:
            return @"iMac (21.5-inch, 2019)";
            break;
        case LZDeviceGenerationiMac_inch_27_5K_Y2019:
            return @"iMac (27-inch, 5K, 2019)";
            break;
        case LZDeviceGenerationiMac_inch_27_5K_Y2020:
            return @"iMac (27-inch, 5K, 2020)";
            break;
        case LZDeviceGenerationiMac_inch_24_m1_Y2021:
            return @"iMac (24-inch, M1, 2021)";
            break;
        case LZDeviceGenerationiMac_inch_24_m3_Y2023:
            return @"iMac (24-inch, M3, 2023)";
            break;
        case LZDeviceGenerationiMac_inch_24_m4_Y2024:
            return @"iMac (24-inch, M4, 2024)";
            break;
            
        case LZDeviceGenerationMacBook_inch_13_Y2009:
            return @"MacBook (13-inch, 2009)";
            break;
        case LZDeviceGenerationMacBook_inch_13_Y2010:
            return @"MacBook (13-inch, 2010)";
            break;
        case LZDeviceGenerationMacBook_inch_12_Y2015:
            return @"MacBook (12-inch, 2015)";
            break;
        case LZDeviceGenerationMacBook_inch_12_Y2016:
            return @"MacBook (12-inch, 2016)";
            break;
        case LZDeviceGenerationMacBook_inch_12_Y2017:
            return @"MacBook (12-inch, 2017)";
            break;
            
        case LZDeviceGenerationMacBook_air_inch_13_Y2009:
            return @"MacBook Air (13-inch, 2009)";
            break;
        case LZDeviceGenerationMacBook_air_inch_11_Y2010:
            return @"MacBook Air (11-inch, 2010)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2010:
            return @"MacBook Air (13-inch, 2010)";
            break;
        case LZDeviceGenerationMacBook_air_inch_11_Y2011:
            return @"MacBook Air (11-inch, 2011)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2011:
            return @"MacBook Air (13-inch, 2011)";
            break;
        case LZDeviceGenerationMacBook_air_inch_11_Y2012:
            return @"MacBook Air (11-inch, 2012)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2012:
            return @"MacBook Air (13-inch, 2012)";
            break;
        case LZDeviceGenerationMacBook_air_inch_11_Y2013:
            return @"MacBook Air (11-inch, 2013)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2013:
            return @"MacBook Air (13-inch, 2013)";
            break;
        case LZDeviceGenerationMacBook_air_inch_11_Y2014:
            return @"MacBook Air (11-inch, 2014)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2014:
            return @"MacBook Air (13-inch, 2014)";
            break;
        case LZDeviceGenerationMacBook_air_inch_11_Y2015:
            return @"MacBook Air (11-inch, 2015)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2015:
            return @"MacBook Air (13-inch, 2015)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2017:
            return @"MacBook Air (13-inch, 2017)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2018:
            return @"MacBook Air (13-inch, 2018)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2019:
            return @"MacBook Air (13-inch, 2019)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_Y2020:
            return @"MacBook Air (13-inch, 2020)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_m1_Y2020:
            return @"MacBook Air (13-inch, M1, 2020)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_m2_Y2022:
            return @"MacBook Air (13-inch, M2, 2022)";
            break;
        case LZDeviceGenerationMacBook_air_inch_15_m2_Y2023:
            return @"MacBook Air (15-inch, M2, 2023)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_m3_Y2024:
            return @"MacBook Air (13-inch, M3, 2024)";
            break;
        case LZDeviceGenerationMacBook_air_inch_15_m3_Y2024:
            return @"MacBook Air (15-inch, M3, 2024)";
            break;
        case LZDeviceGenerationMacBook_air_inch_13_m4_Y2025:
            return @"MacBook Air (13-inch, M4, 2025)";
            break;
        case LZDeviceGenerationMacBook_air_inch_15_m4_Y2025:
            return @"MacBook Air (15-inch, M4, 2025)";
            break;
            
        case LZDeviceGenerationMac_pro_m1_inch_13_1st:
            return @"MacBook Pro (13-inch, M1, 2020)";
            break;
        case LZDeviceGenerationMac_pro_m1_inch_14_1st:
            return @"MacBook Pro (14-inch, 2021)";
            break;
        case LZDeviceGenerationMac_pro_m1_inch_16_1st:
            return @"MacBook Pro (16-inch, 2021";
            break;
            
        case LZDeviceGenerationMacMini_Y2009:
            return @"Mac Mini（2009）";
            break;
        case LZDeviceGenerationMacMini_Y2010:
            return @"Mac Mini（2010）";
            break;
        case LZDeviceGenerationMacMini_Y2011:
            return @"Mac Mini（2011）";
            break;
        case LZDeviceGenerationMacMini_Y2012:
            return @"Mac Mini（2012）";
            break;
        case LZDeviceGenerationMacMini_Y2014:
            return @"Mac Mini（2014）";
            break;
        case LZDeviceGenerationMacMini_Y2018:
            return @"Mac Mini（2018）";
            break;
        case LZDeviceGenerationMacMini_m1_Y2020:
            return @"Mac Mini (M1, 2020)";
            break;
        case LZDeviceGenerationMacMini_m2_Y2023:
            return @"Mac Mini (M2, 2023)";
            break;
        case LZDeviceGenerationMacMini_m2_pro_Y2023:
            return @"Mac Mini (M2 Pro, 2023)";
            break;
        case LZDeviceGenerationMacMini_m4_Y2024:
            return @"Mac Mini (M4, 2024)";
            break;
            
        case LZDeviceGenerationMacStudio_m1_ultra_Y2022:
            return @"Mac Studio (M1 Ultra, 2022)";
            break;
        case LZDeviceGenerationMacStudio_m1_max_Y2022:
            return @"Mac Studio (M1 Max, 2022)";
            break;
        case LZDeviceGenerationMacStudio_m2_ultra_Y2023:
            return @"Mac Studio (M2 Ultra, 2023)";
            break;
        case LZDeviceGenerationMacStudio_m2_max_Y2023:
            return @"Mac Studio (M2 Max, 2023)";
            break;
        case LZDeviceGenerationMacStudio_m3_ultra_Y2025:
            return @"Mac Studio (M3 Ultra, 2025)";
            break;
        case LZDeviceGenerationMacStudio_m4_max_Y2025:
            return @"Mac Studio (M4 Max, 2025)";
            break;
            
        case LZDeviceGenerationMacPro_Y2009:
            return @"Mac Pro (2009)";
            break;
        case LZDeviceGenerationMacPro_Y2010:
            return @"Mac Pro (2010)";
            break;
        case LZDeviceGenerationMacPro_Y2012:
            return @"Mac Pro (2012)";
            break;
        case LZDeviceGenerationMacPro_Y2013:
            return @"Mac Pro (2013)";
            break;
        case LZDeviceGenerationMacPro_Y2019:
            return @"Mac Pro (2019)";
            break;
        case LZDeviceGenerationMacPro_Y2023:
            return @"Mac Pro (2023)";
            break;
            
        case LZDeviceGenerationUnspecified:
        default:
            return _deviceIdentifier();
            break;
    }
}

NSString * _DeviceUUID(void) {
	return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

NSString * _uuid_create(void) {
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

NSString * _name(void) {
    return _device().name;
}

NSString * _model(void) {
    return _device().model;
}

NSString * _localizedModel(void) {
    return _device().localizedModel;
}

NSString * _systemName(void) {
    return _device().systemName;
}

static NSString * _systemVersion(void) {
    
    static NSString *systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = _device().systemVersion;
    });
    return systemVersion;
}

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

float _batteryLevel(void) {
    if (NO == _device().isBatteryMonitoringEnabled) [_device() setBatteryMonitoringEnabled:YES];
    float batteryLevel = _device().batteryLevel;
    return batteryLevel;
}

NSString * _batteryLevel_desc(void) {

    float batteryLevel = _batteryLevel();
    if (-1 == batteryLevel) return @"未知";
    NSString *percentPower = [NSString stringWithFormat:@"%.0f%%", batteryLevel * 100];
    return percentPower;
}

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

NSString * _diskTotalSpace_desc(void) {

    int64_t totalSpace = _diskTotalSpace();
    if (totalSpace == -1) {
        return @"未知";
    }
    NSString *totalSpaceDesc = [NSString stringWithFormat:@"%.2lfG", totalSpace * 0.001 * 0.001 * 0.001];
    return totalSpaceDesc;
}

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

NSString * _diskFreeSpace_desc(void) {

    int64_t freeSpace = _diskFreeSpace();
    if (freeSpace == -1) {
        return @"未知";
    }
    NSString *freeSpaceDesc = [NSString stringWithFormat:@"%.2lfG", freeSpace * 0.001 * 0.001 * 0.001];
    return freeSpaceDesc;
}

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

NSString * _diskUsedSpace_desc(void) {

    int64_t usedSpace = _diskusedSpace();
    if (usedSpace == -1) {
        return @"未知";
    }
    NSString *usedSpaceDesc = [NSString stringWithFormat:@"%.2lfG", usedSpace * 0.001 * 0.001 * 0.001];
    return usedSpaceDesc;
}

UInt64 _memoryTotalSpace(void) {
    
    int64_t totaolMemory = [[NSProcessInfo processInfo] physicalMemory];
    if (totaolMemory < -1) {
        totaolMemory = -1;
    }
    return totaolMemory;
}

NSString * _memoryTotalSpace_desc(void) {
    return [NSString stringWithFormat:@"%.1fG", _memoryTotalSpace() * 0.001 * 0.001 * 0.001];
}

UInt64 _memoryAvaiableSpace(void) {
    
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t count = HOST_VM_INFO64_COUNT;
    
    vm_size_t page_size;
    vm_statistics64_data_t vminfo;
    host_page_size(host_port, &page_size);
    host_statistics64(host_port, HOST_VM_INFO64, (host_info64_t)&vminfo,&count);
    
    uint64_t free_size = (vminfo.free_count + vminfo.external_page_count + vminfo.purgeable_count - vminfo.speculative_count) * page_size;
    return free_size;
#if 0
    NSInteger memoryLimit = 0;
    // 获取当前内存使用数据
    if (@available(iOS 13.0, *)) {
        
        task_vm_info_data_t vmInfo;
        mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
        kern_return_t kr = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&vmInfo, &count);
        if (kr == KERN_SUCCESS) {
            // 间接获取一下当前进程可用的最大内存上限
            // iOS13+可以这样计算：当前进程占用内存+还可以使用的内存=上限值
            NSInteger memoryCanBeUse = (NSInteger)(os_proc_available_memory());
            if (memoryCanBeUse > 0) {
                
                NSInteger memoryUsed = (NSInteger)(vmInfo.phys_footprint);
                memoryLimit = memoryUsed + memoryCanBeUse;
            }
        }
    }
    if (memoryLimit <= 0) {
        
        NSInteger deviceMemory = [NSProcessInfo processInfo].physicalMemory;
        memoryLimit = deviceMemory * 0.55;
    }
    if (memoryLimit <= 0) {
        // 这个值一般要小很多, 上面都获取不到才使用
        mach_port_t host_port = mach_host_self();
        mach_msg_type_number_t host_size = HOST_VM_INFO_COUNT;
        vm_size_t page_size;
        vm_statistics_data_t vm_stat;
        kern_return_t kern;
        kern = host_page_size(host_port, &page_size);
        if (kern == KERN_SUCCESS) {
            
            kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
            if (kern == KERN_SUCCESS) {
                memoryLimit = vm_stat.free_count * page_size;
            }
        }
    }
    return memoryLimit;
#endif
}

NSString * _memoryAvaiableSpace_desc(void) {
    return [NSString stringWithFormat:@"%.1fG", _memoryAvaiableSpace() * 0.001 * 0.001 * 0.001];
}

UInt64 _memoryUsedSpace(void) {
    
    UInt64 memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if (kernelReturn == KERN_SUCCESS) {
        memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
        NSLog(@"Memory in use (in bytes): %lld", memoryUsageInByte);
    } else {
        
        mach_port_t host_port = mach_task_self();
        task_basic_info_data_t taskInfo;
        mach_msg_type_number_t host_size = TASK_BASIC_INFO_COUNT;
        kern_return_t kernReturn = task_info(host_port, TASK_BASIC_INFO, (task_info_t)&taskInfo, &host_size);
        if (kernReturn == KERN_SUCCESS) {
            memoryUsageInByte = taskInfo.resident_size;
        } else {
            NSLog(@"Error with task_info(): %s", mach_error_string(kernelReturn));
        }
    }
    return memoryUsageInByte;
}

NSString * _memoryUsedSpace_desc(void) {
    return [NSString stringWithFormat:@"%.1fM", _memoryUsedSpace() * 0.001 * 0.001];
}

NSString * _CPUCount(void) {

    NSUInteger CPUCount = [NSProcessInfo processInfo].activeProcessorCount;
	NSString *CPUCountDesc = [NSString stringWithFormat:@"%lu", (unsigned long)CPUCount];
    return CPUCountDesc;
}

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
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
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

NSDate * _restartDate(void) {

    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    NSDate *lastRestartDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
    return lastRestartDate;
}

BOOL _is_jailbreak_existPath(void) {
    
    NSArray * jailbreak_pathes = @[
        @"/Applications/Cydia.app",
        @"/Applications/limera1n.app",
        @"/Applications/greenpois0n.app",
        @"/Applications/blackra1n.app",
        @"/Applications/blacksn0w.app",
        @"/Applications/redsn0w.app",
        @"/Applications/Absinthe.app",
        @"/Library/MobileSubstrate/MobileSubstrate.dylib",
//        @"/bin/bash",
//        @"/usr/sbin/sshd",
        @"/etc/apt",
        @"/private/var/lib/apt/",
    ];
    for (NSString *path in jailbreak_pathes) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return YES;
        }
    }
    return NO;
}

BOOL _is_jailbreak_checkCydia(void) {
    
    struct stat stat_info;
    BOOL exist = 0 == stat("/Applications/Cydia.app", &stat_info);
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]];
    return exist || canOpen;
}

BOOL _is_jailbreak_checkInject(void) {
    
    int ret ;
    Dl_info dylib_info;
    char *dylib_name = "/usr/lib/system/libsystem_kernel.dylib";
    int (*func_stat)(const char *, struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        return 0 != strcmp(dylib_info.dli_fname, dylib_name);
    }
    return NO;
}

BOOL _is_jailbreak_checkDylibs(void) {
    
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i) {
        if (strcmp(_dyld_get_image_name(i), "Library/MobileSubstrate/MobileSubstrate.dylib") == 0) {
            return YES;
        }
    }
    return NO;
}

BOOL _is_jailbreak_checkEnv(void) {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    return nil != env;
}

BOOL _is_jailbreak_canGetApplicationList(void) {
    
    NSString *applicationPath = @"/User/Applications/";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (NO == [fileManager fileExistsAtPath:applicationPath]) {
        return NO;
    }
    NSArray *appList = [fileManager contentsOfDirectoryAtPath:applicationPath error:NULL];
    return nil != appList && appList.count;
}

BOOL _is_jailbreak(void) {
    if (LZDeviceGenerationSimulator == _generation()) {
        return NO;
    }
    return _is_jailbreak_existPath()
    || _is_jailbreak_checkCydia()
    || _is_jailbreak_checkInject()
    || _is_jailbreak_checkDylibs()
//    || _is_jailbreak_checkEnv()
    || _is_jailbreak_canGetApplicationList();
}

BOOL _is_simulator(void) {
    return (_generation() == LZDeviceGenerationSimulator ? YES : NO);
}

BOOL _is_iPhone(void) {
    return (_userInterfaceIdiom() == LZUserInterfaceIdiomPhone ? YES : NO);
}

BOOL _is_iPad(void) {
    return (_userInterfaceIdiom() == LZUserInterfaceIdiomPad ? YES : NO);
}

BOOL _is_iTV(void) {
    return (_userInterfaceIdiom() == LZUserInterfaceIdiomTV ? YES : NO);
}

BOOL _is_carPlay(void) {
    return (_userInterfaceIdiom() == LZUserInterfaceIdiomCarPlay ? YES : NO);
}

BOOL _is_mac(void) {
    if (@available(iOS 14.0, *)) {
        return (_userInterfaceIdiom() == LZUserInterfaceIdiomMac ? YES : NO);
    } else {
        return NO;
    }
}

BOOL _version_equal_to(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] == NSOrderedSame);
}

BOOL _version_greater_than(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] == NSOrderedDescending);
}

BOOL _version_greater_than_or_equal_to(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] != NSOrderedAscending);
}

BOOL _version_less_than(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] == NSOrderedAscending);
}

BOOL _version_less_than_or_equal_to(NSString *version) {
    return ([_systemVersion() compare:version options:NSNumericSearch] != NSOrderedDescending);
}

NSArray * _languages_support(void) {
    
    static NSArray *languageArrI;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        languageArrI = [NSLocale preferredLanguages];
    });
    return languageArrI;
}

NSString * _language_full_name(void) {
    return ([_languages_support() objectAtIndex:0]);
}

NSString * _language_short_name(void) {
    
    static NSString *languageShortName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        languageShortName = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    });
    return languageShortName;
}

CGSize _screen_size(void) {
    
    static CGSize size = {0, 0};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        UIScreen *screen = nil;
        if (@available(iOS 13.0, *)) {
            
            UIWindowScene *scene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
            screen = scene.screen;
        } else {
            screen = [UIScreen mainScreen];
        }
        size = screen.bounds.size;
    });
    return size;
}

CGFloat _screen_width(void) {
    return (_screen_size().width);
}

CGFloat _screen_height(void) {
    return (_screen_size().height);
}

CGFloat _screen_max_lenght(void) {
    return (MAX(_screen_width(), _screen_height()));
}

CGFloat _screen_min_lenght(void) {
    return (MIN(_screen_width(), _screen_height()));
}

CGFloat _screen_scale(void) {

    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [[UIScreen mainScreen] scale];
    });
    return scale;
}

BOOL _screen_retina(void) {
    return (_screen_scale() > 1 ? YES : NO);
}

BOOL _is_notch(void) {
    
    BOOL isNotch = NO;
    if (@available(iOS 11.0, *)) {
        
        UIWindow *mainWindow = LZAppUnit.keyWindow();
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            isNotch = YES;
        }
    }
	return isNotch;
}

NSString * _carrierName(void) {
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = nil;
    if (@available(iOS 12.0, *)) {
        
        NSDictionary<NSString *, CTCarrier *> *providers = info.serviceSubscriberCellularProviders;
        for (CTCarrier *obj in providers.allValues) {
            if ([obj isKindOfClass:[CTCarrier class]]) {
                carrier = obj;
                break;
            }
        }
    } else {
        carrier = info.subscriberCellularProvider;
    }
    NSString *carrierName = carrier.carrierName;
    return carrierName ? carrierName : @"未知";
}

NSString * _stringWithbytes(u_int32_t bytes) {
    if (bytes < 1024) { // B
        return [NSString stringWithFormat:@"%dB", bytes];
    } else if (bytes >= 1024 && bytes < 1024 * 1024) { // KB
        return [NSString stringWithFormat:@"%.0fKB", (double)bytes / 1024];
    } else if (bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024) { // MB
        return [NSString stringWithFormat:@"%.1fMB", (double)bytes / (1024 * 1024)];
    } else { // GB
        return [NSString stringWithFormat:@"%.1fGB", (double)bytes / (1024 * 1024 * 1024)];
    }
}

NSDictionary * _currentNetSpeed(void) {
    
    u_int32_t iBytes = 0;
    u_int32_t oBytes = 0;
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) != -1) {
        
        u_int32_t allFlow = 0;
        for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
            if (AF_LINK != ifa->ifa_addr->sa_family) {
                continue;
            }
            if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING)) {
                continue;
            }
            if (ifa->ifa_data == 0) {
                continue;
            }
            // network
            if (strncmp(ifa->ifa_name, "lo0", 2)) {
                
                struct if_data* if_data = (struct if_data*)ifa->ifa_data;
                oBytes += if_data->ifi_obytes;
                iBytes += if_data->ifi_ibytes;
                allFlow = iBytes + oBytes;
            }
        }
    }
    freeifaddrs(ifa_list);
    static u_int32_t _iBytes = 0;
    static u_int32_t _oBytes = 0;
    NSString *downloadNetSpeed = [_stringWithbytes(0) stringByAppendingString:@"/s"];
    NSString *uploadNetSpeed = [_stringWithbytes(0) stringByAppendingString:@"/s"];
    if (_iBytes != 0) {
        downloadNetSpeed = [_stringWithbytes(iBytes - _iBytes) stringByAppendingString:@"/s"];
    }
    _iBytes = iBytes;
    if (_oBytes != 0) {
        uploadNetSpeed = [_stringWithbytes(oBytes - _oBytes) stringByAppendingString:@"/s"];
    }
    _oBytes = oBytes;
    static BOOL once = YES;
    if (YES == once) {
        
        once = NO;
        return _currentNetSpeed();
    }
    return @{
        @"upSpeed" : uploadNetSpeed,
        @"downSpeed" : downloadNetSpeed,
    };
}

// MARK: - 初始化结构体 -
struct LZDeviceUnit_type LZDeviceInfo = {
    
    .userInterfaceIdiom = _userInterfaceIdiom,
    .generation = _generation,
    .generation_desc = _generation_desc,
    .UUID = _DeviceUUID,
    .uuid_create = _uuid_create,
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
    .memoryTotalSpace = _memoryTotalSpace,
    .memoryTotalSpace_desc = _memoryTotalSpace_desc,
    .memoryAvaiableSpace = _memoryAvaiableSpace,
    .memoryAvaiableSpace_desc = _memoryAvaiableSpace_desc,
    .memoryUsedSpace = _memoryUsedSpace,
    .memoryUsedSpace_desc = _memoryUsedSpace_desc,
    .CPUCount = _CPUCount,
    .CPUUsageRate = _CPUUsageRate,
    .restartDate= _restartDate,
    .is_jailbreak = _is_jailbreak,
    .is_simulator = _is_simulator,
    .is_iPad = _is_iPad,
    .is_iPhone = _is_iPhone,
    .is_iTV = _is_iTV,
    .is_carPlay = _is_carPlay,
    .is_mac = _is_mac,
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
    .currentNetSpeed = _currentNetSpeed,
};
