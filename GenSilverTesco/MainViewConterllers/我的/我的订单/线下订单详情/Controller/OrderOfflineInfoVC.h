//
//  OrderOfflineInfoVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/30.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderOfflineInfoVC : KSBaseRefreshViewController
/** */
@property (strong, nonatomic) NSString *order_Id;
/** */
@property (copy, nonatomic) void(^goBackBlock)();



@end
