//
//  RegionalMemberCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalMemberCell.h"

@implementation RegionalMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModelMember:(RegionalMemberModel *)modelMember{
    self.memberName.text = modelMember.real_name;
    self.timer.text = modelMember.reg_time;
    self.memberAccount.text = [NSString stringWithFormat:@"会员账号: %@",modelMember.user_name];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
