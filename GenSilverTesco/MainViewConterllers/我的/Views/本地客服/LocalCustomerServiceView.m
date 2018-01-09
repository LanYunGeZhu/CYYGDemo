//
//  LocalCustomerServiceView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "LocalCustomerServiceView.h"

@implementation LocalCustomerServiceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setViewCornerRadiusViews:@[self.bgView,self.base_button] floatCoriner:5];
}

- (void)base_ButtonsClick:(UIButton *)sender{
    
    [self baseXIB_removeSubView];
}

@end
