//
//  WKChildViewController.m
//  WKKit
//
//  Created by 王宇 on 16/9/27.
//  Copyright © 2016年 王宇. All rights reserved.
//
//自定义颜色
#define CustomColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#import "WKChildViewController.h"

@interface WKChildViewController ()

@end

@implementation WKChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    self.view.backgroundColor=CustomColor(R, G, B, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
