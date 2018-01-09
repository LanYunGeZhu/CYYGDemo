//
//  RegionalListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/1.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalListCell.h"

@implementation RegionalListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(RecommendedModel *)model{
 
    self.theAgentNumber.text = [NSString stringWithFormat:@"代理编号：%@",model.user_id];
    self.theAgentInformation.text = [NSString stringWithFormat:@"代理信息：%@",model.real_name];
    self.agentTelephone.text = [NSString stringWithFormat:@"代理电话：%@",model.mobile_phone];

    NSString *stringMrl_monet = [NSString stringWithFormat:@"%@",model.mrl_money];
    NSString *mrl_money = [NSString stringWithFormat:@"本月让利：%@",stringMrl_monet];
    
    self.thisMonthOn.attributedText = [KSTool setAttributedString:mrl_money color:[UIColor redColor] startNum:mrl_money.length - stringMrl_monet.length length:stringMrl_monet.length] ;
    NSString *totalrl = [NSString stringWithFormat:@"总让利额：%@",model.totalrl];
    
    self.theTotalBenefit.attributedText =[KSTool setAttributedString:totalrl color:[UIColor redColor] startNum:totalrl.length - model.totalrl.length length:model.totalrl.length] ;

     [self.address setTitle:[NSString stringWithFormat:@"  %@",model.anames] forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
