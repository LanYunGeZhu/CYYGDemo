//
//  SalesManagementCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesManagementModel.h"
@interface SalesManagementCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UIButton *moreAndMore;

/** */
@property (weak, nonatomic) IBOutlet UIView *moreBgView;

/** 所属区域*/
@property (weak, nonatomic) IBOutlet UIButton *area;
/** 姓名:real_name*/
@property (weak, nonatomic) IBOutlet UILabel *real_name;
/**电话:mobile_pho */
@property (weak, nonatomic) IBOutlet UILabel *mobile_phone;
/** 推荐商家:*/
@property (weak, nonatomic) IBOutlet UILabel *nums;
/** 佣金比例:yjbl*/
@property (weak, nonatomic) IBOutlet UILabel *yjbl;
/**本月业绩: dyrl */
@property (weak, nonatomic) IBOutlet UILabel *dyrl;
/** 总共业绩: zrl*/
@property (weak, nonatomic) IBOutlet UILabel *zrl;
/** */
@property (strong, nonatomic) SalesManagementModel *model;


@end
