//
//  GenGoodsListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenWinMallMode.h"
@interface GenGoodsListCell : UICollectionViewCell

/** */
@property (weak, nonatomic) IBOutlet UIView *bgView;
/** */
@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
/** */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *price;
/** */
@property (weak, nonatomic) IBOutlet UILabel *num;
/** */
@property (strong, nonatomic) GenWinMallMode  *model;


@end
