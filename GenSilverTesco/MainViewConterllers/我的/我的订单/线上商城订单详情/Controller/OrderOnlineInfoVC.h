//
//  OrderOnlineInfoVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    delete_Order_Success,
    update_Order_evaluation,
    updata_status_Cancle,

} orderStatus;

@interface OrderOnlineInfoVC : KSBaseRefreshViewController
/** 倒计时 只有 代付款才有*/
@property (weak, nonatomic) IBOutlet UILabel *theCountdown;
/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_tableView_top;
/** */
@property (copy, nonatomic) NSString *order_id;

/** */
@property (copy, nonatomic) void(^goBlckOrderInfo) (orderStatus orderStatus);



@end
