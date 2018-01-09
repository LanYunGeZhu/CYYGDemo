//
//  ShopOrderRecordCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/16.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopOrderRecordModel.h"
@interface ShopOrderRecordCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/** 会员账号*/
@property (weak, nonatomic) IBOutlet UILabel *memberAccount;
/** */
@property (weak, nonatomic) IBOutlet UILabel *orderId;
/**  消费金额*/
@property (weak, nonatomic) IBOutlet UILabel *consumptionAmount;
/**让利金额 */
@property (weak, nonatomic) IBOutlet UILabel *amountOfBenefit;
/** */
@property (weak, nonatomic) IBOutlet UILabel *state;
/** */
@property (weak, nonatomic) IBOutlet UILabel *timer;

/** */
@property (strong, nonatomic) ShopOrderRecordModel *model;


@end
