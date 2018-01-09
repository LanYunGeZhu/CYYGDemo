//
//  OnlineFooterView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OnlineFooterView.h"

@implementation OnlineFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setViewCornerRadiusViews:@[self.base_button] floatCoriner:4];
}

- (void)setModel:(OrderOnlineModel *)model{
    _model = model;
    self.numLable.text = [NSString stringWithFormat:@"共%ld件商品  合计：",(long)[self getGoodsNum]];
    self.price.text = [NSString stringWithFormat:@"￥%@",_model.order_amount];
    NSArray *buttonsArray = @[@"去付款",@"联系卖家",@"确认收货",@"立即评价",@"再次购买",@"再次购买",@"再次购买"];
//    [OrderOnlineModel getOrderStatusOrder_status:[_model.order_status integerValue] order_statusStringIndex:^(NSString *orderString) {
        [self.base_button setTitle:buttonsArray[[_model.order_status integerValue]] forState:UIControlStateNormal];
//    }]  ;

    if ([[self.base_button titleForState:UIControlStateNormal] isEqualToString:@"联系卖家"]) {
        self.base_button.hidden = YES;
    }else{
        self.base_button.hidden = NO;
    }
}

- (NSInteger )getGoodsNum{
    __block NSInteger num = 0;
    [_model.goods enumerateObjectsUsingBlock:^(OrderOnlineGoods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        num = num + [obj.goods_number integerValue];
    }];
    return num;
}

@end
