//
//  TitleScrollView.m
//  titleScrollViewTest
//
//  Created by GCF on 16/5/17.
//  Copyright © 2016年 GCF. All rights reserved.
//

#import "TitleScrollView.h"
#import "UIView+Frame.h"
#import "TitleScrollHelper.h"
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
            orign_x = orign_x+space+size.width;
            self.contentSize = CGSizeMake(orign_x, height);
            if (i == selected_index)
            {
                [self.titleButton setSelected:YES];
                self.selectedButt = self.titleButton;
                self.line =[[UILabel alloc]init];
                self.line.backgroundColor = selectColor;
                [self addSubview:self.line];
            }
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
    CGSize size = [TitleScrollHelper titleSize:butt.titleLabel.text height:butt.frame.size.height];
    CGFloat width = self.isEqualWidth?self.width/ self.buttonArray.count:size.width;
    self.line.bounds = CGRectMake(0, 0, width, 1.5);
    self.line.center = CGPointMake(butt.center.x, butt.frame.size.height-0.75);
    for (UIButton *button in  self.buttonArray)
    {
        BOOL isSelected = button.tag == butt.tag?YES:NO;
        [button setSelected:isSelected];
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

@end
