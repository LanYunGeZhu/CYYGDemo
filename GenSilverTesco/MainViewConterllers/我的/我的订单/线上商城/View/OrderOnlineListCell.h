//
//  OrderOnlineListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderOnlineModel.h"
@interface OrderOnlineListCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
/** */
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
/** */
@property (weak, nonatomic) IBOutlet UILabel *goods_num;
/** */
@property (weak, nonatomic) IBOutlet UILabel *goods_property;
/** */
@property (strong, nonatomic) OrderOnlineGoods *model;


@end
