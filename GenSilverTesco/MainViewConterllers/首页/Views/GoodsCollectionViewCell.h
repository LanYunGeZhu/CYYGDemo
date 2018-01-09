//
//  GoodsCollectionViewCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeLsitModel.h"

@interface GoodsCollectionViewCell : UICollectionViewCell

/** */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

/** */
@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
/** */
@property (weak, nonatomic) IBOutlet UILabel *shopName;
/** */
@property (weak, nonatomic) IBOutlet UIButton *address;

/** 首页商家 */
@property (strong, nonatomic) HomeLsitModel *model;


@end
