//
//  SalesManagementCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SalesManagementCell.h"

@implementation SalesManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SalesManagementModel *)model{
    [self.area setTitle:[NSString stringWithFormat:@"  %@",model.anames] forState:UIControlStateNormal];
    self.real_name.text =  [NSString stringWithFormat:@"业务员：%@",model.real_name];
    self.mobile_phone.text =  [NSString stringWithFormat:@"电话号码 : %@",model.mobile_phone];
    self.nums.text =  [NSString stringWithFormat:@"推荐商家：%@",model.nums];
    self.yjbl.text =  [NSString stringWithFormat:@"佣金比例：%.0f%%",[model.yjbl doubleValue] *100];
    
    self.dyrl.text =  [NSString stringWithFormat:@"本月业绩：%@",model.dyrl];
    self.zrl.text  =  [NSString stringWithFormat:@"总共业绩：%@",model.zrl];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
