//
//  ProductEvaluationListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ProductEvaluationListCell.h"

@implementation ProductEvaluationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setViewCornerRadiusViews:@[self.headerImageView] floatCoriner:18.0f];
}

- (void)setModel:(ProductEvaluationModel *)model{
    self.nickName.text = [NSString stringWithFormat:@"%@",model.user_name];
    self.context.text = model.content;
    self.timer.text = [KSTool setTimeFormat:[model.add_time doubleValue]*1000];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.headimg]] placeholderImage:KSPLAIMAGE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
