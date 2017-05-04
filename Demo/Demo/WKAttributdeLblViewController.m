//
//  WKAttributdeLblViewController.m
//  Demo
//
//  Created by 王宇 on 2017/5/4.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WKAttributdeLblViewController.h"
#import "AttributedLbl.h"
#import "UILabel+YBAttributeTextTapAction.h"
#define WKAlertShow(messageText,buttonName) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:(messageText) \
delegate:nil cancelButtonTitle:(buttonName) otherButtonTitles: nil];\
[alert show];
@interface WKAttributdeLblViewController ()<YBAttributeTapActionDelegate>
@property (weak, nonatomic) IBOutlet UILabel *oneLbl;
@property (weak, nonatomic) IBOutlet UILabel *twoLbl;
@property (weak, nonatomic) IBOutlet UILabel *threeLbl;
@property (weak, nonatomic) IBOutlet UILabel *fourLbl;
@property (weak, nonatomic) IBOutlet UILabel *fiveLbl;
@property (weak, nonatomic) IBOutlet UILabel *sixLbl;
@end

@implementation WKAttributdeLblViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 适用于一个字符串中有两种颜色的 并且字体大小不一样的
    NSString *oneStr=@"合计: ¥100.00";
    [AttributedLbl setRichText:self.oneLbl titleString:oneStr textFont:[UIFont systemFontOfSize:25] fontRang:NSMakeRange(4, oneStr.length-4) textColor:[UIColor redColor] colorRang:NSMakeRange(4, oneStr.length-4)];
    // 适用于一个字符串中有两种颜色的但是不是在一个位置的中间有被叉开  并且字体大小不一样的
    NSString *twoStr=@"今天我花了¥100.00元 在路上捡了¥50.00元";
    [AttributedLbl setRichTwoText:self.twoLbl titleString:twoStr textFirstFont:[UIFont systemFontOfSize:22] fontFirstRang:NSMakeRange(5, 7) textFirstColor:[UIColor redColor] colorFirstRang:NSMakeRange(5, 7) textSecondFont:[UIFont systemFontOfSize:22] fontSecondRang:NSMakeRange(19, 6) textSecondColor:[UIColor redColor] colorSecondRang:NSMakeRange(19, 6)];
    // 适用于两种字体大小 一种颜色 比如 原价¥100  ¥字体为12号 100位18号, 原价14号
    NSString *threeStr=@"原价: ¥100.00";
    [AttributedLbl setRichTextTwoTypsFontAndColor:self.threeLbl titleString:threeStr textColor:[UIColor redColor] colorRang:NSMakeRange(4, threeStr.length-4) textFirstFont:[UIFont systemFontOfSize:17] fontFirstRang:NSMakeRange(4, 1) textSecondFont:[UIFont systemFontOfSize:35] fontSecondRang:NSMakeRange(5, threeStr.length-5)];
    
    NSString *fourStr=@"原价: ¥100.00";
    [AttributedLbl setRichTextOnlyColor:self.fourLbl titleString:fourStr textColor:[UIColor redColor] colorRang:NSMakeRange(4, fourStr.length-4)];
    
    
    NSString *sieStr=@"来呀,点击我呀";
    [AttributedLbl setRichTextOnlyColor:self.sixLbl titleString:sieStr textColor:[UIColor redColor] colorRang:NSMakeRange(3, sieStr.length-3)];
    //这个是借鉴的别人的
    [_sixLbl yb_addAttributeTapActionWithStrings:@[@"点击我呀"] delegate:self];
    
}
//delegate
- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index
{
    NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),index];
    WKAlertShow(message, @"取消");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
