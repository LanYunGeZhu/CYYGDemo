//
//  AddTheSalesmanVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesManagementModel.h"
@interface AddTheSalesmanVC : KSBaseViewController
/** */
@property (weak, nonatomic) IBOutlet UITextField *mobile;
/** */
@property (weak, nonatomic) IBOutlet UITextField *surname;
/** */
@property (weak, nonatomic) IBOutlet UITextField *name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *area;
/** 佣金比例 */
@property (weak, nonatomic) IBOutlet UIButton *commissionRatio;

/** */
@property (strong, nonatomic) SalesManagementModel *model;

/** */
@property (copy, nonatomic) void(^updateSuccess)();



@end
