//
//  SalesListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SalesListCell.h"

@implementation SalesListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(SalesListModel *)model{
    self.storeName.text = model.shop_name;
    self.timer.text = [KSTool setTimeFormat:[model.addtime doubleValue] *1000];
    self.name_phone.text = [NSString stringWithFormat:@"%@ %@",model.linkman,model.mobile];
    // 0待审核1待系统审核2已审核 3：已驳回
    NSArray *statusArray = @[@"待审核",@"待系统审核",@"已审核",@"已驳回"];
    self.state.text=statusArray [[model.status integerValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
