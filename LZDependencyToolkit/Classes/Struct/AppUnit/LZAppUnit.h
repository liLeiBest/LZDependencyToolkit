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
    
    // MARK: - Info
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
    
    // MARK: - Path
    /**
     缓存目录
     */
    NSString * (* cacheDir)(void);
    
    /**
     文档目录
     */
    NSString * (* documentDir)(void);
    
    /**
     特定目录
     */
    NSString * (* searchDir)(NSSearchPathDirectory searchPathDir);
    
    /**
     缓存子目录
     */
    NSString * (* cacheSubDir)(NSString *subPath);
    
    /**
     文档子目录
     */
    NSString * (* documentSubDir)(NSString *subPath);
    
    /**
     特定子目录
     */
    NSString * (* searchSubDir)(NSSearchPathDirectory searchPathDir, NSString *subPath);
    
    /**
     创建目录
     */
    BOOL (* createDir)(NSString *dirPath);
    
    /**
     创建缓存子目录
     */
    BOOL (* createCacheSubDir)(NSString *subPath, NSString **fullPath);
    
    /**
     创建文档子目录
     */
    BOOL (* createDocumentSubDir)(NSString *subPath, NSString **fullPath);
    
    // MARK: - Other
    /**
     *  Forced Exit App
     */
    void (* exit)(void);
};

FOUNDATION_EXTERN struct LZAppUnit_type LZAppUnit;

#endif /* LZAppUnit_h */
