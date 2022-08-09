//
//  UIView+LZInputView.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2022/8/9.
//

#import "UIView+LZInputView.h"

@implementation UIView (LZInputView)

// MARK: - Public
- (void)configLimitLength:(NSUInteger)limitLength
              textContent:(NSString *)textContent {
    [self limitLength:limitLength text:textContent handler:nil];
}

- (void)configLimitLength:(NSUInteger)limitLength
              textContent:(NSString *)textContent
            changeHandler:(nullable void (^)(BOOL))handler {
    [self limitLength:limitLength text:textContent handler:^(BOOL marked, BOOL overflow) {
        if (handler) {
            handler(marked);
        }
    }];
}

- (void)limitLength:(NSUInteger)limitLength
               text:(NSString *)textContent
            handler:(void (^)(BOOL, BOOL))handler {
    
    Protocol *protocol = @protocol(UITextInput);
    NSAssert([self conformsToProtocol:protocol], @"不是可输入视图");
    UIView<UITextInput> *inputView = (UIView<UITextInput> *)self;
    
    long count = 0;
    // 获取当前输入模式
    NSArray *activeInputModes = [UITextInputMode activeInputModes];
    UITextInputMode *currentInputMode = [activeInputModes firstObject];
    NSString *currentLanguage = [currentInputMode primaryLanguage];
    
    UITextPosition *position = nil;
    BOOL selected = NO;
    if ([currentLanguage isEqualToString:@"zh-Hans"]
        || [currentLanguage isEqualToString:@"intl"]) {
        //获取高亮部分
        UITextRange *selectedRange = [inputView markedTextRange];
        position = [inputView positionFromPosition:selectedRange.start offset:0];
        if (!position) { // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            count = limitLength - textContent.length;
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
            selected = YES;
        }
    } else { // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        count = limitLength - [inputView countWord:textContent];
    }
    
    if (count <= 0 && nil == position) {
        
        SEL selector = @selector(setText:);
        if ([inputView respondsToSelector:selector]) {
            
            NSString *content = [textContent substringToIndex:limitLength];
            IMP imp = [inputView methodForSelector:selector];
            void (*func)(id, SEL, NSString *) = (void *)imp;
            func(inputView, selector, content);
        }
    }
    if (handler) {
        handler(selected, count < 0);
    }
}

// MARK: - Private
- (long)countWord:(NSString *)s {
    
    long i, n = [s length], l = 0,a = 0,b = 0;
    unichar c;
    for (i = 0; i < n; i++) {
        
        c = [s characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a==0 && l==0) return 0;
    return l+(float)ceilf((float)(a+b));
}

@end
