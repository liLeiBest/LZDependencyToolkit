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
 
 UIBarButtonItem 分类
 
 @discussion 扩展 UIBarButtonItem 的实例方法，可以通过其父类的 setTitleTextAttributes:forState: 设置各种状态的文字颜色
 */
@interface UIBarButtonItem (LZExtension)

/** 隐藏或显示自定义导航按钮，对系统方式创建的导航按钮无消 */
@property (nonatomic, assign, getter=isHiddenItem) BOOL hiddenItem;


/**
 @author Lilei
 
 @brief 创建一个自定义导航按钮(标题、默认状态图片/高亮状态图片/不可用图片/代理/点击事件)
 
 @param title           标题
 @param normalImage     默认状态图片(UIImage/NSString)
 @param highlightImage  高亮状态图片(UIImage/NSString)
 @param disableImage    不可用状态图片(UIImage/NSString)
 @param target          代理
 @param action          点击事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                       normalImage:(NSObject *)normalImage
                    highlightImage:(NSObject *)highlightImage
                      disableImage:(NSObject *)disableImage
                            target:(id)target
                            action:(SEL)action;

/**
 @author Lilei
 
 @brief 创建一个自定义导航按钮(标题/代理/点击事件)
 
 @param title   标题
 @param target  代理
 @param action  点击事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                            target:(id)target
                            action:(SEL)action;

@end

@interface UINavigationItem (LZExtension)

@end
