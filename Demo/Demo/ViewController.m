//
//  ViewController.m
//  Demo
//
//  Created by 王宇 on 2017/3/29.
//  Copyright © 2017年 wy. All rights reserved.
//

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SKOrangeColor    [UIColor colorWithRed:250/255. green:50/255. blue:100/255. alpha:1]
#import "ViewController.h"
#import "TitleScrollView.h"
#import "WKChildViewController.h"
#import "UIView+Frame.h"
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic,strong)TitleScrollView *titleScroll;
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic, strong) DCPagerProgressView *pregressView;
/** 进度条 */
@property (nonatomic, assign) CGFloat progress;
/** 是否拉伸 */
@property (nonatomic, assign) BOOL isStretch;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr=@[@"全部订单",@"待支付",@"待发货",@"待收货哈哈哈",@"待评价"]; //5个
    self.isStretch = YES;
    [self addChildViewControllers];
    //底部的scrollview
    [self setupContentView];
    UIWindow *window = [[UIWindow alloc]init];
    [window bringSubviewToFront:self.view];
}
#pragma mark - 懒加载 设置顶部标签栏  选如果你需要平分界面 scrollEnable 设为 NO lineEqualWidth ->YES  紧挨着  scrollEnable-->YES   lineEqualWidth-->NO 选中字体是否变大 isLarger
- (TitleScrollView *)titleScroll
{
    if (!_titleScroll)
    {
        WS(weakSelf)
        _titleScroll = [[TitleScrollView alloc] initWithFrame:CGRectMake(0,[self topHeight], ScreenWidth, 47)  TitleArray:self.titleArr selectedIndex:0 scrollEnable:NO lineEqualWidth:YES isLarger:YES selectColor:SKOrangeColor defaultColor:[UIColor blackColor] SelectBlock:^(NSInteger index) {
            [weakSelf titleClick:index];
        }];
        _titleScroll.backgroundColor = [UIColor whiteColor];
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
    self.isStretch = NO;
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self bottomBarNaughtyWithOffset:scrollView.contentOffset.x];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isStretch = YES;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //点击butto
    [self.titleScroll setSelectedIndex:index];
}
#pragma mark 添加子视图
-(void)addChildViewControllers{
    for (int i = 0; i < self.titleArr.count; i++) {
        WKChildViewController *child = [[WKChildViewController alloc]init];
        child.index = i;
        [self addChildViewController:child];
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(NSInteger)topHeight{
    return ScreenHeight > 736 ? 84 : 64;
}



@end
