//
//  OnlineFooterView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderOnlineModel.h"
@interface OnlineFooterView : KSBaseXIBView
/** */
@property (weak, nonatomic) IBOutlet UILabel *numLable;
/** */
@property (weak, nonatomic) IBOutlet UILabel *price;
/** */
@property (strong, nonatomic) OrderOnlineModel *model;


@end
