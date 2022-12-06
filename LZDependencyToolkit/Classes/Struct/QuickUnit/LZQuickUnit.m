//
//  LZQuickUnit.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/16.
//

#import "LZQuickUnit.h"
#import "LZAppUnit.h"

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

BOOL isLocationOutOfChina(double latitude, double longitude) {
    if (longitude < 72.004 || longitude > 137.8347 || latitude < 0.8293 || latitude > 55.8271)
        return YES;
    return NO;
}

double transformLatitude(double x, double y) {
    
    double latitude = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    latitude += (20.0 * sin(6.0 * x * M_PI) + 20.0 *sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    latitude += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    latitude += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return latitude;
}
  
double transformLongitude(double x, double y) {
    
    double longitude = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    longitude += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    longitude += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    longitude += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return longitude;
}

// a = 6378245.0, 1/f = 298.3
// b = a * (1 - f)
// ee = (a^2 - b^2) / a^2;
const double LZa = 6378245.0;
const double LZee = 0.00669342162296594323;
CLLocationCoordinate2D gcj02Encrypt(double latitude, double longitude) {
    if (NO == isLocationOutOfChina(latitude, longitude)) {
        
        double dLat = transformLatitude(longitude - 105.0, latitude - 35.0);
        double dLon = transformLongitude(longitude - 105.0, latitude - 35.0);
        double radLat = latitude / 180.0 * M_PI;
        double magic = sin(radLat);
        magic = 1 - LZee * magic * magic;
        double sqrtMagic = sqrt(magic);
        dLat = (dLat * 180.0) / ((LZa * (1 - LZee)) / (magic * sqrtMagic) * M_PI);
        dLon = (dLon * 180.0) / (LZa / sqrtMagic * cos(radLat) * M_PI);
        latitude = latitude + dLat;
        longitude = longitude + dLon;
    }
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return coordinate;
}

CLLocationCoordinate2D gcj02Decrypt(double latitude, double longitude) {
    if (NO == isLocationOutOfChina(latitude, longitude)) {
        
        CLLocationCoordinate2D coordinate2D = gcj02Encrypt(latitude, longitude);
        double dLon = coordinate2D.longitude - longitude;
        double dLat = coordinate2D.latitude - latitude;
        latitude = latitude - dLat;
        longitude = longitude - dLon;
    }
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return coordinate;
}

CLLocationCoordinate2D bd09Encrypt(double latitude, double longitude) {

    double x = longitude, y = latitude;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * M_PI);
    double theta = atan2(y, x) + 0.000003 * cos(x * M_PI);
    double bd_lon = z * cos(theta) + 0.0065;
    double bd_lat = z * sin(theta) + 0.006;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(bd_lat, bd_lon);
    return coordinate;
}

CLLocationCoordinate2D bd09Decrypt(double latitude, double longitude) {
    
    double x = longitude - 0.0065, y = latitude - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * M_PI);
    double theta = atan2(y, x) - 0.000003 * cos(x * M_PI);
    double gg_lon = z * cos(theta);
    double gg_lat = z * sin(theta);
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(gg_lat, gg_lon);
    return coordinate;
}

CLLocationCoordinate2D wgs84_to_gcj02(double latitude, double longitude) {
    return gcj02Encrypt(latitude, longitude);
}

CLLocationCoordinate2D gcj02_to_wgs84(double latitude, double longitude) {
    return gcj02Decrypt(latitude, longitude);
}

CLLocationCoordinate2D wgs84_to_bd09(double latitude, double longitude) {

    CLLocationCoordinate2D gcj02 = gcj02Encrypt(latitude, longitude);
    CLLocationCoordinate2D bd09 = bd09Encrypt(gcj02.latitude, gcj02.longitude);
    return bd09;
}

CLLocationCoordinate2D bd09_to_wgs84(double latitude, double longitude) {

    CLLocationCoordinate2D gcj02 = bd09Decrypt(latitude, longitude);
    CLLocationCoordinate2D wgs84 = gcj02Decrypt(gcj02.latitude, gcj02.longitude);
    return wgs84;
}

