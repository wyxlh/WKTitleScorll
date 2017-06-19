//
//  AttributedLbl.h
//  Demo
//
//  Created by 王宇 on 2017/4/25.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AttributedLbl : NSObject

/**
 适用于一个字符串中有两种颜色的 并且字体大小不一样的
 @param lable Lable
 @param titleString 内容
 @param textFont 设置需要的字体大小
 @param fontRang 字体大小的位置
 @param textColor 字体颜色
 @param range 字体颜色的位置
 */
+(void)setRichText:(UILabel *)lable titleString:(NSString *)titleString textFont:(UIFont *)textFont fontRang:(NSRange)fontRang textColor:(UIColor *)textColor colorRang:(NSRange)range;


/**
 适用于一个字符串中有两种颜色的但是不是在一个位置的中间有被叉开  并且字体大小不一样的
 比如 今天我花了¥100元 在路上捡了¥50元 数字变颜色 其实这样写比较麻烦  可以直接用第一种 自己去计算下第二个数字的下标就可以了
 @param lable Lable
 @param titleString 内容
 @param textFirstFont 设置需要的字体大小 第一个
 @param fontFirstRang 字体大小的位置
 @param textFirstColor 字体颜色
 @param colorFirstRang 字体颜色的位置
 @param textSecondFont 设置需要的字体大小 第二个
 @param fontSecondRang 字体大小的位置
 @param textSecondColor 字体颜色
 @param colorSecondRang 字体颜色的位置
 */
+(void)setRichTwoText:(UILabel *)lable titleString:(NSString *)titleString textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang textFirstColor:(UIColor *)textFirstColor colorFirstRang:(NSRange)colorFirstRang textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang textSecondColor:(UIColor *)textSecondColor colorSecondRang:(NSRange)colorSecondRang;


/**
 适用于两种字体大小 一种颜色 比如 原价¥100  ¥字体为12号 100位18号, 原价14号

 @param lable Lable
 @param titleString 内容
 @param textColor 字体颜色
 @param colorRang 字体颜色的位置
 @param textFirstFont 字体大小(¥的)
 @param fontFirstRang 字体大小的位置
 @param textSecondFont 字体大小(100的)
 @param fontSecondRang 字体大小的位置
 */
+(void)setRichTextTwoTypsFontAndColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang  textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang;


/**
 只设置颜色的不同

 @param lable Lable
 @param titleString 内容
 @param textColor 字体颜色
 @param colorRang 字体颜色的位置
 */
+(void)setRichTextOnlyColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang;
/**
 只设置字体的不同
 
 @param lable Lable
 @param titleString 内容
 @param textFont 字体大小
 @param fontRang 字体大小的位置
 */
+(void)setRichTextOnlyFont:(UILabel *)lable titleString:(NSString *)titleString  textFont:(UIFont *)textFont fontRang:(NSRange)fontRang;


/**
 设置行间距

 @param lable lable
 @param titleString titleString
 @param textColor textColor
 @param colorRang colorRang
 @param LineSpacing LineSpacing
 */
+(void)setRiChLineSpacing:(UILabel *)lable titleString:(NSString *)titleString textColor:(UIColor *)textColor colorRang:(NSRange)colorRang LineSpacing:(CGFloat )LineSpacing;

@end
