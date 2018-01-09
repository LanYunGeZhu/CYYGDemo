//
//  WPayView.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WPayView.h"

@implementation WPayView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.Pay.layer setCornerRadius:5];
    [self.Pay.layer setMasksToBounds:YES];
}


@end
