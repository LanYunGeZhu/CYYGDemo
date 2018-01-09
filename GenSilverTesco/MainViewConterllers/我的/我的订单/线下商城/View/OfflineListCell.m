//
//  OfflineListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OfflineListCell.h"

@implementation OfflineListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(OrderOfflineModel *)model{
    self.nameOfCommodity.text = [NSString stringWithFormat:@"%@",model.goods_name];
    self.shopName.text = [NSString stringWithFormat:@"%@",model.shop_name];
    self.methodOfPayment.text = [model.pay_points integerValue] == 0 ? @"现金做单":@"积分做单";
    self.commodityPrice.text = model.price;
    self.commodityPriceConcession.text = model.rl_money ;
    self.theOrderTime.text = model.addtime;
    //订单状态0：待审核1审核通过2审核不通过)
    NSArray *statusArray = @[@"待审核",@"审核通过",@"审核不通过"];
    self.theOrderStatus.text = statusArray[[model.status integerValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
