//
//  ComplainMenusView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ComplainMenusView.h"

@implementation ComplainMenusView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.senders enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            obj.selected = YES;
        }
    }];
}

- (IBAction)base_ButtonsClick:(UIButton *)sender{
    
    if (sender.tag == 0) {
        self.layou_view_L.constant = 0;

    }else{
        self.layou_view_L.constant = 78;
    }
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];

    }];
    [self.senders enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    sender.selected = YES;
    [super base_ButtonsClick:sender];
}
@end
