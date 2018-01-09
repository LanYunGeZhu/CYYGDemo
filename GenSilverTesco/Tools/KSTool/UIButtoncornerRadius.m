//
//  UIButtoncornerRadius.m
//  BigWinner
//
//  Created by kangshibiao on 2017/2/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "UIButtoncornerRadius.h"

@implementation UIButtoncornerRadius

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
}

@end
