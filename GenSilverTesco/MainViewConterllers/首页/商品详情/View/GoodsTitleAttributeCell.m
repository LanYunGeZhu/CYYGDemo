//
//  GoodsTitleAttributeCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "GoodsTitleAttributeCell.h"

@implementation GoodsTitleAttributeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.text = @"Artka阿卡夏季女装必备款米黄修身型长袖针织外套阿卡夏季女装必备款米黄修身型长袖针织外套";
}


- (void)setData:(id)data{
    id goods = KSDIC(data, @"goods");
    self.nameLabel.text = KSDIC(goods, @"goods_name");
    self.sales.text = [NSString stringWithFormat:@"销量 %@",KSDIC(goods, @"buyer_num")];
    self.price.text = [NSString stringWithFormat:@"￥ %@",KSDIC(goods, @"shop_price")];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
