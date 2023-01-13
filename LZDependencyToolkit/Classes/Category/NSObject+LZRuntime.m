//
//  NSObject+LZRuntime.m
//  Pods
//
//  Created by Dear.Q on 2017/12/9.
//
//

#import "NSObject+LZRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (LZRuntime)

//MARK: - Public
/** 类方法交换 */
void LZ_exchangeClassMethod(Class class, SEL originSelector, SEL swizzleSelector) {
    LZ_exchangeMethod(YES, class, originSelector, swizzleSelector);
}

/** 对象方法交换 */
void LZ_exchangeInstanceMethod(Class class, SEL originSelector, SEL swizzleSelector) {
    LZ_exchangeMethod(NO, class, originSelector, swizzleSelector);
}

/** 添加属性 */
void LZ_setAssociatedObject(id object, const void *key, id value) {
    objc_setAssociatedObject(object, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/** 添加属性 copy */
void LZ_setAssociatedCopyObject(id object, const void *key, NSString *value) {
    objc_setAssociatedObject(object, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/** 获取属性 */
id LZ_getAssociatedObject(id object, const void *key) {
    return objc_getAssociatedObject(object, key);
}

/** 获取对象属性列表 */
- (NSArray *)properties {
	
	unsigned int count = 0;
	NSMutableArray *propertyArrM = [NSMutableArray arrayWithCapacity:count];
	objc_property_t *properties = class_copyPropertyList([self class], &count);
	for (NSUInteger i = 0; i < count; i++) {
		
		objc_property_t property = properties[i];
		const char *propertyChar = property_getName(property);
		NSString *propertyString = [NSString stringWithUTF8String:propertyChar];
		[propertyArrM addObject:propertyString];
	}
	return [propertyArrM copy];
}

//MARK: - Private
/** 方法交换 */
void LZ_exchangeMethod(BOOL classMethod, Class destClass, SEL originSelector, SEL swizzleSelector) {
    if (nil == originSelector || nil == swizzleSelector) {
        return;
    }
    destClass = YES == classMethod ? object_getClass([destClass class]) : [destClass class];
    Method originMethod = YES == classMethod ? class_getClassMethod(destClass, originSelector) : class_getInstanceMethod(destClass, originSelector);
    IMP originIMP = method_getImplementation(originMethod);
    const char *originType = method_getTypeEncoding(originMethod);
    
	Method swizzleMethod = YES == classMethod ? class_getClassMethod(destClass, swizzleSelector) : class_getInstanceMethod(destClass, swizzleSelector);
	IMP swizzleIMP = method_getImplementation(swizzleMethod);
	const char *swizzleType = method_getTypeEncoding(swizzleMethod);
    if (nil == originMethod) {

        class_addMethod(destClass, originSelector, swizzleIMP, swizzleType);
        method_setImplementation(swizzleMethod, imp_implementationWithBlock(^(id self, SEL _cmd) {}));
    }
	BOOL didAddMethod = class_addMethod(destClass, originSelector, swizzleIMP, swizzleType);
	if (YES == didAddMethod) {
        class_replaceMethod(destClass, swizzleSelector, originIMP, originType);
	} else {
		method_exchangeImplementations(originMethod, swizzleMethod);
	}
}

@end
