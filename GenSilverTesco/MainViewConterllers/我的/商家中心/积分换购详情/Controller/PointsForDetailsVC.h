//
//  PointsForDetailsVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartWillOrderModel.h"
@interface PointsForDetailsVC : KSBaseRefreshViewController

/** */
@property (strong, nonatomic) PartWillOrderModel *model;

/** */
@property (strong, nonatomic) void (^upDataSuccess)();



@end
