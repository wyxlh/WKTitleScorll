//
//  TextFrameViewController.m
//  Demo
//
//  Created by 王宇 on 2017/9/21.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "TextFrameViewController.h"
#import "WKTextFrameTableViewCell.h"
#import "WKTextHeadView.h"
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface TextFrameViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WKTextHeadView *headView;
@end

@implementation TextFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试 Frame";
//    [self.tableView reloadData];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKTextFrameTableViewCell *cell              = [tableView dequeueReusableCellWithIdentifier:@"WKTextFrameTableViewCell" forIndexPath:indexPath];
    cell.title.text                             = indexPath.row == 0 ? @"hahaha" : @"aaaa";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _headView.frame                            = CGRectMake(0, 0, ScreenWidth, 100);
    return self.headView;
}


#pragma mark tableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView                              = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
        _tableView.delegate                     = self;
        _tableView.dataSource                   = self;
        _tableView.estimatedRowHeight           = YES;
        _tableView.rowHeight                    = 50;
//        _tableView.tableHeaderView              = self.headView;
        [_tableView registerNib:[UINib nibWithNibName:@"WKTextFrameTableViewCell" bundle:nil] forCellReuseIdentifier:@"WKTextFrameTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(WKTextHeadView *)headView{
    if (!_headView) {
        _headView                               = [[[NSBundle mainBundle] loadNibNamed:@"WKTextHeadView" owner:nil options:nil] lastObject];
    }
    return _headView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
