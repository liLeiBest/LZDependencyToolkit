//
//  LZLogDefine.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/16.
//

#ifndef LZLogDefine_h
#define LZLogDefine_h

/** 替换 NSLog 来使用，debug 模式下可以打印很多信息：方法名、行等 */
#if DEBUG
#define LZLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define LZLog(fmt, ...)
#endif

#endif /* LZLogDefine_h */
