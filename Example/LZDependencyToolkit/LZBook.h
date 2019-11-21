//
//  LZBook.h
//  LZDependencyToolkit_Example
//
//  Created by Dear.Q on 2019/11/21.
//  Copyright © 2019 lilei_hapy@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBook : NSObject

/** 书名 */
@property (copy, nonatomic) NSString *name;
/** 作者 */
@property (copy, nonatomic) NSString *author;
/** 价格 */
@property (assign, nonatomic) CGFloat price;

@end

NS_ASSUME_NONNULL_END
