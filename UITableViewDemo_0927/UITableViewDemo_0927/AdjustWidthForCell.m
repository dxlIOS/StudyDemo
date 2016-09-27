//
//  AdjustWidthForCellTableViewCell.m
//  UITableViewDemo_0927
//
//  Created by dxl on 16/9/27.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "AdjustWidthForCell.h"

@implementation AdjustWidthForCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 30;
    frame.size.width -= 60;
    [super setFrame:frame];
}

@end
