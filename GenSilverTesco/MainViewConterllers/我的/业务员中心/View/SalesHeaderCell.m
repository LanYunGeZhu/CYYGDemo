//
//  SalesHeaderCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SalesHeaderCell.h"

@implementation SalesHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self setViewCornerRadiusViews:@[self.headerIamgeView] floatCoriner:37.0f/2.0f];
}

- (void)setData:(id)data{
    [self.headerIamgeView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,KSDIC(data, @"headimg")]] placeholderImage:KSPLAIMAGE];
    self.name.text=  KSDIC(data, @"real_name");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
