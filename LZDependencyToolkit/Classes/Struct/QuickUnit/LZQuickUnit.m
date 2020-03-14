//
//  LZQuickUnit.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/16.
//

#import "LZQuickUnit.h"

// MARK: Format
CGFloat toRadian(CGFloat degree) {
	return (M_PI * (degree) / 180.0);
}

CGFloat toDegree(CGFloat radian) {
	return (radian * 180.0) / (M_PI);
}

NSString * toString(id object) {
	
	if ([object isKindOfClass:[NSDictionary class]]) {
		
		NSDictionary *dict = object;
		NSError *error;
		NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
		NSString *jsonString = nil;
		if (nil == jsonData) {
			NSLog(@"Fail to json serialization:%@",error);
		} else {
			jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
		}
		NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
		NSRange range = {0, jsonString.length};
		[mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
		NSRange range2 = {0, mutStr.length};
		[mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
		return [mutStr copy];
	} else if ([object isKindOfClass:[NSArray class]]) {
		
		NSArray *array = object;
        NSString *string = [array componentsJoinedByString:@","];
        NSMutableString *stringM = [NSMutableString stringWithString:string];
        [stringM insertString:@"[" atIndex:0];
        [stringM appendFormat:@"]"];
		return [stringM copy];
	}
	if ([object isKindOfClass:[NSNumber class]]) {
		
		NSNumber *nummber = object;
		return [NSString stringWithFormat:@"%ld", nummber.longValue];
	} else {
		
		NSObject *obj = object;
		return obj.description;
	}
}

// MARK: Font
NSArray * installedFontNames(void) {
	
	NSMutableArray *destArrayM = [NSMutableArray array];
	NSArray *familiyNames = [UIFont familyNames];
	for (NSString *familyName in familiyNames) {
		
		NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
		[destArrayM addObjectsFromArray:fontNames];
	}
	return [destArrayM copy];
}

UIFont * font(CGFloat fontSize) {
	return [UIFont systemFontOfSize:fontSize];
}

UIFont * boldFont(CGFloat fontSize) {
	return [UIFont boldSystemFontOfSize:fontSize];
}

UIFont * italicFont(CGFloat fontSize) {
	return [UIFont italicSystemFontOfSize:fontSize];
}

UIFont * fontWeight(CGFloat fontSize, UIFontWeight weight) {
	if (@available(iOS 8.2, *)) {
		return [UIFont systemFontOfSize:fontSize weight:weight];
	} else {
		return boldFont(fontSize);
	}
}

UIFont * fontName(NSString *fontName, CGFloat fontSize) {
	return [UIFont fontWithName:fontName size:fontSize];
}

// MARK: Alert
/** 当前活动控制器 */
UIViewController * _currentActivityViewController(void) {
    
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
    }
    return activityViewController;
}

void alert(NSString *title, NSString *message, NSArray<UIAlertAction *> *actions) {
	
	UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	for (UIAlertAction *action in actions) {
		[alertCtr addAction:action];
	}
	[_currentActivityViewController() presentViewController:alertCtr animated:YES completion:nil];
}

void sheet(NSString *title, NSString *message, NSArray<UIAlertAction *> *actions) {
    
    UIAlertController *sheetCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (UIAlertAction *action in actions) {
        [sheetCtr addAction:action];
    }
    [_currentActivityViewController() presentViewController:sheetCtr animated:YES completion:nil];
}

NSNotificationCenter * notificationCenter(void) {
	return [NSNotificationCenter defaultCenter];
}
											  
id <NSObject> notificationObserver(NSNotificationName name, void (^callBackHandler)(NSNotification *note)) {
	return [notificationCenter() addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:callBackHandler];
}

void notificationAdd(id observer, SEL selector, NSNotificationName name) {
	[notificationCenter() addObserver:observer selector:selector name:name object:nil];
}

void notificationPost(NSNotificationName name, id anyObject, NSDictionary *userInfo) {
	[notificationCenter() postNotificationName:name object:anyObject userInfo:userInfo];
}

void notificationRemove(id observer, NSNotificationName name) {
	[notificationCenter() removeObserver:observer name:name object:nil];
}

/** 初始化结构体 */
struct LZQuickUnit_type LZQuickUnit = {
	
	.toRadian = toRadian,
	.toDegree = toDegree,
	.toString = toString,
	
	.installedFontNames = installedFontNames,
	.font = font,
	.boldFont = boldFont,
	.italicFont = italicFont,
	.fontWeight = fontWeight,
	.fontName = fontName,
	
	.alert = alert,
	
	.notificationCenter = notificationCenter,
	.notificationObserver = notificationObserver,
	.notificationAdd = notificationAdd,
	.notificationPost = notificationPost,
	.notificationRemove = notificationRemove,
};
