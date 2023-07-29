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

/** Digital comparison */
NSComparisonResult _compareNumResult(NSString *num1, NSString *num2) {
    return [num1 compare:num2 options:NSNumericSearch];
}

/** compare build version */
BOOL _compareBuild(NSString *build) {
    if (_compareNumResult(_build(), build) == NSOrderedDescending) return NO;
    return YES;
}

/** compare build version */
BOOL _compareBuild_gt(NSString *build) {
    if (_compareNumResult(_build(), build) == NSOrderedAscending) return YES;
    return NO;
}


/** compare version */
BOOL _compareVersion(NSString *version) {
    if (_compareNumResult(_version(), version) == NSOrderedDescending) return NO;
    return YES;;
}

/** compare version */
BOOL _compareVersion_gt(NSString *version) {
    if (_compareNumResult(_version(), version) == NSOrderedAscending) return NO;
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
    if ([fileManager fileExistsAtPath:dirPath]) {
        return YES;
    }
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
UIWindow * _keyWindow(void) {
    if ([[[UIApplication sharedApplication] delegate] window]) {
        return [[[UIApplication sharedApplication] delegate] window];
    } else {
        if (@available(iOS 13.0, *)) {
            
            NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *windowScene = (UIWindowScene *)array[0];
            /**
             如果是普通App开发，可以使用
             SceneDelegate * delegate = (SceneDelegate *)windowScene.delegate;
             UIWindow * mainWindow = delegate.window;
             */
            // 由于在sdk开发中，引入不了SceneDelegate的头文件，所以需要用kvc获取宿主app的window.
            UIWindow* mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
            if (mainWindow) {
                return mainWindow;
            } else {
                if (@available(iOS 15.0, *)) {
                    mainWindow = windowScene.keyWindow;
                } else {
                    mainWindow = [windowScene.windows lastObject];
                }
                if (mainWindow) {
                    return mainWindow;
                } else {
                    return [UIApplication sharedApplication].windows.lastObject;
                }
            }
        } else {
            // Fallback on earlier versions
            return [UIApplication sharedApplication].keyWindow;
        }
    }
}

UIEdgeInsets _safeAreaInsets(void) {
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = _keyWindow().safeAreaInsets;
    }
    return insets;
}

/** 当前活动控制器 */
UIViewController * _activityViewController(void) {
    
    UIViewController *activityViewController = nil;
    // 获取当前主窗口
    UIWindow *currentWindow = _keyWindow();
//    if (currentWindow.windowLevel != UIWindowLevelNormal) {
//
//        NSArray *allWindows = [UIApplication sharedApplication].windows;
//        for (UIWindow *tempWindow in allWindows) {
//            if (tempWindow.windowLevel == UIWindowLevelNormal) {
//                currentWindow = tempWindow;
//                break;
//            }
//        }
//    }
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

/** 打开URL */
BOOL _openURL(NSURL *URL) {
    if (nil == URL || NO == [URL isKindOfClass:[NSURL class]]) {
        return NO;
    }
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        if (@available(iOS 10, *)) {
            [[UIApplication sharedApplication] openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @(NO)} completionHandler:^(BOOL success) {
            }];
        } else {
            [[UIApplication sharedApplication] openURL:URL];
        }
        return YES;
    }
    return NO;
}

/** Forced Exit App */
void _exitApp(void) {
    
    UIWindow *window = _keyWindow();
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
    .compareBuild_gt = _compareBuild_gt,
    .compareVersion = _compareVersion,
    .compareVersion_gt = _compareVersion_gt,
    
    .cacheDir = _cacheDir,
    .documentDir = _documentDir,
    .searchDir = _searchDir,
    .cacheSubDir = _cacheSubDir,
    .documentSubDir = _documentSubDir,
    .searchSubDir = _searchSubDir,
    .createDir = _createDir,
    .createCacheSubDir = _createCacheSubDir,
    .createDocumentSubDir = _createDocumentSubDir,
    
    .keyWindow = _keyWindow,
    .safeAreaInsets = _safeAreaInsets,
    .activityViewController = _activityViewController,
    .openURL = _openURL,
    .exit = _exitApp,
};
