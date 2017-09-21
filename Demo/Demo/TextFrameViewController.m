//
//  TextFrameViewController.m
//  Demo
//
//  Created by 王宇 on 2017/9/21.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "TextFrameViewController.h"
#import "WKTextFrameTableViewCell.h"
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface TextFrameViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TextFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试 Frame";
    [self.tableView reloadData];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKTextFrameTableViewCell *cell              = [tableView dequeueReusableCellWithIdentifier:@"WKTextFrameTableViewCell" forIndexPath:indexPath];
    cell.title.text = indexPath.row == 0 ? @"hahaha" : @"aaaa";
    return cell;
}


#pragma mark tableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView                              = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
        _tableView.delegate                     = self;
        _tableView.dataSource                   = self;
        _tableView.estimatedRowHeight           = YES;
        _tableView.rowHeight                    = 50;
        [_tableView registerNib:[UINib nibWithNibName:@"WKTextFrameTableViewCell" bundle:nil] forCellReuseIdentifier:@"WKTextFrameTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
