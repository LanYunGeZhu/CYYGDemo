//
//  MyAddressCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MyAddressCell.h"

@implementation MyAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MyAddressModel *)model{
    self.name.text=  model.consignee;
    self.phone.text = [NSString stringWithFormat:@"%@",model.mobile];
    self.address.text = [NSString stringWithFormat:@"%@%@",model.rnames,model.address];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
