//
//  LZWeakDefine.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/7/16.
//

#ifndef LZWeakDefine_h
#define LZWeakDefine_h

#ifndef weakify
#define weakify(...) \
lz_keywordify \
metamacro_foreach_cxt(sd_weakify_,, __weak, __VA_ARGS__)
#endif

#ifndef strongify
#define strongify(...) \
lz_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(sd_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")
#endif

#if DEBUG
#define lz_keywordify autoreleasepool {}
#else
#define lz_keywordify try {} @catch (...) {}
#endif

#endif /* LZWeakDefine_h */
