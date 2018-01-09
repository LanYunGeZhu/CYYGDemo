//
//  GenWinMenusCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "GenWinMenusCell.h"

@implementation GenWinMenusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.menusButton enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (Screen_wide == 320) {
            [obj setImageEdgeInsets:UIEdgeInsetsMake(0, 110, 0, 0)];
        }else if (Screen_wide == 375){
            [obj setImageEdgeInsets:UIEdgeInsetsMake(0, 126, 0, 0)];
        }
        else {
            [obj setImageEdgeInsets:UIEdgeInsetsMake(0, 142, 0, 0)];
        }
    }];
}

- (IBAction)mensClick:(UIButton *)sender{
    if (_menuClickBlock) {
        _menuClickBlock(sender.tag);
    }
    [self setSelectMenusButton:sender.tag];
}

- (void)setSelectMenusButton:(NSInteger)index{
    [self.menusButton enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index == idx) {
            obj.selected = YES;
        }else{
            obj.selected = NO;
        }
    }];
}

- (void)setModel1:(MenuListModel *)model1{
    _model1 = model1;
    if (_model1) {
        UIButton *button = self.menusButton[0];
        [button setTitle:_model1.title forState:UIControlStateNormal];
    }
}

- (void)setModel2:(MenuListModel *)model2{
    _model2 = model2;
    if (_model2) {
        UIButton *button = self.menusButton[1];
        [button setTitle:_model2.title forState:UIControlStateNormal];
    }
}

@end
