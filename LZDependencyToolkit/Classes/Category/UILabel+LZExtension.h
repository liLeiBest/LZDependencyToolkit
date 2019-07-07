//
//  UILabel+LZExtension.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LZExtension)

/**
 @author Lilei
 
 @brief 两端分散对齐
 */
- (void)distributeText;

@end

@interface UILabel (LZAlertActionFont)

/** font */
@property (nonatomic,copy) UIFont *appearanceFont UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
