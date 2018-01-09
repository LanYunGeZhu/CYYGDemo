//
//  SupportListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SupportListCell.h"

@implementation SupportListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SupportListModel *)model{
    self.agentName.text = [NSString stringWithFormat:@"代理账号 : %@",model.user_name];
    self.name.text = [NSString stringWithFormat:@"联系姓名 : %@",model.real_name];
    self.timer.text =  model.agenttime;
    [self.area setTitle:[NSString stringWithFormat:@"  %@",model.anames] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
