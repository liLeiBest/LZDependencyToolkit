//
//  NSObject+LZUnrecognizedSelector.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2023/1/13.
//

#import "NSObject+LZUnrecognizedSelector.h"
#import "NSObject+LZRuntime.h"
#import <objc/runtime.h>

@interface LZUnrecognizedSelectorSolveObject : NSObject

@property (nonatomic, assign) BOOL toInstance;
@property (nonatomic, weak) id objc;

@end
@implementation LZUnrecognizedSelectorSolveObject

// MARK: - Override
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    // 如果没有动态添加方法的话，还会调用forwardingTargetForSelector:方法，从而造成死循环
    class_addMethod([self class], sel, (IMP)addMethod, "v@:@");
    return YES;
}

// MARK: - Private
id addMethod(LZUnrecognizedSelectorSolveObject *self, SEL _cmd) {
    NSString *string = [NSString stringWithFormat:@"LZCrashProtector_UnrecognizedSelector: <%@> unrecognized selector: [%@] to %@", NSStringFromClass([self.objc class]), NSStringFromSelector(_cmd), (YES == self.toInstance ? @"Instace" : @"Class")];
#if DEBUG
    NSLog(@"%@", string);
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertCtr addAction:ok];
    UIViewController *target = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    [target presentViewController:alertCtr animated:YES completion:nil];
#else
    NSLog(@"%@", string);
#endif
    return 0;
}

@end

@implementation NSObject (LZUnrecognizedSelector)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = @selector(forwardingTargetForSelector:);
        SEL instanceSwizzleSelector = @selector(lz_instanceForwardingTargetForSelector:);
        LZ_exchangeInstanceMethod(self, originSelector, instanceSwizzleSelector);
        SEL classSwizzleSelector = @selector(lz_classForwardingTargetForSelector:);
        LZ_exchangeClassMethod(self, originSelector, classSwizzleSelector);
    });
}

// MARK: - Private
id lz_forwardingTargetForSelector(Class _Nullable cls, id target, bool toInstance) {
    if (class_respondsToSelector(cls, @selector(forwardInvocation:))) {
        
        IMP impOfNSObject = class_getMethodImplementation([NSObject class], @selector(forwardInvocation:));
        IMP imp = class_getMethodImplementation(cls, @selector(forwardInvocation:));
        if (imp != impOfNSObject) {
            return nil;
        }
    }
    // 消息转发
    LZUnrecognizedSelectorSolveObject *solveObject = [LZUnrecognizedSelectorSolveObject new];
    solveObject.toInstance = toInstance;
    solveObject.objc = target;
    return solveObject;
}

+ (id)lz_classForwardingTargetForSelector:(SEL)aSelector {
    return lz_forwardingTargetForSelector([self class], self, NO);
}

- (id)lz_instanceForwardingTargetForSelector:(SEL)aSelector {
    return lz_forwardingTargetForSelector([self class], self, YES);
}

@end
