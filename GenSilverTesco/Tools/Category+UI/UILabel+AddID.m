//
//  UILabel+AddID.m
//  BigWinner
//
//  Created by kangshibiao on 2017/6/1.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "UILabel+AddID.h"

@implementation UILabel (AddID)

static char lableAddid;

- (void)setId:(NSInteger)Id{
    objc_setAssociatedObject(self, &lableAddid, @(Id), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)Id{
    return [objc_getAssociatedObject(self, &lableAddid) integerValue];
}

@end
