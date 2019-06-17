//
//  LZAppUnit.h
//  Pods
//
//  Created by Dear.Q on 2017/11/14.
//
//

#ifndef LZAppUnit_h
#define LZAppUnit_h

#import <Foundation/Foundation.h>

struct LZAppUnit_type {
    
    /** 
     *  Forced Exit App
     */
    void (* exit)(void);
    
    /**
     *  App Bundle display name
     */
    NSString * (* name)(void);
    
    /**
     *  App Bundle Identifier
     */
    NSString * (* bundleID)(void);
    
    /**
     *  App Version
     */
    NSString * (* version)(void);
    
    /**
     *  App Build
     */
    NSString * (* build)(void);
    
    /**
     *  compare build with lastest build
     *
     *  @param lastestBuild 最新 build 号
     *  @return 指定版本是否是最新版本(YES : 是最新版本 ; NO : 不是最新版本)
     */
    BOOL (* compareBuild)(NSString *lastestBuild);
    
    /**
     *  compare version with lastest version
     *
     *  @param lastestVersion 最新 version
     *  @return 指定版本是否是最新版本(YES : 是最新版本 ; NO : 不是最新版本)
     */
    BOOL (* compareVersion)(NSString *lastestVersion);
    
};

FOUNDATION_EXTERN struct LZAppUnit_type LZAppInfo;

#endif /* LZAppUnit_h */
