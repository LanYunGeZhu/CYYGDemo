//
//  RegionalOrderApprovalCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalOrderApprovalCell.h"

@implementation RegionalOrderApprovalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsFlog:(BOOL)isFlog{
    _isFlog = isFlog;
//    self.layou_view_l_1.constant = isFlog ? 32 : 0;
//    self.selectButton.hidden = !isFlog;
//    [UIView animateWithDuration:.3 animations:^{
//        [self layoutIfNeeded];
//    }];
}

- (void)setModel:(RegionalOrderApprovaModel *)model{
    self.storeName.text = model.shop_name;
    self.contactPhoneNumber.text = [NSString stringWithFormat:@"联系电话 : %@",model.mobile];
    self.memberAccount.text = [NSString stringWithFormat:@"会员账号 : %@",model.pay_user_name];
    NSString *consumptionAmount = [NSString stringWithFormat:@"消费金额 :￥ %@",model.price];
    NSString *amountOfBenefit = [NSString stringWithFormat:@"让利金额 :￥ %@",model.rl_money];

    self.consumptionAmount.attributedText = [KSTool setAttributedString:consumptionAmount color:[UIColor redColor] startNum:8 length:model.price.length];
    self.amountOfBenefit.attributedText = [KSTool setAttributedString:amountOfBenefit color:[UIColor redColor] startNum:8 length:model.rl_money.length];
    self.timer.text = model.add_time;
    self.methodOfPayment.text = [_model.pay_points integerValue] == 0 ? @"现金做单":@"积分做单";
    NSArray *statusArray = @[@"待审核",@"审核通过",@"审核不通过"];
    self.state.text = statusArray[[model.status integerValue]];
    self.selectButton.selected = model.isSelected;
    if (self.isFlog) {
        self.layou_view_l_1.constant =  32 ;
        self.selectButton.hidden = NO;
    }else{
        self.layou_view_l_1.constant =0;
        self.selectButton.hidden = YES;
    }


  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
