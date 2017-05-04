//
//  TitleScrollHelper.m
//  titleScrollViewTest
//
//  Created by GCF on 16/5/17.
//  Copyright © 2016年 GCF. All rights reserved.
//

#import "TitleScrollHelper.h"

@implementation TitleScrollHelper
+(CGFloat)caculateSpaceByTitleArray:(NSArray *)titleArray rect:(CGRect)rect
{
    CGFloat width = 0;
    for (NSString *title in titleArray)
    {
        width =width + [TitleScrollHelper titleSize:title height:rect.size.height].width;
    }
    return (rect.size.width - width)/titleArray.count;
}

+(CGSize)titleSize:(NSString *)title height:(CGFloat)height
{
    return [title boundingRectWithSize:CGSizeMake(0, height) options:3 attributes:@{NSFontAttributeName:titleFont} context:nil].size;
}
@end
