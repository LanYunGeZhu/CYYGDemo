//
//  BusinessActivityManagementCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessActivityManagementModel.h"
@interface BusinessActivityManagementCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgView1_layou_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgView2_layou_leading;

/** 是否选中*/
@property (assign, nonatomic) BOOL  isFLog;

/**店铺名称 */
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/** 状态*/
@property (weak, nonatomic) IBOutlet UILabel *state;
/** */
@property (weak, nonatomic) IBOutlet UILabel *address;
/** */
@property (weak, nonatomic) IBOutlet UILabel *activitName;
/** 活动周期*/
@property (weak, nonatomic) IBOutlet UILabel *cycle;
/** 活动价*/
@property (weak, nonatomic) IBOutlet UILabel *activityPrice;
/** 原价*/
@property (weak, nonatomic) IBOutlet UILabel *theOriginalPrice;

/** */
@property (strong, nonatomic) BusinessActivityManagementModel *model;
/** 是否选中 */
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end
