//
//  LZAppUnit.m
//  Pods
//
//  Created by Dear.Q on 2017/11/14.
//
//

#import "LZAppUnit.h"
#import <UIKit/UIKit.h>

// MARK: - Private
/** info.plist */
NSDictionary * _infoDict(void) {
    
    static NSDictionary *infoDict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        infoDict = [NSBundle mainBundle].infoDictionary;
    });
    return infoDict;
}

// MARK: Info
/** App Bundle display name */
NSString * _displayName(void){

    NSString *displayNameKey = @"CFBundleDisplayName";
    NSString *displayName = [_infoDict() objectForKey:displayNameKey];
    if (nil == displayName || 0 == displayName.length) {
        displayNameKey = @"CFBundleName";
        displayName = [_infoDict() objectForKey:displayNameKey];
    }
    return displayName;
}

/** App Bundle Identifier */
NSString * _bundleID(void) {

    NSString *bundleIDKey = (__bridge NSString *)kCFBundleIdentifierKey;
    NSString *bundleIdentifier = [_infoDict() objectForKey:bundleIDKey];
    return bundleIdentifier;
}

/** App Version */
NSString * _version(void) {

    NSString *versionKey = @"CFBundleShortVersionString";
    NSString *version = [_infoDict() objectForKey:versionKey];
    return version;
}

/** App Bundle */
NSString * _build(void) {

    NSString *buildKey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *build = [_infoDict() objectForKey:buildKey];
    return build;
}

/** compare build version */
BOOL _compareBuild(NSString *lastestBuild) {

    NSComparisonResult comparisonResult = [_build() compare:lastestBuild options:NSNumericSearch];
    if (comparisonResult == NSOrderedDescending) return NO;
    return YES;
}

/** compare version */
BOOL _compareVersion(NSString *lastestVersion) {

    NSComparisonResult comparisonResult = [_version() compare:lastestVersion options:NSNumericSearch];
    if (comparisonResult == NSOrderedDescending) return NO;
    return YES;;
}

// MARK: Path
NSString * _cacheDir(void) {
    
    static NSString *cachePath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
                     lastObject];
    });
    return cachePath;
}

NSString * _documentDir(void) {
    
    static NSString *documentPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                        lastObject];
    });
    return documentPath;
}

NSString * _searchDir(NSSearchPathDirectory searchPathDir) {
    
    static NSMutableDictionary *tmpDictM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tmpDictM = [NSMutableDictionary dictionary];
    });
    
    NSNumber *key = @(searchPathDir);
    NSString *destPath = [tmpDictM objectForKey:key];
    if (nil == destPath) {
        
        destPath = [NSSearchPathForDirectoriesInDomains(searchPathDir, NSUserDomainMask, YES)
                    lastObject];
        if (nil != destPath) {        
            [tmpDictM setObject:destPath forKey:key];
        }
    }
    return destPath;
}

NSString * _cacheSubDir(NSString *subPath) {
 
    NSString *cachePath = _cacheDir();
    NSString *destPath = [cachePath stringByAppendingPathComponent:subPath];
    return destPath;
}

NSString * _documentSubDir(NSString *subPath) {
 
    NSString *documentPath = _documentDir();
    NSString *destPath = [documentPath stringByAppendingPathComponent:subPath];
    return destPath;
}

NSString * _searchSubDir(NSSearchPathDirectory searchPathDir, NSString *subPath) {
    
    NSString *searchPath = _searchDir(searchPathDir);
    NSString *destPath = [searchPath stringByAppendingPathComponent:subPath];
    return destPath;
}

BOOL _createDir(NSString *dirPath) {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL successful = [fileManager createDirectoryAtPath:dirPath
                             withIntermediateDirectories:YES
                                              attributes:nil
                                                   error:&error];
    if (!successful) {
        NSLog(@"Failed to create folder:%@", error.localizedDescription);
    }
    return successful;
}

BOOL _createCacheSubDir(NSString *subPath, NSString **fullPath) {
    
    NSString *destPath = _cacheSubDir(subPath);
    if (fullPath) {
        *fullPath = destPath;
    }
    return _createDir(destPath);
}

BOOL _createDocumentSubDir(NSString *subPath, NSString **fullPath) {
    
    NSString *destPath = _documentSubDir(subPath);
    if (fullPath) {
        *fullPath = destPath;
    }
    return _createDir(destPath);
}

// MARK: Other
UIEdgeInsets _safeAreaInsets(void) {
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (nil == mainWindow) {
            mainWindow = [UIApplication sharedApplication].keyWindow;
        }
        insets = mainWindow.safeAreaInsets;
    }
    return insets;
}

/** 当前活动控制器 */
UIViewController * _activityViewController(void) {
    
    UIViewController *activityViewController = nil;
    // 获取当前主窗口
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    if (currentWindow.windowLevel != UIWindowLevelNormal) {
        
        NSArray *allWindows = [UIApplication sharedApplication].windows;
        for (UIWindow *tempWindow in allWindows) {
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                currentWindow = tempWindow;
                break;
            }
        }
    }
    // 获取活动的视图控制器
    NSArray *currentWinViews = [currentWindow subviews];
    if (currentWinViews.count > 0) {
        
        UIView *frontView = [currentWinViews objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        } else {
            activityViewController = currentWindow.rootViewController;
        }
        if ([activityViewController isKindOfClass:[UINavigationController class]]) {
            UIViewController *visibleViewController = [(UINavigationController *)activityViewController visibleViewController];
            if (nil != visibleViewController) {
                activityViewController = visibleViewController;
            } else {
                activityViewController = [(UINavigationController *)activityViewController topViewController];
            }
        }
    }
    return activityViewController;
}

/** Forced Exit App */
void _exitApp(void) {
    
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = app.keyWindow;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(window.bounds.size.width * 0.5, window.bounds.size.height * 0.5, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

// MARK: - Initilization
struct LZAppUnit_type LZAppUnit = {

    .name = _displayName,
    .bundleID = _bundleID,
    .version = _version,
    .build = _build,
    
    .compareBuild = _compareBuild,
    .compareVersion = _compareVersion,
    
    .cacheDir = _cacheDir,
    .documentDir = _documentDir,
    .searchDir = _searchDir,
    .cacheSubDir = _cacheSubDir,
    .documentSubDir = _documentSubDir,
    .searchSubDir = _searchSubDir,
    .createDir = _createDir,
    .createCacheSubDir = _createCacheSubDir,
    .createDocumentSubDir = _createDocumentSubDir,
    
    .safeAreaInsets = _safeAreaInsets,
    .activityViewController = _activityViewController,
    .exit = _exitApp,
};
