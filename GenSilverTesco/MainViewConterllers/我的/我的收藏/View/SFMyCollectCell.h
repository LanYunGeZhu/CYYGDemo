//
//  SFMyCollectCell.h
//  Diamond
//
//  Created by MrSong on 17/7/6.
//  Copyright © 2017年 FSShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFMyCollectModel.h"

@interface SFMyCollectCell : UITableViewCell

/*
 * 店铺图片
 */
@property (nonatomic,copy) UIImageView *shopImg ;
/*
 * 店铺名称
 */
@property (nonatomic,copy) UILabel *shopName ;
/*
 * 商品图片
 */
@property (nonatomic,copy) UIImageView *imgView ;
/*
 * 商品名
 */
@property (nonatomic,copy) UILabel *nameLab ;
/*
 * 描述
 */
@property (nonatomic,copy) UILabel *describeLab ;
/*
 * 价格
 */
@property (nonatomic,copy) UILabel *priceLab ;

/*
 * 收藏按钮
 */
@property (nonatomic,copy) UIButton *collectBtn ;

@property (nonatomic,copy) SFMyCollectModel *model ;
@property (nonatomic,copy) UILabel *line ;
@end
