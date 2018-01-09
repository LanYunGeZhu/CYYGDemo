//
//  OnlineOrderEvaluationVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/8.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderOnlineModel.h"
@interface OnlineOrderEvaluationVC : KSBaseRefreshViewController

/** */
@property (strong, nonatomic) OrderOnlineModel *model;
/** */
@property (strong, nonatomic) void (^upDataSccuss)();



@end
