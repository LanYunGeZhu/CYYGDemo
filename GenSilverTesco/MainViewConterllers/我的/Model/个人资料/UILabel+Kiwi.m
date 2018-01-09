//
//  UILabel+Kiwi.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "UILabel+Kiwi.h"

static char identifier;

@implementation UILabel (Kiwi)

- (void)addCallBack:(CallBack)block
{

    self.userInteractionEnabled = YES;
    
    objc_setAssociatedObject(self, &identifier, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    [self addGestureRecognizer:tap];
    
}



- (void)tap:(UITapGestureRecognizer *)tapGeture
{
    CallBack action = objc_getAssociatedObject(self, &identifier);
    if (action) {
        action(self);
    }
}

// 提现金额设置
- (UILabel *)WSetMutibleColorWith:(NSString *)sourceLa
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:sourceLa];
    
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:sourceLa].location+3, [[noteStr string] rangeOfString:sourceLa].length-3);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    //设置颜色
    [self setAttributedText:noteStr];
    
    return self;

}

// 支付金额设置
- (UILabel *)WSetMutibleColorWithPay:(NSString *)sourceLa
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:sourceLa];
    
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:sourceLa].location+5, [[noteStr string] rangeOfString:sourceLa].length-5);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    //设置颜色
    [self setAttributedText:noteStr];
    
    return self;
    
}

@end
