//
//  IntegralCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "IntegralCell.h"

@implementation IntegralCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(WInfomationModel *)model{
    NSArray *array = @[@"pay_points",@"rl_money",@"user_integral_weight"];
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *text  = [NSString stringWithFormat:@"%.2f",[[model valueForKey:array[idx]] floatValue]] ;
        obj.text = [NSString stringWithFormat:@"%@",text ==nil? @"0.00":text];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
