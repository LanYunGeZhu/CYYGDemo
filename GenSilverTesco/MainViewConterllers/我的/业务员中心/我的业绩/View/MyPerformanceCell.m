//
//  MyPerformanceCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/31.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MyPerformanceCell.h"

@implementation MyPerformanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setViewCornerRadiusViews:@[self.storeImageView] floatCoriner:25.0f/2/0.f];
}

- (void)setMy_model:(MyPerformanceModel *)my_model{
    self.storeName.text = my_model.shop_name;
    [self.storeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,my_model.shop_img]] placeholderImage:KSPLAIMAGE];
    self.nameLabel.text = [NSString stringWithFormat:@"%@：%@",my_model.linkman,my_model.mobile];
    NSString *string_tprice = [NSString stringWithFormat:@"%@",my_model.mrl_money];
    NSString * tprice = [NSString stringWithFormat:@"月让利金 : %@",string_tprice];
    
    self.monthOnGold.attributedText = [KSTool setAttributedString:tprice color:[UIColor redColor] startNum:tprice.length - string_tprice.length length:string_tprice.length];
    
    NSString *string_trl = [NSString stringWithFormat:@"%@",my_model.trl_money];
    
    NSString *trl = [NSString stringWithFormat:@"总让利金 : %@",my_model.trl_money];
    self.yearsOnGold.attributedText = [KSTool setAttributedString:trl color:[UIColor redColor] startNum:trl.length - string_trl.length length:string_trl.length]
    ;
    
    [self.arerButton setTitle:[NSString stringWithFormat:@" %@",my_model.anames] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
