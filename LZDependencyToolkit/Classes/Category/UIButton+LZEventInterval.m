//
//  UIButton+LZEventInterval.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2020/2/26.
//

#import "UIButton+LZEventInterval.h"
#import "NSObject+LZRuntime.h"


// 默认的按钮点击间隔时间
static const NSTimeInterval defaultInterval = 0.25f;
// 记录是否忽略按钮点击事件，默认第一次执行事件
static BOOL _isIgnoreEvent = NO;
// 设置执行按钮事件状态
static void resetState() {
    _isIgnoreEvent = NO;
}


@implementation UIControl (LZEventInterval)

// MARK: - Initialization
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = @selector(sendAction:to:forEvent:);
        SEL swizzleSelector = @selector(lz_sendAction:to:forEvent:);
        LZ_exchangeInstanceMethod(self, originSelector, swizzleSelector);
    });
}

// MARK: - Public
- (void)setEventInterval:(NSTimeInterval)eventInterval {
    LZ_setAssociatedObject(self, _cmd, @(eventInterval));
}

- (NSTimeInterval)eventInterval {
    return  [LZ_getAssociatedObject(self, @selector(setEventInterval:)) doubleValue];
}

// MARK: - Private
- (void)lz_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event {
    
    if ([self isKindOfClass:[UIButton class]]) {
        
        self.eventInterval = 0.0f == self.eventInterval  ? defaultInterval : self.eventInterval;
        if (_isIgnoreEvent) {
            return;
        } else if (self.eventInterval > 0) {
            
            _isIgnoreEvent = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.eventInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                resetState();
            });
            [self lz_sendAction:action to:target forEvent:event];
        }
    } else {
        [self lz_sendAction:action to:target forEvent:event];
    }
}

@end
