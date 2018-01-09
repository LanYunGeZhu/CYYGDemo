//
//  GoodsCollectionViewCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "GoodsCollectionViewCell.h"

@implementation GoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = self.bottomView.bounds;
    layer.path = maskPath.CGPath;
    self.bottomView.layer.mask = layer;
}

- (void)setModel:(HomeLsitModel *)model{
    self.shopName.text = model.shop_name;
    [self.icoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.shop_img]] placeholderImage:KSPLAIMAGE];
    [self.address setTitle:[NSString stringWithFormat:@"  %@",model.anames] forState:UIControlStateNormal];
}

@end
