//
//  GenGoodsListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//m

#import "GenGoodsListCell.h"

@implementation GenGoodsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgView.layer setCornerRadius:15.0f];
    [self.bgView.layer setMasksToBounds:YES];
}

- (void)setModel:(GenWinMallMode *)model{

    self.name.text = model.goods_name;
    self.price.text = [NSString stringWithFormat:@"￥：%@",model.shop_price];
    self.num.text = [NSString stringWithFormat:@"已有%@人购买",model.buyer_num];
    [self.icoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.goods_thumb]] placeholderImage:KSPLAIMAGE];

}

@end