CLLocationCoordinate2D gcj02_to_bd09(double latitude, double longitude) {
    return bd09Encrypt(latitude, longitude);
}

CLLocationCoordinate2D bd09_to_gcj02(double latitude, double longitude) {
    return bd09Decrypt(latitude, longitude);
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
UIAlertController * alert(UIViewController *target, NSString *title, NSString *message, NSArray<UIAlertAction *> *actions) {
	
	UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	for (UIAlertAction *action in actions) {
		[alertCtr addAction:action];
	}
    if (nil == target) {
        target = LZAppUnit.activityViewController();
    }
    if (nil != target.presentedViewController) {
        [target.presentedViewController presentViewController:alertCtr animated:YES completion:nil];
    } else {
        [target presentViewController:alertCtr animated:YES completion:nil];
    }
    return alertCtr;
}

UIAlertController * alertInput(UIViewController *target, NSString *title, NSString *message, NSArray<UIAlertAction *> *actions, void (^_Nonnull inputHandler)(UITextField *textField)) {
    
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (UIAlertAction *action in actions) {
        [alertCtr addAction:action];
    }
    [alertCtr addTextFieldWithConfigurationHandler:inputHandler];
    if (nil == target) {
        target = LZAppUnit.activityViewController();
    }
    if (nil != target.presentedViewController) {
        [target.presentedViewController presentViewController:alertCtr animated:YES completion:nil];
    } else {
        [target presentViewController:alertCtr animated:YES completion:nil];
    }
    return alertCtr;
}

UIAlertController * sheet(UIViewController *target, NSString *title, NSString *message, NSArray<UIAlertAction *> *actions) {
    
    UIAlertController *sheetCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (UIAlertAction *action in actions) {
        [sheetCtr addAction:action];
    }
    if (nil == target) {
        target = LZAppUnit.activityViewController();
    }
    if (nil != target.presentedViewController) {
        [target.presentedViewController presentViewController:sheetCtr animated:YES completion:nil];
    } else {
        [target presentViewController:sheetCtr animated:YES completion:nil];
    }
    return sheetCtr;
}

// MARK: Notification
NSNotificationCenter * notificationCenter(void) {
	return [NSNotificationCenter defaultCenter];
}
											  
id <NSObject> notificationObserver(NSNotificationName name, void (^callBackHandler)(NSNotification *note)) {
	return [notificationCenter() addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:callBackHandler];
}

void notificationAdd(id observer, SEL selector, NSNotificationName name) {
    @try {
        [notificationCenter() addObserver:observer selector:selector name:name object:nil];
    } @catch (NSException *exception) {
    } @finally {
    }
}

void notificationPost(NSNotificationName name, id anyObject, NSDictionary *userInfo) {
	[notificationCenter() postNotificationName:name object:anyObject userInfo:userInfo];
}

void notificationRemove(id observer, NSNotificationName name) {
    @try {
        [notificationCenter() removeObserver:observer name:name object:nil];
    } @catch (NSException *exception) {
    } @finally {
    }
}

/** 初始化结构体 */
struct LZQuickUnit_type LZQuickUnit = {
	
	.toRadian = toRadian,
	.toDegree = toDegree,
	.toString = toString,
    .wgs84_to_gcj02 = wgs84_to_gcj02,
    .gcj02_to_wgs84 = gcj02_to_wgs84,
    .wgs84_to_bd09 = wgs84_to_bd09,
    .bd09_to_wgs84 = bd09_to_wgs84,
    .gcj02_to_bd09 = gcj02_to_bd09,
    .bd09_to_gcj02 = bd09_to_gcj02,
	
	.installedFontNames = installedFontNames,
	.font = font,
	.boldFont = boldFont,
	.italicFont = italicFont,
	.fontWeight = fontWeight,
	.fontName = fontName,
	
	.alert = alert,
    .alertInput = alertInput,
    .sheet = sheet,
	
	.notificationCenter = notificationCenter,
	.notificationObserver = notificationObserver,
	.notificationAdd = notificationAdd,
	.notificationPost = notificationPost,
	.notificationRemove = notificationRemove,
};
