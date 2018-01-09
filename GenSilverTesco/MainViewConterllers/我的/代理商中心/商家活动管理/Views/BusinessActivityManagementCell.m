//
//  BusinessActivityManagementCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "BusinessActivityManagementCell.h"

@implementation BusinessActivityManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsFLog:(BOOL)isFLog{
    self.bgView1_layou_leading.constant = isFLog ? 44 : 16;
    self.bgView2_layou_leading.constant = isFLog ? 44 : 16;
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)setModel:(BusinessActivityManagementModel *)model{
    self.storeName.text=  model.shop_name;
    self.activitName.text = [NSString stringWithFormat:@"活动名称 : %@",model.title];
    self.activityPrice.text = [NSString stringWithFormat:@"活 动 价  : %@",model.price];
    NSString *price =model.price;
    
    self.activityPrice.attributedText = [KSTool setAttributedString:[NSString stringWithFormat:@"活 动 价  : %@",price] color:[UIColor redColor] startNum:9 length:price.length];
    
    self.theOriginalPrice.attributedText = [self setNamesLine:[NSString stringWithFormat:@"原价 : %@",model.sprice]];
    self.address.text = model.anames;
    self.cycle.text =[NSString stringWithFormat:@"活动周期 : %@-%@",model.stime,model.etime];
    //2已审核 0待审核 3已驳回 1:待系统审核
    NSArray *status=  @[@"待审核",@"待系统审核",@"已审核",@"已驳回"];
    self.state.text = status[[model.status integerValue]];
    self.selectButton.selected = model.isSelected;

   
}
- (NSMutableAttributedString *)setNamesLine:(NSString *)name{
    NSMutableAttributedString * mutableArrti = [[NSMutableAttributedString alloc]initWithString:name];
    [mutableArrti addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, name.length)];
    return mutableArrti;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
