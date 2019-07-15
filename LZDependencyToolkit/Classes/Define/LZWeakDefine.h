//
//  LZWeakDefine.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/7/16.
//

#ifndef LZWeakDefine_h
#define LZWeakDefine_h

#ifndef lzweakify
#define lzweakify(...) \
lz_keywordify \
metamacro_foreach_cxt(lz_weakify_,, __weak, __VA_ARGS__)
#endif

#ifndef lzstrongify
#define lzstrongify(...) \
lz_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(lz_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")
#endif

#define lz_weakify_(INDEX, CONTEXT, VAR) \
CONTEXT __typeof__(VAR) metamacro_concat(VAR, _weak_) = (VAR);

#define lz_strongify_(INDEX, VAR) \
__strong __typeof__(VAR) VAR = metamacro_concat(VAR, _weak_);

#if DEBUG
#define lz_keywordify autoreleasepool {}
#else
#define lz_keywordify try {} @catch (...) {}
#endif

#endif /* LZWeakDefine_h */
