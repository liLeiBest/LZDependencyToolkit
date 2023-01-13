//
//  CALayer+LZFrame.h
//  Pods
//
//  Created by Dear.Q on 16/8/9.
//
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (LZFrame)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGSize size;

@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;
@property(nonatomic) CGFloat z;

@property(readonly) CGPoint midPoint;
@property(readonly) CGFloat midX;
@property(readonly) CGFloat midY;

@end
