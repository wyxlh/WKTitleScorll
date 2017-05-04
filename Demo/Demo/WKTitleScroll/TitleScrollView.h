//
//  TitleScrollView.h
//  titleScrollViewTest
//
//  Created by GCF on 16/5/17.
//  Copyright © 2016年 GCF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleScrollHelper.h"
#import <objc/runtime.h>
@interface TitleScrollView : UIScrollView
typedef void (^SelectBlock)(NSInteger index);

/**
 *   创建一个标题滚动栏
 *
 *  @param frame           布局
 *  @param titleArray     标题数组
 *  @param selected_index 默认选中按钮的索引
 *  @param scrollEnable   能否滚动
 *  @param isEqualWidth   下面的条子是否按数量等分宽度 YES:等分 NO:按照标题宽度
 *  @param selectColor    选择颜色
 *  @param defaultColor   默认颜色
 *  @param selectBlock    点击标题回调方法
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame
                  TitleArray:(NSArray *)titleArray
               selectedIndex:(NSInteger)selected_index
                scrollEnable:(BOOL)scrollEnable
              lineEqualWidth:(BOOL)isEqualWidth
                 selectColor:(UIColor *)selectColor
                defaultColor:(UIColor *)defaultColor
                 SelectBlock:(SelectBlock)selectBlock;


/**
 *  数据源
 */
@property (nonatomic,strong)NSArray *titleArray;

/**
 *  是否需要滚动
 */
@property (nonatomic,assign)BOOL       scrollEnable;

/**
 *  选择回调
 */
@property (nonatomic,copy)  SelectBlock    block;

/**
 *  是否需要均分
 */
@property (nonatomic,assign)BOOL       isEqualWidth;
/**
 *  修改选中标题
 *
 *  @param selectedIndex 选中标题的索引
 */
-(void)setSelectedIndex:(NSInteger)selectedIndex;
/**
 *  把按钮放出来以便改变可以其颜色 （陈亮）
 */
@property (nonatomic,strong) UIButton *titleButton;
/**
 *  把line放出来,有的界面不需要显示,直接隐藏它
 */
@property (nonatomic,strong) UILabel        *line;
/**
 * 把选中的按钮放出来以便改变可以其颜色
 */
@property (nonatomic,strong) UIButton       *selectedButt;
/**
 *  把所有的按钮暴露出来 （XinMa）
 */
@property (nonatomic,strong) NSMutableArray *buttonArray;
/**
 *  默认颜色 （XinMa）
 */
@property (nonatomic,strong) UIColor *defaultColor;

/**
 *  选中的颜色
 */
@property (nonatomic,strong) UIColor *selectColor;

/**
 * 默认第几个被选中
 */
@property (nonatomic,assign) NSInteger selected_index;
@end
