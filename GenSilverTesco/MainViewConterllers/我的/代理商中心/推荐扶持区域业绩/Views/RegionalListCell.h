//
//  RegionalListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/1.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendedModel.h"
@interface RegionalListCell : KSBaseTableViewCell
/** 代理编号*/
@property (weak, nonatomic) IBOutlet UILabel *theAgentNumber;

/** 代理信息*/
@property (weak, nonatomic) IBOutlet UILabel *theAgentInformation;
/** 代理电话 */
@property (weak, nonatomic) IBOutlet UILabel *agentTelephone;
/** 本月让利*/
@property (weak, nonatomic) IBOutlet UILabel *thisMonthOn;
/** 总让利*/
@property (weak, nonatomic) IBOutlet UILabel *theTotalBenefit;
/** */
@property (weak, nonatomic) IBOutlet UIButton *address;

/** */
@property (strong, nonatomic) RecommendedModel  *model;


@end
