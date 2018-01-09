//
//  ManagePointsCell.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ManagePointsCell.h"

@implementation ManagePointsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ManagePointsModel *)model{
    
    _model = model;
    
    self.nameLab.text = model.name ;
    self.statusLab.text = model.status ;
    self.priceLab.text = model.price ;
    self.profitsLab.text = model.profits ;
    self.timeLab.text = model.time ;
    
}

@end
