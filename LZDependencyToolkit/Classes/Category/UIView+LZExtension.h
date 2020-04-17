//
//  UIView+LZExtension.h
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LZFrame)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property(nonatomic,assign) CGPoint orgin;
@property (nonatomic, assign) CGSize size;
@property(nonatomic, readonly) CGPoint midPoint;
@property(nonatomic, readonly) CGFloat midX;
@property(nonatomic, readonly) CGFloat midY;

@end

@interface UIView (LZViewController)

/**
 @author Lilei
 
 @brief 获取当前视图所在的控制器
 
 @return UIViewController
 */
- (nullable UIViewController *)viewController;

@end

@interface UIView (LZBunble)

/**
 @author Lilei
 
 @brief View 的资源目录
 
 @param resource 资源名称
 @return NSBundle
 */
- (nonnull NSBundle *)bundleForResource:(nullable NSString *)resource;

/**
 @author Lilei
 
 @brief 加载资源目录下的图片
 
 @param imageName 图片名称
 @param bundleName 资源名称
 @return UIImage
 */
- (nullable UIImage *)image:(nonnull NSString *)imageName
				   inBundle:(nullable NSString *)bundleName;

/**
 @author Lilei
 
 @brief 加载资源目录下的 View XIB
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @return instancetype
 */
+ (nullable instancetype)viewFromXib:(nonnull NSString *)xibName
							inBundle:(nullable NSString *)bundleName;

/**
 @author Lilei
 
 @brief 复用资源目录下的 View XIB
 
 @param xibName xib 名称
 @param bundleName 资源名称
 @return instancetype
 */
- (nullable instancetype)reuseViewFromXib:(nonnull NSString *)xibName
								 inBundle:(nullable NSString *)bundleName;

@end

@interface UIView (LZRoundCorner)

/**
 圆角任意角

 @param corners UIRectCorner
 @param radius CGFloat
 */
- (void)roundingCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 圆角任意角
 
 @param rect View 精确区域
 @param corners UIRectCorner
 @param radius CGFloat
 */
- (void)roundedRect:(CGRect)rect
    roundingCorners:(UIRectCorner)corners
             radius:(CGFloat)radius;

@end

@interface UIView (LZInputView)

/**
配置输入框的最大输入长度

@param limitLength NSUInteger
@param textContent NSString
*/
- (void)configLimitLength:(NSUInteger)limitLength
              textContent:(nullable NSString *)textContent;

@end

@interface UIView (LZScreenShort)

/**
 视图截图
 
 @return UIImage
 */
- (nullable UIImage *)onScreenShort;

@end

NS_ASSUME_NONNULL_END
