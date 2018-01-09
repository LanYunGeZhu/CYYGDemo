//
//  OrderOnlineListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OrderOnlineListCell.h"

@implementation OrderOnlineListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(OrderOnlineGoods *)model{
    self.goods_name.text = model.goods_name;
    self.goods_num.text = [NSString stringWithFormat:@"x%ld",(long)[model.goods_number integerValue]];
//    self.goods_property.text = model.goods_attr;
    self.goods_property.text = [model.goods_attr stringByReplacingOccurrencesOfString: @"\n" withString: @""];

    self.goods_price.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    [self.icoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.goods_thumb]] placeholderImage:KSPLAIMAGE];
//    NSLog(@"----%@",[NSString stringWithFormat:@"%@%@",URL_MANURL,_model.goods_thumb]);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
