//
//  SFWeatherVC.h
//  GenSilverTesco
//
//  Created by MrSong on 17/8/11.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseViewController.h"

@interface SFWeatherVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UILabel *weatherLab;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLab;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@end
