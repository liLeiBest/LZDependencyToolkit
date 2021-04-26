//
//  LZPermanentThread.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2021/4/25.
//

#import "LZPermanentThread.h"

@interface LZCustomThread : NSThread

@end
@implementation LZCustomThread

- (void)dealloc {
#if DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
}

@end

@interface LZPermanentThread()

@property (nonatomic, strong) LZCustomThread *thread;

@end
@implementation LZPermanentThread

// MARK: - Initialization
- (instancetype)init {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        if (@available(iOS 10.0, *)) {
            self.thread = [[LZCustomThread alloc] initWithBlock:^{
                
                CFRunLoopSourceContext context = {0}; // 必须初始化，否则可能会崩溃
                CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
                CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
                CFRelease(source);
                CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            }];
        } else {
            self.thread = [[LZCustomThread alloc] initWithTarget:weakSelf selector:@selector(__startRunLoop) object:nil];
        }
        [self.thread start];
    }
    return self;
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    [self stop];
}

// MARK: - Public
- (void)executeTask:(void (^)(void))task {
    if (nil == self.thread || nil == task) {
        return;
    }
    [self performSelector:@selector(__executeBlock:) onThread:self.thread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if (nil == self.thread) {
        return;
    }
    [self performSelector:@selector(__stopRunLoop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

// MARK: - Private
- (void)__startRunLoop {
    
    CFRunLoopSourceContext context = {0}; // 必须初始化，否则可能会崩溃
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
}

- (void)__stopRunLoop {
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)__executeBlock:(void (^)(void))block {
    block();
}

@end
