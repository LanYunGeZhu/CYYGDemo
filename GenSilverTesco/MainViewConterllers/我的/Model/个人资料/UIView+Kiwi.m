//
//  UIView+Kiwi.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "UIView+Kiwi.h"
static char identifier;

@implementation UIView (Kiwi)


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


@end
