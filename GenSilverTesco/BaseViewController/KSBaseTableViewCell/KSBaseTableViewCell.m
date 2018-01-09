//
//  KSBaseTableViewCell.m
//  FrameWork
//
//  Created by kangshibiao on 16/8/15.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseTableViewCell.h"

@implementation KSBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layer.masksToBounds = YES;
}

/** 设置圆角*/
- (void)setViewCornerRadiusViews:(NSArray <UIView *>*)view floatCoriner:(float)floatCoriner;
{
    [view enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.cornerRadius = floatCoriner;
        obj.layer.masksToBounds = YES;
    }];
}

- (void)viewHidden:(NSArray <UIView *>*)view{
    [self showAndHiddenViews:view isFlog:YES];
}

- (void)viewShow:(NSArray <UIView *>*)view{
    [self showAndHiddenViews:view isFlog:NO];
}

- (void)showAndHiddenViews:(NSArray <UIView *>*)view isFlog:(BOOL)isFlog{
    [view enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = isFlog;
    }];
}

- (IBAction)baseCell_buttonClikc:(UIButton *)sender{
    if (_baseCell_buttonIndex) {
        _baseCell_buttonIndex(sender.tag);
    }
}

@end
