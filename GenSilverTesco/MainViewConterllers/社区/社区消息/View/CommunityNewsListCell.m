//
//  CommunityNewsListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "CommunityNewsListCell.h"

@implementation CommunityNewsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setViewCornerRadiusViews:@[self.redView] floatCoriner:3.0f];
}


- (void)setModel:(CommunityNewsModel *)model{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.headimg]] placeholderImage:KSPLAIMAGE];
    self.context.text = model.content;
    self.nickName.text = model.alias;
    self.timer.text = [KSTool dateTransformString:[model.addtime doubleValue] ];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
