//
//  LYMyPurseCell.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "LYMyPurseCell.h"

@implementation LYMyPurseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(LYMyPurseModel *)model{
    _model = model;
    
    self.title.text = model.title ;
    self.time.text = model.time ;
    self.getCode.text = [NSString stringWithFormat:@"已赠%@",model.getCode] ;
    
}

@end
