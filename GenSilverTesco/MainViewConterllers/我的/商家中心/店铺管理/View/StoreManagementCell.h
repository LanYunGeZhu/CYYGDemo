//
//  StoreManagementCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreManagementModel.h"
@interface StoreManagementCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
/** */
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/** */
@property (weak, nonatomic) IBOutlet UILabel *name_phone;
/** */
@property (weak, nonatomic) IBOutlet UILabel *state;
/** */
@property (weak, nonatomic) IBOutlet UIButton *address;

/**  制作收款码*/
@property (weak, nonatomic) IBOutlet UIButton *makePaymentCode;

/** */
@property (strong, nonatomic) StoreManagementModel *model;


@end
