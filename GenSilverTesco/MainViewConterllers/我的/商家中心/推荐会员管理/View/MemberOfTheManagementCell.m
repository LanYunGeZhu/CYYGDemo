//
//  MemberOfTheManagementCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MemberOfTheManagementCell.h"

@implementation MemberOfTheManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MemberOfTheManagementModel *)model{
    
    self.merchantsMember.text = [NSString stringWithFormat:@"商家会员：%@",[model.isshoper integerValue] == 0 ? @"做单":@"消费"];
    self.benefit.text  = [NSString stringWithFormat:@"累计让利：%@",model.trl_money];
    self.name_phone.text=  [NSString stringWithFormat:@"%@  %@",model.real_name,model.mobile_phone];
    self.timer.text=  model.reg_time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
