//
//  PostHeaderView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PostHeaderView.h"

@implementation PostHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setViewCornerRadiusViews:@[self.headerImageView] floatCoriner:18.0f];
    [self setViewCornerRadiusViews:@[self.isOriginalPoster] floatCoriner:5.0f];
}

- (void)setModel:(CommentsListModel *)model{
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.headimg]] placeholderImage:KSPLAIMAGE];
    self.name.text = model.alias;
    self.timer.text = [KSTool dateTransformString:[model.addtime doubleValue] ];
    [self.praise setTitle:[NSString stringWithFormat:@"  点赞(%@)",model.goods] forState:UIControlStateNormal];
    self.context.text = model.content;
    self.praise.selected = [model.hasgoods boolValue];
    if ([self.user_id isEqualToString:model.user_id]) {
        self.isOriginalPoster.hidden = NO;
    }else{
        self.isOriginalPoster.hidden = YES;
    }
}
@end
