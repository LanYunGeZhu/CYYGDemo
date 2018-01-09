//
//  OnlineHeaderView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderOnlineModel.h"
@interface OnlineHeaderView : KSBaseXIBView
/** */
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
/** */
@property (strong, nonatomic) OrderOnlineModel *model;


@end
