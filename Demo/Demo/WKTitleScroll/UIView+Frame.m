//
//  UIView+Frame.m
//  SKKit
//
//  Created by GCF on 16/4/20.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
@dynamic maxX;
@dynamic centerX;

@dynamic maxY;
@dynamic centerY;

/**
 *   xx
 */

- (CGFloat)maxX		{	return CGRectGetMaxX(self.frame);	}
- (CGFloat)centerX	{	return self.center.x;				}
/**
 *   yy
 */

- (CGFloat)maxY		{	return CGRectGetMaxY(self.frame);	}
- (CGFloat)centerY	{	return self.center.y;				}

/**
 *  基本参数
 */
- (CGFloat)x		{	return self.frame.origin.x;			}
- (CGFloat)y		{	return self.frame.origin.y;			}
- (CGFloat)width	{   return CGRectGetWidth(self.frame);  }
- (CGFloat)height	{   return CGRectGetHeight(self.frame); }
- (CGPoint)origin	{   return self.frame.origin;           }
- (CGSize)size		{   return self.frame.size;             }


// 移除所有子视图
- (void)removeAllSubview
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}



// xx
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

// yy
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

// width
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

// height
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

// origin
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

// size
-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
@end
