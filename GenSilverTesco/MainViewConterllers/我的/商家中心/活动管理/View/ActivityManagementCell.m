//
//  ActivityManagementCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ActivityManagementCell.h"

@implementation ActivityManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ActivityManagementModel *)model{
    self.name.text = model.title;
    self.theOriginalPrice.text = [NSString stringWithFormat:@"商品原价:%@",model.sprice];
    self.serialNumber.text = [NSString stringWithFormat:@"编号:%@",model.actsn];
    self.star_end_timer.text = [NSString stringWithFormat:@"%@-%@",model.stime,model.etime];
    [self.picture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.imgs]] placeholderImage:KSPLAIMAGE];
    NSArray *array = @[@"审核中",@"审核中",@"活动中",@"已驳回"];
    self.state.text = array[[model.status integerValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
