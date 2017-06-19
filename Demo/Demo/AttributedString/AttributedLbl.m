//
//  AttributedLbl.m
//  Demo
//
//  Created by 王宇 on 2017/4/25.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "AttributedLbl.h"

@implementation AttributedLbl

+(void)setRichText:(UILabel *)lable titleString:(NSString *)titleString textFont:(UIFont *)textFont fontRang:(NSRange)fontRang textColor:(UIColor *)textColor colorRang:(NSRange)range{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFont range:fontRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    
    [lable setAttributedText:Attributed];
    
}

+(void)setRichTwoText:(UILabel *)lable titleString:(NSString *)titleString textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang textFirstColor:(UIColor *)textFirstColor colorFirstRang:(NSRange)colorFirstRang textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang textSecondColor:(UIColor *)textSecondColor colorSecondRang:(NSRange)colorSecondRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFirstFont range:fontFirstRang];
    
    [Attributed addAttribute:NSFontAttributeName value:textSecondFont range:fontSecondRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textFirstColor range:colorFirstRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textSecondColor range:colorSecondRang];
    
    [lable setAttributedText:Attributed];
}

+(void)setRichTextTwoTypsFontAndColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang  textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFirstFont range:fontFirstRang];
    
    [Attributed addAttribute:NSFontAttributeName value:textSecondFont range:fontSecondRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    
    [lable setAttributedText:Attributed];
}



+(void)setRichTextOnlyColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    
    [lable setAttributedText:Attributed];
}

+(void)setRichTextOnlyFont:(UILabel *)lable titleString:(NSString *)titleString  textFont:(UIFont *)textFont fontRang:(NSRange)fontRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textFont range:fontRang];
    
    [lable setAttributedText:Attributed];
}

+(void)setRiChLineSpacing:(UILabel *)lable titleString:(NSString *)titleString textColor:(UIColor *)textColor colorRang:(NSRange)colorRang LineSpacing:(CGFloat )LineSpacing{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距设置为4
    [paragraphStyle  setLineSpacing:5];
    
    [Attributed  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [titleString length])];
    //    设置之后 为了让位子居中显示
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    [lable setAttributedText:Attributed];
}

@end
