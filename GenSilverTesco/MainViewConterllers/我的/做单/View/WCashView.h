//
//  WCashView.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/24.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCashView : KSBaseXIBView

@property (nonatomic,weak)IBOutlet UITextField *VipTf;
@property (nonatomic,weak)IBOutlet UILabel *NameLa;
@property (nonatomic,weak)IBOutlet UILabel *PhoneLa;

@property (nonatomic,weak)IBOutlet UILabel *BankLa;

@property (nonatomic,weak)IBOutlet UITextField *cashTf;
@property (nonatomic,weak)IBOutlet UITextField *ratioTf;
@property (nonatomic,weak)IBOutlet UITextField *shopTf;

@end
