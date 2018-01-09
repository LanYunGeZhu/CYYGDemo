//
//  IntegralManagementCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "IntegralManagementCell.h"

@implementation IntegralManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(PartWillOrderModel *)model{
    self.phoneName.text = [NSString stringWithFormat:@"会员：%@",model.pay_user_name];
    [super setModel:model];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
