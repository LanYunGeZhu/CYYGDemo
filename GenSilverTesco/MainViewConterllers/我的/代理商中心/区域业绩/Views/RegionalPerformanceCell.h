//
//  RegionalPerformanceCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionalPerformanceModel.h"
@interface RegionalPerformanceCell : KSBaseTableViewCell
/** 店铺名字 */
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/**  店铺图片*/
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;

/** 名字 电话*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 业务员 电话*/
@property (weak, nonatomic) IBOutlet UILabel *theSalesmanLabel;
/** 月让利金额 */
@property (weak, nonatomic) IBOutlet UILabel *monthOnGold;
/** 年让利金额*/
@property (weak, nonatomic) IBOutlet UILabel *yearsOnGold;

/** */
@property (strong, nonatomic) RegionalPerformanceModel *model;
/** */
@property (copy, nonatomic) void(^longTap)(RegionalPerformanceCell *cell);

@end
