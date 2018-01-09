//
//  PurseListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantsPurseModel.h"
@interface PurseListCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *rebatePoints;
/** */
@property (weak, nonatomic) IBOutlet UILabel *state;
/** */
@property (weak, nonatomic) IBOutlet UILabel *timer;

/** */
@property (weak, nonatomic) IBOutlet UILabel *change_desc;
/** */
@property (copy, nonatomic) MerchantsPurseModel *model;


@end
