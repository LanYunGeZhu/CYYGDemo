//
//  OfflineListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderOfflineModel.h"
@interface OfflineListCell : KSBaseTableViewCell
/** 商品名称:*/
@property (weak, nonatomic) IBOutlet UILabel *nameOfCommodity;
/** 店铺名称:*/
@property (weak, nonatomic) IBOutlet UILabel *shopName;
/** 支付方式*/
@property (weak, nonatomic) IBOutlet UILabel *methodOfPayment;
/**商品总价 */
@property (weak, nonatomic) IBOutlet UILabel *commodityPrice;
/** 商品让利*/
@property (weak, nonatomic) IBOutlet UILabel *commodityPriceConcession;
/** 订单时间*/
@property (weak, nonatomic) IBOutlet UILabel *theOrderTime;
/** 订单状态*/
@property (weak, nonatomic) IBOutlet UILabel *theOrderStatus;

/** */
@property (strong, nonatomic) OrderOfflineModel *model;


@end
