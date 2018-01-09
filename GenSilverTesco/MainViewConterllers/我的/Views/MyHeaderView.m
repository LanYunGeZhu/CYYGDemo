//
//  MyHeaderView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MyHeaderView.h"

@implementation MyHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];

    [self.headerImageView.layer setCornerRadius:20.0f];
    [self.headerImageView.layer setMasksToBounds:YES];
}

- (void)hiddenMenusCustomer{
    self.menuBgView.hidden = YES;
}

@end
