//
//  TenantsReviewCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "TenantsReviewCell.h"

@implementation TenantsReviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TenantsReviewModel *)model{
    self.shop_name.text =[NSString stringWithFormat:@"%@", model.shop_name];
    self.linkman.text= [ NSString stringWithFormat:@"联系信息 : %@",model.linkman];
    self.mobile.text = [NSString stringWithFormat:@"电话号码 : %@",model.mobile];
    self.parent_user.text = [NSString stringWithFormat:@"业务员    : %@",model.parent_user];
    self.address.text =[NSString stringWithFormat:@"店铺地址 : %@",model.anames];
//    self.status.text =
    NSArray *status = @[@"待审核",@"待系统审核",@"已审核",@"已驳回"];
    self.status.text= status[[model.status intValue]];
    self.selectButton.selected = model.isSelected;
    if (self.isFlog) {
        self.layou_view_l_1.constant =  32 ;
        self.selectButton.hidden = NO;
    }else{
        self.layou_view_l_1.constant =0;
        self.selectButton.hidden = YES;
    }


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
