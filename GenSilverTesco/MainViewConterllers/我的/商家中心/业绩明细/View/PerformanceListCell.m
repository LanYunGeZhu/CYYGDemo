//
//  PerformanceListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PerformanceListCell.h"

@implementation PerformanceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setViewCornerRadiusViews:@[self.storImageView] floatCoriner:25.0f/2];
}

- (void)setModel:(PerformanceOfSubsidiaryModel *)model{
    self.storeName.text = model.shop_name;
    
    self.months.text = model.addtime;
    NSString *string_tprice = [NSString stringWithFormat:@"%@",model.tprice];
    NSString * tprice = [NSString stringWithFormat:@"营业额 : %@",model.tprice];
    
    self.turnover.attributedText = [KSTool setAttributedString:tprice color:[UIColor redColor] startNum:tprice.length - string_tprice.length length:string_tprice.length];
    
    NSString *string_trl = [NSString stringWithFormat:@"%@",model.trl];

    NSString *trl = [NSString stringWithFormat:@"让利额 : %@",model.trl];
    self.onTheForehead.attributedText = [KSTool setAttributedString:trl color:[UIColor redColor] startNum:trl.length - string_trl.length length:string_trl.length]
    ;
    [self.storImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.shop_img]] placeholderImage:KSPLAIMAGE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
