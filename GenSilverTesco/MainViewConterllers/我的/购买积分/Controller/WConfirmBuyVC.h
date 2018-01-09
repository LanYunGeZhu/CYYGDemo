//
//  WConfirmBuyVC.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseViewController.h"

@interface WConfirmBuyVC : KSBaseViewController

@property (nonatomic,weak)IBOutlet UITableView *MyTab;
@property (nonatomic,weak)IBOutlet UILabel *timeLa;
@property (nonatomic,weak)IBOutlet UILabel *scoreLa;
@property (nonatomic,weak)IBOutlet UILabel *moneyLa;
@property (nonatomic,weak)IBOutlet UIView *grayView;
@property (nonatomic,copy) NSString *shopMoney;
@property (nonatomic,copy) NSString *score;

@end
