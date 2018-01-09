//
//  RefundsInfoCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RefundsInfoCell.h"
#import "UIView+SDAutoLayout.h"


@implementation RefundsInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    _describeLab = [UILabel new];
    _describeLab.font = [UIFont systemFontOfSize:14];
    
    [self.contentView sd_addSubviews:@[_describeLab]];
    
    _describeLab.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
    
    [_describeLab setMaxNumberOfLinesToShow:0];
    
    [self setupAutoHeightWithBottomView:_describeLab bottomMargin:10];
    
    
    
}

- (void)setModel:(RefundsListModel *)model{
    
    _model = model;

    _describeLab.text = [NSString stringWithFormat:@"退款原因:%@",model.describe] ;;
    
    
}


@end
