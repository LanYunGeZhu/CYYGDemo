//
//  SFMyAppraiseCell.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SFMyAppraiseCell.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+EMWebCache.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@implementation SFMyAppraiseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUi];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
- (void)addUi{
    
    _starView = [[TggStarEvaluationView alloc]init];
    _starView.backgroundColor = [UIColor clearColor];
    
    _timeLab = [UILabel new];
    _timeLab.font =[UIFont systemFontOfSize:11];
    _timeLab.textAlignment = NSTextAlignmentRight;
    _timeLab.textColor = [UIColor lightGrayColor];
    
//    _titleLab = [UILabel new];
//    _titleLab.font =[UIFont systemFontOfSize:14];
    
    _contentLab = [UILabel new];
    _contentLab.font =[UIFont systemFontOfSize:14];

    _backView = [UIView new];
    _backView.backgroundColor = RGB(241, 241, 241);
    
    _imgView = [UIImageView new];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.backgroundColor = [UIColor blueColor];
    
    _shopName = [UILabel new];
    _shopName.font =[UIFont systemFontOfSize:12];
    
    _describe = [UILabel new];
    _describe.font =[UIFont systemFontOfSize:11];
    _describe.textColor = [UIColor grayColor];
    
    _price = [UILabel new];
    _price.font =[UIFont systemFontOfSize:11];
    _price.textColor = RGB(224, 26, 40);
    
    
    [self.contentView sd_addSubviews:@[_timeLab,_contentLab,_backView,_imgView,_shopName,_price,_starView]];
    
    
    _contentLab.sd_layout
    .rightSpaceToView(self.contentView,14)
    .leftSpaceToView(self.contentView,14)
    .topSpaceToView(self.contentView,13)
    .autoHeightRatio(0);
    
    _backView.sd_layout
    .topSpaceToView(_contentLab,11)
    .rightEqualToView(_contentLab)
    .leftEqualToView(_contentLab)
    .heightIs(60);
    
    _imgView.sd_layout
    .topEqualToView(_backView)
    .leftEqualToView(_backView)
    .widthIs(60)
    .heightIs(60);
    
    _shopName.sd_layout
    .topEqualToView(_imgView)
    .leftSpaceToView(_imgView,7)
    .rightEqualToView(_backView)
    .heightIs(36);
    [_shopName setNumberOfLines:0];
    
//    _describe.sd_layout
//    .topSpaceToView(_shopName,0)
//    .leftEqualToView(_shopName)
//    .rightEqualToView(_shopName)
//    .heightIs(16);
    
    _price.sd_layout
    .topSpaceToView(_shopName,0)
    .leftEqualToView(_shopName)
    .rightEqualToView(_shopName)
    .heightIs(20);
    
    _starView.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_price)
    .heightIs(13)
    .widthIs(100);
    
    _timeLab.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(_backView,8)
    .heightIs(16)
    .widthIs(100);
    
    
    [self setupAutoHeightWithBottomView:_timeLab bottomMargin:10];
    
}
- (void)setModel:(SFMyAppraiseModel *)model{
    
    _model = model;
    
    
    self.timeLab.text = model.timeLab;
    self.contentLab.text = model.contentLab;
    self.describe.text = model.describe;
    self.price.text = [NSString stringWithFormat:@"¥ %@",model.price];
    self.shopName.text = model.shopName;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.imgView]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
    //设置选中星星数量
    _starView.starCount = [model.comment_rank integerValue];

}


@end
