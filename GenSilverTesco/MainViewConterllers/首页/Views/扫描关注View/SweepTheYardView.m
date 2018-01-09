//
//  SweepTheYardView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SweepTheYardView.h"

@implementation SweepTheYardView
- (void)awakeFromNib{
    
    [super awakeFromNib];
    [self.bgView.layer setCornerRadius:8];
    self.bgView.layer.masksToBounds = YES;
    [self.menuButton.layer setCornerRadius:8];
    [self.menuButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.menuButton.layer setBorderWidth:1];
}

- (void)base_ButtonsClick:(UIButton *)sender{
    [self baseXIB_removeSubView];
}

@end
