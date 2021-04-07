//
//  LZStudent+LZTest.m
//  LZDependencyToolkit_Example
//
//  Created by Dear.Q on 2021/4/7.
//  Copyright © 2021 lilei_hapy@163.com. All rights reserved.
//

#import "LZStudent+LZTest.h"

@implementation LZStudent (LZTest)

+ (void)load {
    LZ_exchangeInstanceMethod(self, @selector(helloWrold), @selector(studentInstanceMethod));
}

- (void)studentInstanceMethod {
    LZLog(@"%s", __PRETTY_FUNCTION__);
    [self studentInstanceMethod];
}

@end
