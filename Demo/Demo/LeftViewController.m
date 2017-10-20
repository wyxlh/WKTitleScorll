//
//  LeftViewController.m
//  Demo
//
//  Created by 王宇 on 2017/8/15.
//  Copyright © 2017年 wy. All rights reserved.
//
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SKOrangeColor    [UIColor colorWithRed:250/255. green:50/255. blue:100/255. alpha:1]
#import "LeftViewController.h"
#import "TitleScrollView.h"
#import "WKChildViewController.h"
#import "UIView+Frame.h"
#import "DCPagerProgressView.h"
@interface LeftViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic,strong)TitleScrollView *titleScroll;
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic, assign)BOOL flag;
@property (nonatomic, strong) DCPagerProgressView *pregressView;
/** 进度条 */
@property (nonatomic, assign) CGFloat progress;
/** 是否拉伸 */
@property (nonatomic, assign) BOOL isStretch;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.isStretch = YES;
    self.titleArr=@[@"全部订单",@"待支付",@"待发货",@"待收货",@"待评价",@"待评价",@"待评价",@"待评价",@"待评价",@"待评价"];//10个
    [self addChildViewControllers];
    //底部的scrollview
    [self setupContentView];
}

#pragma mark - 懒加载 设置顶部标签栏  选如果你需要平分界面 scrollEnable 设为 NO lineEqualWidth ->YES  紧挨着  scrollEnable-->YES   lineEqualWidth-->NO 选中字体是否变大 isLarger
- (TitleScrollView *)titleScroll
{
    if (!_titleScroll)
    {
        WS(weakSelf)
        _titleScroll = [[TitleScrollView alloc] initWithFrame:CGRectMake(0,[self topHeight], ScreenWidth, 47)  TitleArray:self.titleArr selectedIndex:0 scrollEnable:YES lineEqualWidth:YES isLarger:NO selectColor:SKOrangeColor defaultColor:[UIColor blackColor] SelectBlock:^(NSInteger index) {
            [weakSelf titleClick:index];
        }];
        _titleScroll.backgroundColor = [UIColor whiteColor];
//        _titleScroll.line.hidden = YES;
        _pregressView                = _titleScroll.line;
        [self.view addSubview:_titleScroll];
    }
    return _titleScroll;
}

#pragma mark 底部的scrollview
-(void)setupContentView {
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = CGRectMake(0, self.titleScroll.height, ScreenWidth, ScreenHeight);
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    
    self.contentView = contentView;
    self.contentView.contentOffset = CGPointMake(0*ScreenWidth, 0);
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}
#pragma mark 便签栏按钮点击
-(void)titleClick:(NSInteger)index {
    //滚动,切换子控制器
    CGPoint offset = self.contentView.contentOffset;
    offset.x = index * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //添加子控制器的view
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置控制器的y值为0(默认为20)
    vc.view.height = scrollView.height;//设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //点击butto
    [self.titleScroll setSelectedIndex:index];
}
#pragma mark  改变字的渐变颜色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self bottomBarNaughtyWithOffset:scrollView.contentOffset.x];
    //获取标题
    NSInteger  leftI = scrollView.contentOffset.x/ScreenWidth;
    NSInteger  rightI = leftI+1;
    NSLog(@"%f",scrollView.contentOffset.x);
    //获取左边的按钮
    UIButton *leftBtn  = self.titleScroll.buttonArray[leftI];
    //获取右边的按钮
    UIButton *rightBtn;
    if (rightI<self.titleScroll.buttonArray.count) {
        rightBtn  = self.titleScroll.buttonArray[rightI];
    }
    CGFloat scaleR = scrollView.contentOffset.x/ScreenWidth;
    scaleR -= leftI;
    CGFloat scaleL = 1- scaleR;
    //缩放按钮
    leftBtn.transform = CGAffineTransformMakeScale(scaleL *0.01 + 1, scaleL*0.01 + 1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleR*0.01 + 1, scaleR*0.01 + 1);
    // 如果想让字变大一点, 就使用下面的 但是使用这个最好调节把下面的线隐藏掉, 或者自己调一下
//    leftBtn.transform = CGAffineTransformMakeScale(scaleL *0.1 + 1, scaleL*0.1 + 1);
//    rightBtn.transform = CGAffineTransformMakeScale(scaleR*0.1 + 1, scaleR*0.1 + 1);
    //颜色渐变
    UIColor *rightColor  = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor  = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
    [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isStretch = YES;
}

#pragma mark - 底部滚动条滚动
- (void)bottomBarNaughtyWithOffset:(CGFloat)offsetx
{
    if (offsetx < 0) //最小
    {
        offsetx = 0;
    }
    _pregressView.isStretch  = self.isStretch;
    _pregressView.progress = offsetx / _titleScroll.width;
}


-(void)addChildViewControllers{
    for (int i = 0; i < self.titleArr.count; i++) {
        WKChildViewController *child = [[WKChildViewController alloc]init];
        child.index = i;
        [self addChildViewController:child];
    }
}

-(NSInteger)topHeight{
    return ScreenHeight > 736 ? 84 : 64;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
