//
//  ShoppingCartCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ShoppingCartCell.h"

@implementation ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.textField.layer.borderColor = [UIColor  blackColor].CGColor;
//    self.textField.layer.borderWidth = 1;
}


- (void)setModel:(ShoppingCartModel *)model{
    [self.icoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.goods_thumb]] placeholderImage:KSPLAIMAGE];
    self.name.text = model.goods_name;
    self.price.text = [NSString stringWithFormat:@"￥ %@",model.goods_price];
    self.attribute.text = [model.goods_attr stringByReplacingOccurrencesOfString: @"\n" withString: @""];
//    NSLog(@"---%@",[model.goods_attr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]]);
    self.textField.text = model.goods_number;
    self.selectButton.selected = model.isChoose;
 
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
