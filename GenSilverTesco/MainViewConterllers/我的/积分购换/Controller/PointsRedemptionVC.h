//
//  PointsRedemptionVC.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseViewController.h"

@interface PointsRedemptionVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextField *shopsTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phonenumTF;
@property (weak, nonatomic) IBOutlet UITextField *shopnameTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *chooseshopLab;

@property (weak, nonatomic) IBOutlet UIButton *canUseCode;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
