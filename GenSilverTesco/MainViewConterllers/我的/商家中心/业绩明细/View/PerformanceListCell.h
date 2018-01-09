//
//  PerformanceListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformanceOfSubsidiaryModel.h"
@interface PerformanceListCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UIImageView *storImageView;
/** */
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/** 月份*/
@property (weak, nonatomic) IBOutlet UILabel *months;

/**营业额 设置富文本 */
@property (weak, nonatomic) IBOutlet UILabel *turnover;
/**让利额  设置富文本*/
@property (weak, nonatomic) IBOutlet UILabel *onTheForehead;

/** */
@property (strong, nonatomic) PerformanceOfSubsidiaryModel *model;


@end
