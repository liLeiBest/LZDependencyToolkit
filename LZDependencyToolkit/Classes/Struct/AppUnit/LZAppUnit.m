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

// MARK: - Public
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

    NSComparisonResult comparisonResult = [_build() compare:lastestBuild
                                                    options:NSNumericSearch];
    if (comparisonResult == NSOrderedAscending) return YES;
    
    return NO;
}

/** compare version */
BOOL _compareVersion(NSString *lastestVersion) {

    NSComparisonResult comparisonResult = [_version() compare:lastestVersion
                                                    options:NSNumericSearch];
    if (comparisonResult == NSOrderedAscending) return YES;
    
    return NO;;
}

struct LZAppUnit_type LZAppInfo = {

    .exit = _exitApp,
    .name = _displayName,
    .bundleID = _bundleID,
    .version = _version,
    .build = _build,
    
    .compareBuild = _compareBuild,
    .compareVersion = _compareVersion,
};
