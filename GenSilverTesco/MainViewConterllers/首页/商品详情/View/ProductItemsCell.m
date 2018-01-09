//
//  ProductItemsCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ProductItemsCell.h"

@implementation ProductItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView.layer setCornerRadius:6];
    [self.contentView.layer setMasksToBounds:YES];
}

@end
