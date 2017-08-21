# WKTitleScorll

# TitleScorll 使用

* 1 .导入 并定义 
```
#import "TitleScrollView.h"
@property (nonatomic,strong)TitleScrollView *titleScroll;
```
* 2 实现
```
- (TitleScrollView *)titleScroll
{
if (!_titleScroll)
{
WS(weakSelf)
_titleScroll = [[TitleScrollView alloc] initWithFrame:CGRectMake(0,64, ScreenWidth, 47)  TitleArray:self.titleArr selectedIndex:0 scrollEnable:NO lineEqualWidth:YES isLarger:YES selectColor:SKOrangeColor defaultColor:[UIColor blackColor] SelectBlock:^(NSInteger index) {
[weakSelf titleClick:index];
}];
_titleScroll.backgroundColor = [UIColor whiteColor];

[self.view addSubview:_titleScroll];
}
return _titleScroll;
}
```
* 3添加指示图 并 实现对应的协议
```
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



-(void)addChildViewControllers{
for (int i = 0; i < self.titleArr.count; i++) {
WKChildViewController *child = [[WKChildViewController alloc]init];
child.index = i;
[self addChildViewController:child];
}
}
```
# 新增 TitleScrollView 选中字体变大  isLarger 以及 界面不均分的情况 就像今日头条的那种 详情请见 Demo
* 初始化的时候设置即可
![界面演示 gif图](https://github.com/wyxlh/WKTitleScorll/blob/master/QQ20170815-143427-HD.gif)

# 富文本的使用 
* 详细见 WKAttributdeLblViewController 这里面的
* 新增富文本, 设置行间距
# 优化 TitleScollView 滑动渐变字体颜色, 和 选中的时候是否改天字体大小
