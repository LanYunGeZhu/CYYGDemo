//
//  ShopForListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ShopForListCell.h"

@implementation ShopForListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data{
    id titleData = data[self.base_IndexPath.row];
    self.nameLabel.text = KSDIC(titleData, @"title");
    self.contextLabel.text = KSDIC(titleData, @"context");
    self.contextLabel.textAlignment = self.base_IndexPath.row == 4 ? NSTextAlignmentLeft : NSTextAlignmentRight;
    if (self.base_IndexPath.row ==1) {
        self.layou_context_trailing.constant = 35;
        self.icoImageView.hidden = NO;
        self.icoImageView.image = [UIImage imageNamed:@"电话"];

    }else if (self.base_IndexPath.row == 4){
        self.layou_context_trailing.constant = 76;
        self.icoImageView.hidden = NO;
        self.icoImageView.image = [UIImage imageNamed:@"去这里"];
    }
    else{
        self.layou_context_trailing.constant = 15;
        self.icoImageView.hidden = YES;

    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
