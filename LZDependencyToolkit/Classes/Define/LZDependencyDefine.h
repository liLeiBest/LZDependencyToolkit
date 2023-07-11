//
//  LZDependencyDefine.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/16.
//

#ifndef LZDependencyDefine_h
#define LZDependencyDefine_h

#if __has_include(<LZDependencyToolkit/LZDependencyDefine.h>)
#import <LZDependencyToolkit/LZLogDefine.h>
#import <LZDependencyToolkit/LZSingletonDefine.h>
#import <LZDependencyToolkit/LZWeakDefine.h>
#else
#import "LZLogDefine.h"
#import "LZSingletonDefine.h"
#import "LZWeakDefine.h"
#endif

#endif /* LZDependencyDefine_h */
