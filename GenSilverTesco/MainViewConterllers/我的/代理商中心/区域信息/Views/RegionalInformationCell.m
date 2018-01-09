//
//  RegionalInformationCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalInformationCell.h"

@implementation RegionalInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
    
    //设定最小的长按时间 按不够这个时间不响应手势
    longPressGR.minimumPressDuration = 1;
    longPressGR.numberOfTouchesRequired = 1;
    [self.contentView addGestureRecognizer:longPressGR];
}

- (void)lpGR:(UILongPressGestureRecognizer *)lpGR{
    if (lpGR.state == UIGestureRecognizerStateBegan) {
        NSLog(@"---------------------");
        if (_longTap) {
            _longTap(lpGR.view);
        }

    }
}

/**
 
 */

- (void)setModel:(RegionalReleaseModel *)model{
    
    self.name.text = model.title;
    self.context.text = model.content;
    [self.iocImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.imgs]] placeholderImage:KSPLAIMAGE];
    self.timer.text = model.addtime;
    NSArray * statusArray = @[@"待审核",@"审核通过",@"已驳回"];
    self.state.text = statusArray[[model.status intValue]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
