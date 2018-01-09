//
//  MerchantsCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MerchantsCell.h"

@implementation MerchantsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(WInfomationModel *)model{
    NSArray *array = @[@"bz_points",@"shop_integral_weight",@"hk_points",@"get_hk_points"];
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"%.2f",[[model valueForKey:array[idx]] floatValue]] ;
        obj.text = [NSString stringWithFormat:@"%@",str == nil? @"0.00" : str];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
