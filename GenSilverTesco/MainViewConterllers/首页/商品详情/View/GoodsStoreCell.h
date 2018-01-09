//
//  GoodsStoreCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"
@interface GoodsStoreCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *sotreName;
/** */
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
/** */
@property (weak, nonatomic) IBOutlet UIButton *contactTheMerchant;

/** */
@property (strong, nonatomic) GoodsDetailsModel *model;


@end
