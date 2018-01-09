//
//  LYMyPurseVC.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseViewController.h"

@interface LYMyPurseVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong) NSString *mark ;//0赠送积分 6充值金额
@property (weak, nonatomic) IBOutlet UIButton *hasCode;
@end
