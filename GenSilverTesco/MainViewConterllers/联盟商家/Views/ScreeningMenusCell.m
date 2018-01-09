//
//  ScreeningMenusCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ScreeningMenusCell.h"

@implementation ScreeningMenusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.menusButton enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (Screen_wide == 320) {
            [obj setImageEdgeInsets:UIEdgeInsetsMake(0, 78, 0, 0)];
        }else if (Screen_wide == 375){
            [obj setImageEdgeInsets:UIEdgeInsetsMake(0, 90, 0, 0)];
        }
        else {
            [obj setImageEdgeInsets:UIEdgeInsetsMake(0, 96, 0, 0)];
        }
    }];
    
}

@end
