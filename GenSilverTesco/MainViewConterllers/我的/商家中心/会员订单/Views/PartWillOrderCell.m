//
//  PartWillOrderCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PartWillOrderCell.h"

@implementation PartWillOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(PartWillOrderModel *)model{
    self.store_name.text =[ NSString stringWithFormat:@"店铺名称：%@",model.shop_name];
    self.shop_name.text = [NSString stringWithFormat:@"商品名称：%@",model.goods_name];
    self.price.text = [NSString stringWithFormat:@"消费金额：%@",model.price];
    self.rl_money.text = [NSString stringWithFormat:@"让利金额：%@",model.rl_money];
    self.timer.text = model.addtime;
   
    self.payType.text = [NSString stringWithFormat:@"支付方式：%@", [model.ptype integerValue] == 1 ? @"现金支付":@"积分换购"];
    NSArray *stateArray = @[@"待审核",@"已审核" ,@"已驳回"];
    self.state.text =stateArray[[model.status integerValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
