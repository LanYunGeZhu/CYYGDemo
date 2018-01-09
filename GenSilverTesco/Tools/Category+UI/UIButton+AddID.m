//
//  UIButton+AddID.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/15.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "UIButton+AddID.h"
static char buttonAddid;

@implementation UIButton (AddID)

- (void)setId:(NSInteger)Id{
    objc_setAssociatedObject(self, &buttonAddid, @(Id), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)Id{
    return [objc_getAssociatedObject(self, &buttonAddid) integerValue];
}
@end
