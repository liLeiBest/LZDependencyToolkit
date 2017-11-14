//
//  UIBarButtonItem+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 16/8/18.
//
//

#import <UIKit/UIKit.h>

/**
 @author Lilei
 
 @remark 需要保存实现的 UIBarButtonItem，然后才能设置其 hidden 和 enable 属性。（暂不知道为什么）
 @code @property (weak, nonatomic) UIBarButtonItem *myLeftNavigationItem;
 */
@interface UIBarButtonItem (LZExtension)

/**
 @author Lilei
 
 @brief 创建一个自定义导航按钮(标题、默认状态图片、高亮状态图片、代理、点击事件)
 
 @param title           标题
 @param normalImg       默认状态图片
 @param highlightImg    高亮状态图片
 @param target          代理
 @param action          点击事件
 
 @return UIBarButtonItem
 */
- (UIBarButtonItem *)initWithTitle:(NSString *)title
                         normalImg:(NSString *)normalImg
                      highlightImg:(NSString *)highlightImg
                            target:(id)target
                            action:(SEL)action;

/**
 @author Lilei
 
 @brief 创建一个自定义导航按钮(标题、默认状态图片、高亮状态图片、代理、点击事件)
 
 @param title            标题
 @param normalImage      默认状态图片
 @param highlightedImage 高亮状态图片
 @param target           代理
 @param action           点击事件
 
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                        noralImage:(NSString *)normalImage
                  highlightedImage:(NSString *)highlightedImage
                            target:(id)target
                            action:(SEL)action;

/**
 @author Lilei
 
 @brief 创建一个自定义导航按钮(标题、代理、点击事件)
 
 @param title  标题
 @param target 代理
 @param action 点击事件
 
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                            target:(id)target
                            action:(SEL)action;

@end

@interface UINavigationItem (LZExtension)

@end
