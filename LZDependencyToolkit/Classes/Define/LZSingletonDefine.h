//
//  LZSingletonDefine.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/16.
//

#ifndef LZSingletonDefine_h
#define LZSingletonDefine_h

/** .h文件 方法声明 */
#define LZSingletonInterface(className) + (instancetype)shared##className;

/** .m文件 方法实现*/
#if __has_feature(objc_arc)
#define LZSingletonImplementation(className) \
static className *_instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken;   \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return _instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}
#else
#define LZSingletonImplementation(className) \
static className *_instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken;   \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return _instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (id)retain { return _instance; }  \
- (oneway void)release { }  \
- (id)autorelease { return _instance; }  \
- (NSUInteger)retainCount { return UINT_MAX; }
#endif

#endif /* LZSingletonDefine_h */
