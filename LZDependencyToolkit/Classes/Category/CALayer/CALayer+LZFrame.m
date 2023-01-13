//
//  CALayer+LZFrame.m
//  Pods
//
//  Created by Dear.Q on 16/8/9.
//
//

#import "CALayer+LZFrame.h"

@implementation CALayer (LZFrame)

#pragma mark 边界

- (CGFloat)left
{
    return self.x - self.width / 2;
}

- (void)setLeft:(CGFloat)left
{
    [self setX:left + self.width / 2];
}

- (CGFloat)top
{
    return self.y - self.height / 2;
}

- (void)setTop:(CGFloat)top
{
    [self setY:top + self.height / 2];
}

- (CGFloat)right
{
    return self.x + self.width / 2;
}

- (void)setRight:(CGFloat)right
{
    [self setX:right - self.width / 2];
}

- (CGFloat)bottom {
    return self.y + self.height / 2;
}

- (void)setBottom:(CGFloat)bottom
{
    [self setY:bottom - self.height / 2];
}

#pragma mark 边界

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (void)setWidth:(CGFloat)width
{
    [self setBounds:CGRectMake(0, 0, self.height, width)];
}

- (CGFloat)height
{
    return self.bounds.size.height;
}

- (void)setHeight:(CGFloat)height
{
    [self setBounds:CGRectMake(0, 0, self.width, height)];
}

- (CGSize)size
{
    return self.bounds.size;
}

- (void)setSize:(CGSize)size
{
    [self setBounds:CGRectMake(0, 0, size.width, size.height)];
}

#pragma mark 位置

- (CGFloat)x
{
    return self.position.x;
}

- (void)setX:(CGFloat)x
{
    [self setPosition:CGPointMake(x, self.y)];
}

- (CGFloat)y
{
    return self.position.y;
}

- (void)setY:(CGFloat)y
{
    [self setPosition:CGPointMake(self.x, y)];
}

- (CGFloat)z
{
    return self.zPosition;
}

- (void)setZ:(CGFloat)z
{
    [self setZPosition:z];
}

#pragma mark 中心相对于左上角的坐标

- (CGPoint)midPoint
{
    return CGPointMake(self.width / 2, self.height / 2);
}

- (CGFloat)midX
{
    return self.width / 2;
}

- (CGFloat)midY
{
    return self.height / 2;
}

@end
