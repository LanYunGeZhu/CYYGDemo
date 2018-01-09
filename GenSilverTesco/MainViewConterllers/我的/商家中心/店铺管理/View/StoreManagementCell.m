//
//  StoreManagementCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "StoreManagementCell.h"

@implementation StoreManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setViewCornerRadiusViews:@[self.makePaymentCode] floatCoriner:5];
    [self setViewCornerRadiusViews:@[self.icoImageView] floatCoriner:45.0f/2.0f];
}


- (void)setModel:(StoreManagementModel *)model{
    self.storeName.text = model.shop_name;
    self.name_phone.text= [ NSString stringWithFormat:@"%@ %@",model.linkman,model.mobile];
    [self.address setTitle:[NSString stringWithFormat:@"  %@",model.address] forState:UIControlStateNormal];
    [self.icoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.shop_img]] placeholderImage:KSPLAIMAGE];
    if ([model.status integerValue] == 2) {
        self.makePaymentCode.hidden = NO;
        self.state.hidden = YES;
    }else{
        self.makePaymentCode.hidden = YES;
        switch ([model.status integerValue]) {
            case 0:
            {
                self.state.text = @"待审核";

            }
                break;
            case 1:
            {
                self.state.text = @"待系统审核";

            }
                break;
            case 2:
            {

            }
                break;
            case 3:
            {
                self.state.text = @"已驳回";
 
            }
                break;
            default:
                break;
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
