//
//  UIView+LZExtension.m
//  Pods
//
//  Created by Dear.Q on 16/7/20.
//
//

#import "UIView+LZExtension.h"

@implementation UIView (LZExtension)

- (UIViewController *)viewController {
	
	UIResponder *responder = self;
	while ((responder = [responder nextResponder])) {
		if ([responder isKindOfClass: [UIViewController class]]) {
			return (UIViewController *)responder;
		}
	}
	return nil;
}

- (UIImage *)onScreenShort {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    BOOL success = [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return success ? image : nil;
}

@end
