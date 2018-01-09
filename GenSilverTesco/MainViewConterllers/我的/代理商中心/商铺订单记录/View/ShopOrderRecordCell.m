//
//  ShopOrderRecordCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/16.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ShopOrderRecordCell.h"

@implementation ShopOrderRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ShopOrderRecordModel *)model{
    
    self.storeName.text = [NSString stringWithFormat:@"商家姓名：%@",model.linkman];
    self.memberAccount.text = [NSString stringWithFormat:@"会员账号：%@",model.pay_user_name];

    self.orderId.text = [NSString stringWithFormat:@"订单编号：%@",model.orderid];
    
    NSString *stringMrl_monet = [NSString stringWithFormat:@"%@",model.price];
    NSString *mrl_money = [NSString stringWithFormat:@"消费金额：%@",stringMrl_monet];
    
    self.consumptionAmount.attributedText = [KSTool setAttributedString:mrl_money color:[UIColor redColor] startNum:mrl_money.length - stringMrl_monet.length length:stringMrl_monet.length] ;
    
    NSString *stringTotalrl = [NSString stringWithFormat:@"%@",model.rl_money];;
    NSString *totalrl = [NSString stringWithFormat:@"让利金额：%@",stringTotalrl];
    
    self.amountOfBenefit.attributedText =[KSTool setAttributedString:totalrl color:[UIColor redColor] startNum:totalrl.length - stringTotalrl.length length:stringTotalrl.length] ;
    self.timer.text = model.add_time;
    NSArray * array = @[@"待审核",@"审核通过",@"审核不通过"];
    self.state.text = array[[model.status integerValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
