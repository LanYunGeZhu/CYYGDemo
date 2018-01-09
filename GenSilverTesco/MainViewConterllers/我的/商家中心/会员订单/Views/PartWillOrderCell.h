//
//  PartWillOrderCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartWillOrderModel.h"
@interface PartWillOrderCell : KSBaseTableViewCell

/** */
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *store_name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *price;
/** */
@property (weak, nonatomic) IBOutlet UILabel *rl_money;
/** */
@property (weak, nonatomic) IBOutlet UILabel *payType;

/** */
@property (weak, nonatomic) IBOutlet UILabel *timer;
/** */
@property (weak, nonatomic) IBOutlet UILabel *state;

/** */
@property (strong, nonatomic) PartWillOrderModel *model;


@end
