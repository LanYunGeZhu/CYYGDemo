//
//  MyOrderCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setViewCornerRadiusViews:self.numBgView floatCoriner:8];
    [self.numBgView enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.layer setCornerRadius:8];
        [obj.layer setBorderColor:[UIColor redColor].CGColor];
        [obj.layer setBorderWidth:1];
    }];
}


- (void)setData:(id)data{
    NSArray *array = @[@"unpay",@"unship",@"unshipped",@"uncomment"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lable = self.numLabel[idx];
        lable.text = [NSString stringWithFormat:@"%@",KSDIC(data, obj)];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
