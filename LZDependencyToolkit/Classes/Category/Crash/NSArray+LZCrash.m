//
//  NSArray+LZCrash.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2023/6/15.
//

#import "NSArray+LZCrash.h"
#import "NSObject+LZRuntime.h"

// MARK: - Array
@implementation NSArray (LZCrash)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector1 = @selector(objectAtIndex:);
        SEL swizzleSelector1 = @selector(lz_objectAtIndex1:);
        LZ_exchangeInstanceMethod(NSClassFromString(@"__NSArray0"), originSelector1, swizzleSelector1);
        
        SEL originSelector2 = @selector(objectAtIndex:);
        SEL swizzleSelector2 = @selector(lz_objectAtIndex2:);
        LZ_exchangeInstanceMethod(NSClassFromString(@"__NSArrayI"), originSelector2, swizzleSelector2);
        
        SEL originSelector3 = @selector(objectAtIndex:);
        SEL swizzleSelector3 = @selector(lz_objectAtIndex3:);
        LZ_exchangeInstanceMethod(NSClassFromString(@"__NSSingleObjectArrayI"), originSelector3, swizzleSelector3);
    });
}

- (id)lz_objectAtIndex1:(NSUInteger)index {
    if (0 > index) {
        return nil;
    } else if (index >= self.count) {
        return nil;
    }
    return [self lz_objectAtIndex1:index];
}

- (id)lz_objectAtIndex2:(NSUInteger)index {
    if (0 > index) {
        return nil;
    } else if (index >= self.count) {
        return nil;
    }
    return [self lz_objectAtIndex2:index];
}

- (id)lz_objectAtIndex3:(NSUInteger)index {
    if (0 > index) {
        return nil;
    } else if (index >= self.count) {
        return nil;
    }
    return [self lz_objectAtIndex3:index];
}

@end

@implementation NSMutableArray (LZCrash)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector0 = @selector(objectAtIndex:);
        SEL swizzleSelector0 = @selector(lz_objectAtIndex:);
        LZ_exchangeInstanceMethod(NSClassFromString(@"__NSArrayM"), originSelector0, swizzleSelector0);
        
        SEL originSelector1 = @selector(addObject:);
        SEL swizzleSelector1 = @selector(lz_addObject:);
        LZ_exchangeInstanceMethod(NSClassFromString(@"__NSArrayM"), originSelector1, swizzleSelector1);
        
        SEL originSelector2 = @selector(addObjectsFromArray:);
        SEL swizzleSelector2 = @selector(lz_addObjectsFromArray:);
        LZ_exchangeInstanceMethod(NSClassFromString(@"__NSArrayM"), originSelector2, swizzleSelector2);
        
        SEL originSelector3 = @selector(arrayByAddingObject:);
        SEL swizzleSelector3 = @selector(lz_arrayByAddingObject:);
        LZ_exchangeInstanceMethod(NSClassFromString(@"__NSArrayM"), originSelector3, swizzleSelector3);
        
        SEL originSelector4 = @selector(arrayByAddingObjectsFromArray:);
        SEL swizzleSelector4 = @selector(lz_arrayByAddingObjectsFromArray:);
        LZ_exchangeInstanceMethod(NSClassFromString(@"__NSArrayM"), originSelector4, swizzleSelector4);
    });
}

- (id)lz_objectAtIndex:(NSUInteger)index {
    if (0 > index) {
        return nil;
    } else if (index >= self.count) {
        return nil;
    }
    return [self lz_objectAtIndex:index];
}

- (void)lz_addObject:(id)anObject {
    if (nil == anObject) {
        return;
    }
    [self lz_addObject:anObject];
}

- (void)lz_addObjectsFromArray:(NSArray *)otherArray {
    if (nil == otherArray) {
        return;
    }
    [self lz_addObjectsFromArray:otherArray];
}

- (NSArray *)lz_arrayByAddingObject:(id)anObject {
    if (nil == anObject) {
        return [self copy];
    }
    return [self lz_arrayByAddingObject:anObject];
}

- (NSArray *)lz_arrayByAddingObjectsFromArray:(NSArray *)otherArray {
    if (nil == otherArray) {
        return [self copy];
    }
    return [self lz_arrayByAddingObjectsFromArray:otherArray];
}

@end
