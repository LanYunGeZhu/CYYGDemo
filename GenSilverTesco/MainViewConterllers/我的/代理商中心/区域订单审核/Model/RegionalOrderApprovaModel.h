//
//  RegionalOrderApprovaModel.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/11.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionalOrderApprovaModel : NSObject
@property (nonatomic , copy) NSString              * iD;
@property (nonatomic , copy) NSString              * pay_user_name;
@property (nonatomic , copy) NSString              * linkman;
@property (nonatomic , copy) NSString              * pay_points;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * rl_money;
@property (nonatomic , copy) NSString              * addtime;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * pay_money;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * orderid;
@property (nonatomic , copy) NSString              * add_time;
@property (nonatomic , copy) NSString              * rlbl;
@property (nonatomic , copy) NSString              * status;
/**是否选中*/
@property (assign, nonatomic) NSInteger isSelected;

/**
 返回参数:array
 (
 记录ID：id
 店铺名称:shop_name
 联系电话: mobile
 会员账号: pay_user_name
 消费金额: price
 让利金额:rl_money
 积分支付数额:pay_points
 时间: add_time
 审核状态:status: 1已审核 0待审核 2已驳回
 )

 */
@end
