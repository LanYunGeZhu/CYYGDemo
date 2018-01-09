//
//  CommentsListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "CommentsListCell.h"

@implementation CommentsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(CommentsListModel *)model{
    
    Replys *replysModel = model.replys[self.base_IndexPath.row];
    if ([replysModel.user_id isEqualToString:[UserInfoManager sharedManager].user_id]) {
        self.context.attributedText  = [KSTool setAttributedString:[NSString stringWithFormat:@"楼主 回复 : %@",replysModel.content] color:[UIColor redColor] startNum:0 length:2];
    }else{
        self.context.attributedText  = [KSTool setAttributedString:[NSString stringWithFormat:@"%@ 回复 : %@",model.alias,replysModel.content] color:[UIColor redColor] startNum:0 length:model.alias.length];

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
