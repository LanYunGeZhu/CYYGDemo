//
//  RefundsListCell.m
//  GenSilverTesco
//
//  Created by MrSong on 17/8/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RefundsListCell.h"

@implementation RefundsListCell

- (void)setModel:(RefundsListModel *)model{
    
    _model = model;
    
    self.goods_name.text = model.goods_name;
    self.goods_num.text = [NSString stringWithFormat:@"x%ld",(long)[model.back_goods_number integerValue]];
    self.goods_property.text = model.goods_attr;
    self.goods_price.text = [NSString stringWithFormat:@"￥%@",model.back_goods_price];
    [self.icoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,_model.goods_thumb]] placeholderImage:KSPLAIMAGE];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
