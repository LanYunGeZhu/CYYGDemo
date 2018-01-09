//
//  PurseListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PurseListCell.h"

@implementation PurseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MerchantsPurseModel *)model{
    
    self.change_desc.text = model.change_desc;
    self.rebatePoints.text = [NSString stringWithFormat:@"返还积分 :%@",model.pay_points];
    self.timer.text = model.change_time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
