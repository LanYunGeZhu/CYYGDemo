//
//  WWinthDrawReCordCell.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWinthDrawReCordCell : UITableViewCell


@property (nonatomic,weak) IBOutlet UILabel *typeLa;
@property (nonatomic,weak) IBOutlet UILabel *moneyLa;
@property (nonatomic,weak) IBOutlet UILabel *NetPotLa;
@property (nonatomic,weak) IBOutlet UILabel *MoneyStatetLa;
@property (nonatomic,weak) IBOutlet UILabel *peopletLa;
@property (nonatomic,weak) IBOutlet UILabel *dateLa;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *tpyestate;

@end
