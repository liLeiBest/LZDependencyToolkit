//
//  NSBundle+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 2017/5/4.
//
//

#import "NSBundle+LZExtension.h"
#import "NSString+LZRegular.h"

@implementation NSBundle (LZExtension)

/** 资源目录 */
+ (NSBundle *)bundleForResource:(NSString *)resource
				 referenceClass:(NSString *)className {
	
	NSBundle *bundle = nil;
	if (NO == [className isValidString]) {
		bundle = [NSBundle mainBundle];
	} else {
		bundle = [NSBundle bundleForClass:NSClassFromString(className)];
	}
	if ([resource isValidString]) {
        
		NSString *resoucePath = [bundle pathForResource:resource ofType:@"bundle"];
		bundle = [NSBundle bundleWithPath:resoucePath];
	}
	if (nil == bundle) {
		bundle = [NSBundle mainBundle];
	}
	return bundle;
}

/** 加载资源目录下的图片 */
+ (UIImage *)image:(NSString *)imageName
		  inBundle:(NSString *)bundleName
	referenceClass:(NSString *)className {
	NSAssert([imageName isValidString], @"Image 名称非法");
	UIImage *img = nil;
	NSBundle *resourceBundle = [self bundleForResource:bundleName referenceClass:className];
	if (@available(iOS 8.0, *)) {
		img = [UIImage imageNamed:imageName inBundle:resourceBundle compatibleWithTraitCollection:nil];
		if (img) {
			return img;
		}
	}
	
	NSString *name = [NSString stringWithFormat:@"%@.png", imageName];
	NSString *path =[resourceBundle pathForResource:name ofType:nil];
	img = [UIImage imageWithContentsOfFile:path];
	if (img) {
		return img;
	}
	
	name = [NSString stringWithFormat:@"%@@%.0fx.png", imageName, [[UIScreen mainScreen] scale]];
	path = [resourceBundle pathForResource:name ofType:nil];
	img = [UIImage imageWithContentsOfFile:path];
	if (img) {
		return img;
	}
    return [UIImage imageNamed:imageName];
}

/** 加载资源目录下的 View XIB */
+ (UIView *)viewFromXib:(NSString *)xibName
			   inBundle:(NSString *)bundleName
		 referenceClass:(NSString *)className {
	return [self instanceViewFromXib:xibName
							   owner:nil
							  bundle:bundleName
					  referenceClass:className];
}

/** 复用资源目录下的 View XIB */
+ (UIView *)reuseViewFromXib:(NSString *)xibName
					   owner:(UIView *)owner
					inBundle:(NSString *)bundleName
			  referenceClass:(NSString *)className {
	
	UIView *reuseView = [self instanceViewFromXib:xibName
											owner:owner
										   bundle:bundleName
								   referenceClass:className];
    reuseView.translatesAutoresizingMaskIntoConstraints = NO;
    owner.translatesAutoresizingMaskIntoConstraints = NO;
    [owner insertSubview:reuseView atIndex:0];
	
	NSLayoutConstraint *left =
	[NSLayoutConstraint constraintWithItem:reuseView
								 attribute:NSLayoutAttributeLeft
								 relatedBy:NSLayoutRelationEqual
									toItem:owner
								 attribute:NSLayoutAttributeLeft
								multiplier:1.0 constant:0];
	[owner addConstraint:left];
	NSLayoutConstraint *right =
	[NSLayoutConstraint constraintWithItem:reuseView
								 attribute:NSLayoutAttributeRight
								 relatedBy:NSLayoutRelationEqual
									toItem:owner
								 attribute:NSLayoutAttributeRight
								multiplier:1.0 constant:0];
	[owner addConstraint:right];
	NSLayoutConstraint *top =
	[NSLayoutConstraint constraintWithItem:reuseView
								 attribute:NSLayoutAttributeTop
								 relatedBy:NSLayoutRelationEqual
									toItem:owner
								 attribute:NSLayoutAttributeTop
								multiplier:1.0 constant:0];
	[owner addConstraint:top];
	NSLayoutConstraint *bottom =
	[NSLayoutConstraint constraintWithItem:reuseView
								 attribute:NSLayoutAttributeBottom
								 relatedBy:NSLayoutRelationEqual
									toItem:owner
								 attribute:NSLayoutAttributeBottom
								multiplier:1.0 constant:0];
	[owner addConstraint:bottom];
	return reuseView;
}

/** 加载资源目录下的 ViewController XIB */
+ (UIViewController *)viewControllerFromXib:(NSString *)xibName
								   inBundle:(NSString *)bundleName
							 referenceClass:(NSString *)className {
	NSAssert([xibName isValidString], @"Xib 名称非法");
	NSBundle *resourceBundle = [self bundleForResource:bundleName referenceClass:className];
	UIViewController *viewController = [[UIViewController alloc] initWithNibName:xibName bundle:resourceBundle];
	return viewController;
}

/** 加载资源目录下的 Storyboard */
+ (UIStoryboard *)storyboard:(NSString *)storyboardName
					inBundle:(NSString *)bundleName
			  referenceClass:(NSString *)className {
	NSAssert([storyboardName isValidString], @"Storyboard 名称非法");
	NSBundle *resourceBundle = [self bundleForResource:bundleName referenceClass:className];
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName
														 bundle:resourceBundle];
	return storyboard;
}

/** 加载资源目录下的 ViewController Storyboard */
+ (UIViewController *)viewControllerFromStoryboard:(NSString *)storyboardName
										  inBundle:(NSString *)bundleName
									referenceClass:(NSString *)className {
	return [[self storyboard:storyboardName
					inBundle:bundleName
			  referenceClass:className]
			instantiateInitialViewController];
}

/** 加载资源目录下的 Nib */
+ (UINib *)nib:(NSString *)nibName
	  inBundle:(NSString *)bundleName
referenceClass:(NSString *)className {
	
	NSBundle *bundle = [self bundleForResource:bundleName referenceClass:className];
	UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
	return nib;
}

// MARK: - Private
/**
 @author Lilei
 
 @brief 实例资源目录下的 View XIB
 
 @param xibName xib 名称
 @param owner id
 @param bundleName 资源名称
 @param className 参考类名
 @return UIView
 */
+ (UIView *)instanceViewFromXib:(nonnull NSString *)xibName
						  owner:(nullable id)owner
						 bundle:(nullable NSString *)bundleName
				 referenceClass:(nullable NSString *)className {
	NSAssert([xibName isValidString], @"Xib 名称非法");
	NSBundle *resourceBundle = [self bundleForResource:bundleName referenceClass:className];
	NSArray *nibs = [resourceBundle loadNibNamed:xibName owner:owner options:nil];
	UIView *xibView = nil;
	if (nibs.count > 1) {
		xibView = [nibs firstObject];
	} else {
		xibView = [nibs lastObject];
	}
	
	if (![xibView isKindOfClass:[UIView class]]) {
		for (id nibObject in nibs) {
			if ([nibObject isKindOfClass:[UIView class]]) {
				xibView = nibObject;
				break;
			}
		}
	}
	return xibView;
}

@end
