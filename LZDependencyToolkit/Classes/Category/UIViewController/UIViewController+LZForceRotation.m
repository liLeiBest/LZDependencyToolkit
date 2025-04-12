//
//  UIViewController+LZForceRotation.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import "UIViewController+LZForceRotation.h"
#import "NSObject+LZRuntime.h"
#import <objc/runtime.h>

@interface LZForceRotationWeakContainer : NSObject

@property (nonatomic, readonly, assign) IMP weakObject;

/** 构造方法 */
- (instancetype)initWithWeakObject:(IMP)object;

@end

@implementation LZForceRotationWeakContainer

- (instancetype)initWithWeakObject:(IMP)object {
    if (self = [super init]) {
        _weakObject = object;
    }
    return self;
}

@end

@interface UIViewController (LZForceRotation)

@property (nonatomic, assign) IMP originalIMP;

@end
@implementation UIViewController (LZForceRotation)

- (BOOL)isPortraitOrientation {
    if (@available(iOS 13.0, *)) {
        NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
        if (array.count) {
            
            UIWindowScene *scene = (UIWindowScene *)array[0];
            UIInterfaceOrientation orientation = scene.interfaceOrientation;
            if (UIInterfaceOrientationPortrait == orientation) {
                return YES;
            }
        }
    } else {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (UIDeviceOrientationPortrait == orientation) {
            return YES;
        }
    }
    return NO;
}

- (void)setupNeedRotation:(BOOL)needRotation {
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    Class destClass = [appDelegate class];
    SEL originalSEL = @selector(application:supportedInterfaceOrientationsForWindow:);
    const char *originalMethodType = method_getTypeEncoding(class_getInstanceMethod(destClass, originalSEL));
    if (YES == needRotation && nil == self.originalIMP) {
        self.originalIMP = method_getImplementation(class_getInstanceMethod(destClass, originalSEL));
    }
    IMP newIMP = imp_implementationWithBlock(^(id obj, UIApplication *application, UIWindow *window) {
        return needRotation ? UIInterfaceOrientationMaskAll : UIInterfaceOrientationPortrait;
    });
    if (YES == needRotation) {
        class_replaceMethod(destClass, originalSEL, newIMP, originalMethodType);
    } else {
        class_replaceMethod(destClass, originalSEL, self.originalIMP, originalMethodType);
    }
}

- (void)forceChangeOrientation:(UIInterfaceOrientation)orientation {
    
    int val = (int)orientation;
    if (@available(iOS 16, *)) {
        
        NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
        if (array.count) {
            
            UIWindowScene *scene = (UIWindowScene *)array[0];
            if (nil == scene) {
                return;
            }
            [self setNeedsUpdateOfSupportedInterfaceOrientations];
            [self.navigationController setNeedsUpdateOfSupportedInterfaceOrientations];
            UIWindowSceneGeometryPreferencesIOS *geometryperences = [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:(1 << val)];
            [scene requestGeometryUpdateWithPreferences:geometryperences errorHandler:^(NSError * _Nonnull error) {
                NSLog(@"Orientation Error:%@", error);
                if ([error.domain isEqualToString:UISceneErrorDomain] &&
                    error.code == UISceneErrorCodeGeometryRequestDenied) {
                }
            }];
        }
    } else {
        @try {
            SEL selector = @selector(setOrientation:);
            if ([[UIDevice currentDevice] respondsToSelector:selector]) {
                
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                [invocation setSelector:selector];
                [invocation setTarget:[UIDevice currentDevice]];
                [invocation setArgument:&val atIndex:2];
                [invocation invoke];
            }
        } @catch (NSException *exception) {
            NSLog(@"Orientation Error:%@", exception);
        } @finally {
        }
    }
}

// MARK: - Private
- (IMP)originalIMP {
    
    LZForceRotationWeakContainer *container = LZ_getAssociatedObject(self, @selector(setOriginalIMP:));
    return container.weakObject;
}

- (void)setOriginalIMP:(IMP)originalIMP {
    LZ_setAssociatedObject(self, _cmd, [[LZForceRotationWeakContainer alloc] initWithWeakObject:originalIMP]);
}

@end
