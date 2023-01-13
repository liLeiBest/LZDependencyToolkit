//
//  LZStudent.h
//  LZDependencyToolkit_Example
//
//  Created by Dear.Q on 2019/11/21.
//  Copyright © 2019 lilei_hapy@163.com. All rights reserved.
//

#import "LZPerson.h"
#import "LZBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZStudent : LZPerson

/** 学校 */
@property (copy, nonatomic) NSString *school;
/** 年级 */
@property (copy, nonatomic) NSString *grade;
/** 是否毕业 */
@property (assign, nonatomic) BOOL graduation;
/** 毕业回调 */
@property (copy, nonatomic) void(^graduateCallback)(void);
/** 书 */
@property (strong, nonatomic) LZBook *book;

+ (void)helloWorld;
- (void)helloWorld;

@end

NS_ASSUME_NONNULL_END
