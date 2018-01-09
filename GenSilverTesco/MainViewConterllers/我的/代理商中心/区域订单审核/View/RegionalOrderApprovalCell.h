//
//  RegionalOrderApprovalCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionalOrderApprovaModel.h"
@interface RegionalOrderApprovalCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_view_l_1;

@property (assign, nonatomic)  BOOL isFlog;
/** 是否选中 */
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

/** 联系电话*/
@property (weak, nonatomic) IBOutlet UILabel *contactPhoneNumber;

/** 会员账号*/
@property (weak, nonatomic) IBOutlet UILabel *memberAccount;

/** 消费金额*/
@property (weak, nonatomic) IBOutlet UILabel *consumptionAmount;

/** 让利金额*/
@property (weak, nonatomic) IBOutlet UILabel *amountOfBenefit;

/** 支付方式*/
@property (weak, nonatomic) IBOutlet UILabel *methodOfPayment;

/**店铺名称 */
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/** 时间*/
@property (weak, nonatomic) IBOutlet UILabel *timer;
/** 状态*/
@property (weak, nonatomic) IBOutlet UILabel *state;

/** */
@property (strong, nonatomic) RegionalOrderApprovaModel *model;


@end
