//
//  ActivityManagementCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityManagementModel.h"
@interface ActivityManagementCell : KSBaseTableViewCell
/** 名字*/
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 原价*/
@property (weak, nonatomic) IBOutlet UILabel *theOriginalPrice;
/** 编号*/
@property (weak, nonatomic) IBOutlet UILabel *serialNumber;
/** */
@property (weak, nonatomic) IBOutlet UILabel *star_end_timer;
/** */
@property (weak, nonatomic) IBOutlet UIImageView *picture;
/** */
@property (weak, nonatomic) IBOutlet UILabel *state;

/** */
@property (strong, nonatomic) ActivityManagementModel *model;


@end
