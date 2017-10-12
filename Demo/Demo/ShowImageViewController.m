//
//  ShowImageViewController.m
//  Demo
//
//  Created by 王宇 on 2017/4/13.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "ShowImageViewController.h"

@interface ShowImageViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *dataArr;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@property (weak, nonatomic) UIImageView *lastImageView;
@property (nonatomic, assign)CGRect originalFrame;
@property (weak, nonatomic) UIScrollView *scrView;
@end

@implementation ShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"图片放大";
    self.dataArr=@[@"bg",@"headBgView"];
    self.imgView.image=[UIImage imageNamed:self.dataArr[0]];
    
}
- (IBAction)clickImage:(UITapGestureRecognizer *)sender {
    if (![(UIImageView *)sender.view image]) {
        return;
    }
    //scrollView作为背景
    UIScrollView *bgView = [[UIScrollView alloc] init];
    bgView.frame = [UIScreen mainScreen].bounds;
    bgView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tapBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
    [bgView addGestureRecognizer:tapBg];
    
    UIImageView *picView = (UIImageView *)sender.view;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = picView.image;
    imageView.frame = [bgView convertRect:picView.frame fromView:self.view];
    [bgView addSubview:imageView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:bgView];
    
    self.lastImageView = imageView;
    self.originalFrame = imageView.frame;
    self.scrView = bgView;
    //最大放大比例
    self.scrView.maximumZoomScale = 1.5;
    self.scrView.delegate = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = imageView.frame;
        frame.size.width = bgView.frame.size.width;
        frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
        frame.origin.x = 0;
        frame.origin.y = (bgView.frame.size.height - frame.size.height) * 0.5;
        imageView.frame = frame;
    }];

}
-(void)tapBgView:(UITapGestureRecognizer *)tapBgRecognizer
{
    self.scrView.contentOffset = CGPointZero;
    [UIView animateWithDuration:0.5 animations:^{
        self.lastImageView.frame = self.originalFrame;
        tapBgRecognizer.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [tapBgRecognizer.view removeFromSuperview];
        self.scrView = nil;
        self.lastImageView = nil;
    }];
}
//返回可缩放的视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.lastImageView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)clickBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.leftCons.constant = sender.selected ? 100 : 20;
}

@end
