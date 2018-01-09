//
//  ItemsCollectionViewCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ItemsCollectionViewCell.h"

@implementation ItemsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImagesTitleData:(id)data indexPath:(NSIndexPath *)indexPath{
    
    self.itemsImageView.image = [UIImage imageNamed:KSDIC(data, @"image")[indexPath.row]];
    self.titleLabel.text = KSDIC(data, @"title")[indexPath.row];

}

- (void)setModel:(UnionMerchantModel *)model{
    [self.itemsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL_image,model.imgs]] placeholderImage:KSPLAIMAGE];
    self.titleLabel.text = model.title;
}


@end
