//
//  SFMyCollectCell.m
//  Diamond
//
//  Created by MrSong on 17/7/6.
//  Copyright © 2017年 FSShao. All rights reserved.
//

#import "SFMyCollectCell.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+EMWebCache.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@implementation SFMyCollectCell

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
    
    _shopImg = [UIImageView new];
    
    _shopName = [UILabel new];
    _shopName.font = [UIFont systemFontOfSize:14];
    
    _collectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_collectBtn setImage:[UIImage imageNamed:@"orderDelete"] forState:(UIControlStateNormal)];
    
    _line = [UILabel new];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _nameLab = [UILabel new];
    _nameLab.font = [UIFont systemFontOfSize:14];
    
    _imgView = [UIImageView new];
    _imgView.backgroundColor = [UIColor blueColor];
    
    _describeLab = [UILabel new];
    _describeLab.font = [UIFont systemFontOfSize:11];
    _describeLab.textColor = [UIColor lightGrayColor];
    
    _priceLab = [UILabel new];
    _priceLab.font = [UIFont systemFontOfSize:14];
    _priceLab.textColor = RGB(224, 26, 40);

    
    [self.contentView sd_addSubviews:@[_collectBtn,_nameLab,_imgView,_priceLab]];
    
//    _shopImg.sd_layout
//    .topSpaceToView(self.contentView,10)
//    .leftSpaceToView(self.contentView,15)
//    .widthIs(25)
//    .heightIs(25);
//    [_shopImg setSd_cornerRadiusFromHeightRatio:@0.5];
//    
//    _collectBtn.sd_layout
//    .widthIs(20)
//    .heightIs(20)
//    .centerYEqualToView(_shopImg)
//    .rightSpaceToView(self.contentView,14);
//
//    _shopName.sd_layout
//    .centerYEqualToView(_shopImg)
//    .leftSpaceToView(_shopImg,11)
//    .heightIs(20)
//    .rightSpaceToView(_collectBtn,14);
    
//    _line.sd_layout
//    .leftSpaceToView(self.contentView,0)
//    .rightSpaceToView(self.contentView,0)
//    .topSpaceToView(_shopImg,10)
//    .heightIs(1);
    
    _imgView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .heightIs(70)
    .widthIs(70);
    
    _nameLab.sd_layout
    .leftSpaceToView(_imgView,10)
    .topEqualToView(_imgView)
    .rightSpaceToView(self.contentView,10)
    .heightIs(36);
    _nameLab.numberOfLines = 2;
    
//    _describeLab.sd_layout
//    .leftSpaceToView(_imgView,10)
//    .topSpaceToView(_nameLab,5)
//    .rightSpaceToView(self.contentView,10)
//    .heightIs(16);
    
    _priceLab.sd_layout
    .leftEqualToView(_nameLab)
    .bottomEqualToView(_imgView)
    .heightIs(20)
    .widthIs(100);
    
    _collectBtn.sd_layout
    .widthIs(20)
    .heightIs(20)
    .centerYEqualToView(_priceLab)
    .rightSpaceToView(self.contentView,14);

    [self setupAutoHeightWithBottomView:_imgView bottomMargin:8];
    
    
    
}

- (void)setModel:(SFMyCollectModel *)model{
    
    _model = model;
    
    _shopName.text = model.shopName;
    _nameLab.text = model.name;
//    _describeLab.text = model.describe;
    _priceLab.text = [NSString stringWithFormat:@"¥ %@",model.price];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.imgView]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
    
}



@end
