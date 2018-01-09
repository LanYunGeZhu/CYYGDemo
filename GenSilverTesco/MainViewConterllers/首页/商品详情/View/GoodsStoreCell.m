//
//  GoodsStoreCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "GoodsStoreCell.h"

@implementation GoodsStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setViewCornerRadiusViews:@[self.storeImageView] floatCoriner:16.0f];
}

- (void)setModel:(GoodsDetailsModel *)model{
    self.sotreName.text = model.supplier.supplier_name;
    [self.storeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.supplier.headimg]] placeholderImage:[UIImage imageNamed:@"180"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
