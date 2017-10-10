//
//  WKTextFrameTableViewCell.m
//  Demo
//
//  Created by 王宇 on 2017/9/21.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WKTextFrameTableViewCell.h"

@implementation WKTextFrameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
