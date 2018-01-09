//
//  PriceListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PriceListCell.h"

@implementation PriceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.mensBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.mensBtn.layer setBorderWidth:1];
    [self.mensBtn.layer setCornerRadius:6];
}

- (void)setIsShowTitle:(BOOL)isShowTitle{
    if (isShowTitle) {
        self.centerContext.hidden = YES;
        self.mensBtn.hidden = YES;
    }else{
        self.contextLabel.hidden  = YES;
        if (self.base_IndexPath.row == 0) {
            self.mensBtn.hidden = NO;
        }else{
            self.mensBtn.hidden =  YES;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
