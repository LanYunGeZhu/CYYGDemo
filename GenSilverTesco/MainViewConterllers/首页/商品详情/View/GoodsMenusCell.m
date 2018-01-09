//
//  GoodsMenusCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "GoodsMenusCell.h"

@implementation GoodsMenusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setBase_IndexPath:(NSIndexPath *)base_IndexPath{
    if (base_IndexPath.section == 1) {
        self.nameLabel.text = @"商品规格";
        if ([self getAttirString] == nil) {
            self.context.text = @"请选择规格";
        }else{
            self.context.text = [self getAttirString];
        }
        if (_model.attrs.count == 0) {
            self.context.text = @"";
        }
    }else{
        self.nameLabel.text = @"商品评价";
        self.context.text = @"";
    }
}

/** 获取 当前选择的属性 展示在cell上*/
- (NSString *)getAttirString{
    __block NSString * selectString = nil;
    [_model.attrs enumerateObjectsUsingBlock:^(Attrs * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.values enumerateObjectsUsingBlock:^(Values * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.is_select == 1) {
                if (selectString == nil) {
                    selectString = obj.label;
                }else{
                    selectString = [NSString stringWithFormat:@"%@,%@",selectString,obj.label];
                }
            }
        }];
    }];
    return selectString;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
