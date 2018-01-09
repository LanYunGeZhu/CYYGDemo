//
//  ItemsCollectionViewCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnionMerchantModel.h"
@interface ItemsCollectionViewCell : UICollectionViewCell

/** */
@property (weak, nonatomic) IBOutlet UIImageView * itemsImageView;
/** */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setImagesTitleData:(id)data indexPath:(NSIndexPath *)indexPath;

/** */
@property (strong, nonatomic) UnionMerchantModel  *model;


@end
