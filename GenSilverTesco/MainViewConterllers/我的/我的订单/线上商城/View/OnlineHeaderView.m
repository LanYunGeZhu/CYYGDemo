//
//  OnlineHeaderView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OnlineHeaderView.h"

@implementation OnlineHeaderView

- (void)setModel:(OrderOnlineModel *)model{
    _model = model;
    WeakSelf;
//     [OrderOnlineModel getOrderStatusPay_status:[model.pay_status integerValue] shipping_status:[model.shipping_status integerValue] order_status:[_model.order_status integerValue] order_statusStringIndex:^(NSString *orderString, NSInteger index) {
//     }];
    if (model.order_status.integerValue == 2 || model.order_status.integerValue ==3) {
        self.base_button.hidden = YES;
    }else{
        self.base_button.hidden = NO;

    }
    [OrderOnlineModel getOrderStatusOrder_status:[model.order_status integerValue] order_statusStringIndex:^(NSString *orderString) {
        weakSelf.orderStatus.text = orderString;

    }];
}

@end
