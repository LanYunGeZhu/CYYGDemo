//
//  MakePaymentCodeVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakePaymentCodeVC : KSBaseViewController
/** */
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/** 积分让利比例*/
@property (weak, nonatomic) IBOutlet UIButton *proportionIntegralBenefit;
/** 现金支付让利比例*/
@property (weak, nonatomic) IBOutlet UITextField *cashPaymentsAndBenefits;
/** 设置商品名称*/
@property (weak, nonatomic) IBOutlet UITextField *setTheGoods;

/** */
@property (copy, nonatomic) NSString *store_Id;
@property (copy, nonatomic) NSString *store_Name;


@end
