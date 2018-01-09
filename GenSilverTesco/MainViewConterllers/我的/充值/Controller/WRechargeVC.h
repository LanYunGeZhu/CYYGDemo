//
//  WRechargeVC.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseViewController.h"
#import "WTouchTabDelegate.h"

@interface WRechargeVC : KSBaseViewController

@property (nonatomic,weak)IBOutlet UITextField *RecharGeTf;
@property (nonatomic,weak)IBOutlet WTouchTabDelegate *RecharTab;

@property (nonatomic,strong) NSString * paytype;

@property (nonatomic,strong) NSString *ordersn ;

@end
