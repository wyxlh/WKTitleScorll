//
//  UIView+Frame.h
//  SKKit
//
//  Created by GCF on 16/4/20.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
/**
 *  重写系统的UIView的frame下各个属性的set,get方法,方便直接修改视图的位置和大小
 */
@property (nonatomic, assign) CGFloat  x;
@property (nonatomic, assign) CGFloat  y;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;

@property (nonatomic, assign) CGFloat  maxX;
@property (nonatomic, assign) CGFloat  centerX;

@property (nonatomic, assign) CGFloat  maxY;
@property (nonatomic, assign) CGFloat  centerY;
@property (nonatomic, assign) CGPoint  origin;
@property (nonatomic, assign) CGSize  size;

/**
 *  移除子视图
 */
-(void)removeAllSubview;
@end
