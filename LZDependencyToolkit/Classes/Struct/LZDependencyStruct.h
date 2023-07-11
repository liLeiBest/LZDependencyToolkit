//
//  LZDependencyStruct.h
//  Pods
//
//  Created by Dear.Q on 2017/11/10.
//
//

#ifndef LZDependencyStruct_h
#define LZDependencyStruct_h

#if __has_include(<LZDependencyToolkit/LZObject.h>)
#import <LZDependencyToolkit/LZAppUnit.h>
#import <LZDependencyToolkit/LZCryptoUnit.h>
#import <LZDependencyToolkit/LZDeviceUnit.h>
#import <LZDependencyToolkit/LZQuickUnit.h>
#else
#import "LZAppUnit.h"
#import "LZCryptoUnit.h"
#import "LZDeviceUnit.h"
#import "LZQuickUnit.h"
#endif

#endif /* LZDependencyStruct_h */
