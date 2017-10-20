//
//  TitleScrollView.m
//  titleScrollViewTest
//
//  Created by 王宇 on 16/5/17.
//  Copyright © 2016年 wy. All rights reserved.
//

#import "TitleScrollView.h"
#import "UIView+Frame.h"
#import "TitleScrollHelper.h"
//获取设备的物理宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
@implementation TitleScrollView
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
                    isLarger:(BOOL)isLarger
                 selectColor:(UIColor *)selectColor
                defaultColor:(UIColor *)defaultColor
                 SelectBlock:(SelectBlock)selectBlock{

    self =[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        self.showsHorizontalScrollIndicator = NO;
        CGFloat orign_x = 0;
        CGFloat height = self.frame.size.height;
        
        CGFloat space = scrollEnable?20:[TitleScrollHelper caculateSpaceByTitleArray:titleArray rect:frame];
        self.buttonArray = [NSMutableArray new];
        self.block = selectBlock;
        self.isEqualWidth = isEqualWidth;
        self.scrollEnable = scrollEnable;
        self.isLarger = isLarger;
        for (int i = 0; i<titleArray.count; i++)
        {
            NSString *title =titleArray[i];
            CGSize size = [TitleScrollHelper titleSize:title height:frame.size.height];
            self.titleButton =[UIButton buttonWithType:UIButtonTypeCustom];
            self.titleButton.frame = CGRectMake(orign_x, 0, size.width+space, height);
            [self.titleButton setTitle:title forState:UIControlStateNormal];
            [self.titleButton setTitleColor:defaultColor forState:UIControlStateNormal];
            [self.titleButton setTitleColor:selectColor forState:UIControlStateSelected];
            [self.titleButton addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            self.titleButton.titleLabel.font =titleFont;
            self.titleButton.tag = i;
            CGRect frame = CGRectMake(orign_x, 43, 30, 3);
            [self.pregressFrames addObject:[NSValue valueWithCGRect:frame]];
            orign_x = orign_x+space+size.width;
            self.contentSize = CGSizeMake(orign_x, height);
            if (i == selected_index)
            {
                [self.titleButton setSelected:YES];
                self.selectedButt = self.titleButton;//这里使用 self.width+300 是为了让一个让其可以滚动能拖动
                self.line =[[DCPagerProgressView alloc]initWithFrame:CGRectMake(18, 43, self.width+300, 3.5)];
                self.line.backgroundColor = [UIColor clearColor];
                self.line.color = selectColor.CGColor;
                self.line.layer.cornerRadius = 1.5;
                self.line.layer.masksToBounds = YES;
                [self addSubview:self.line];
            }
            self.line.itemFrames = self.pregressFrames;
            [ self.buttonArray addObject:self.titleButton];
            [self addSubview:self.titleButton];
        }
        [self buttonOffset:self.selectedButt];
    }
    return self;
    
    
}

//按钮点击
-(void)headButtonClick:(UIButton *)butt
{
    [self setSelectedIndex:butt.tag];
    if (self.block) {
        self.block(butt.tag);
    }
    
}

//点击控制滚动视图的偏移量
-(void)buttonOffset:(UIButton *)butt animated:(BOOL)animated
{
    if (animated)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self buttonOffset:butt];
        }];
    }else{
        [self buttonOffset:butt];
    }
}

-(void)buttonOffset:(UIButton *)butt
{
    // 下边的线等分
//    CGSize size = [TitleScrollHelper titleSize:butt.titleLabel.text height:butt.frame.size.height];
//    CGFloat width = self.isEqualWidth?self.width/ self.buttonArray.count:size.width;
//    self.line.bounds = CGRectMake(0, 0, width, 3);
//    self.line.center = CGPointMake(butt.center.x, butt.frame.size.height-0.75);
//    if (self.scrollEnable) {
//        self.line.bounds = CGRectMake(0, 44, 30, 3);
//        self.line.backgroundColor = [UIColor colorWithRed:250/255. green:50/255. blue:100/255. alpha:1];
//        self.line.center = CGPointMake(butt.center.x, butt.frame.size.height-4);
//    }
    for (UIButton *button in  self.buttonArray)
    {
        if (self.isLarger) {
            if (button.tag == butt.tag) {
                button.selected = YES;
                button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            }else{
                button.selected = NO;
                button.titleLabel.font =titleFont;
            }
        }else{
            BOOL isSelected = button.tag == butt.tag?YES:NO;
            [button setSelected:isSelected];
        }
        
    }
    if (butt.center.x<=self.center.x)
    {
        self.contentOffset = CGPointMake(0, 0);
    }
    else if ((butt.center.x>self.center.x)&&((self.contentSize.width-butt.center.x)>(self.frame.size.width/2.0)))
    {
        self.contentOffset = CGPointMake(butt.center.x-self.center.x, 0);
    }else
    {
        self.contentOffset = CGPointMake(self.contentSize.width-self.frame.size.width, 0);
    }

}
/**
 *  修改选中标题
 *
 *  @param selectedIndex 选中标题的索引
 */
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    for (UIButton *butt in  self.buttonArray)
    {
        if (butt.tag == selectedIndex)
        {
            [self buttonOffset:butt animated:YES];
            break;
        }
    }
}

/**
 实例化
 */
- (NSMutableArray *)pregressFrames
{
    if (!_pregressFrames) {
        _pregressFrames = [NSMutableArray array];
    }
    return _pregressFrames;
}

@end
