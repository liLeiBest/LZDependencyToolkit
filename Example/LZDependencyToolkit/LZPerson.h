//
//  LZPerson.h
//  LZDependencyToolkit_Example
//
//  Created by Dear.Q on 2019/6/20.
//  Copyright © 2019 lilei_hapy@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZPerson : NSObject

/** name */
@property (copy, nonatomic) NSString *name;
/** age */
@property (copy, nonatomic) NSString *age;
/** sex */
@property (copy, nonatomic) NSString *sex;
@property (assign, nonatomic) BOOL good;

@end

NS_ASSUME_NONNULL_END
