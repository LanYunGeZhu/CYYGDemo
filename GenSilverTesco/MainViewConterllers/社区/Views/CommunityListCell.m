//
//  CommunityListCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "CommunityListCell.h"
#import <UIButton+WebCache.h>
@implementation CommunityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCommunityModel:(CommunityModel *)communityModel{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,communityModel.headimg]] placeholderImage:KSPLAIMAGE];
    self.context.text = communityModel.content;
    self.nickName.text = communityModel.alias;
    
    self.timer.text = [KSTool dateTransformString:[communityModel.addtime doubleValue] ];
    self.praise.selected = [communityModel.hasgoods boolValue];
    self.comments.text = [NSString stringWithFormat:@"评论（%@）",communityModel.replys];
    NSArray *array = [self componentsSeparatedByString:communityModel.imgs];
    if (array.count > 0) {
        self.imageView_button2.hidden =  array.count ==1 ? YES : NO;
         self.layou_text_bottom.constant = 90;
        self.iamgeView_bgVIew.hidden = NO;
    }else{
        self.layou_text_bottom.constant = 40;
        self.iamgeView_bgVIew.hidden = YES;


    }
    self.imageView_button1.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView_button1.imageView.layer.masksToBounds = YES;
    self.imageView_button2.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView_button2.imageView.layer.masksToBounds = YES;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [self.imageView_button1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,obj]] forState:UIControlStateNormal];
        }else{
            [self.imageView_button2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,obj]] forState:UIControlStateNormal];

        }
    }];
}

- (NSArray *)componentsSeparatedByString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return @[];
    }
    return [string componentsSeparatedByString:@"|"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
