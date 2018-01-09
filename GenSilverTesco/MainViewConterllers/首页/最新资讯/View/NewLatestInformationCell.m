//
//  NewLatestInformationCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "NewLatestInformationCell.h"

@implementation NewLatestInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NewLatestModel *)model{
    self.name.text = model.title;
    self.timer.text = model.addtime;
    if (_newLatesType == 2) {
         self.context.text = @"";
    }else{
        self.context.text = model.content;

    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
