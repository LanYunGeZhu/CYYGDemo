//
//  OrderOnlineModel.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/7.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderOnlineGoods :NSObject
@property (nonatomic , copy) NSString              * goods_number;
@property (nonatomic , copy) NSString              * rec_id;
@property (nonatomic , copy) NSString              * goods_thumb;
@property (nonatomic , copy) NSString              * goods_sn;
@property (nonatomic , copy) NSString              * goods_price;
@property (nonatomic , copy) NSString              * goods_attr;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , assign) NSInteger comNum;//用于评价
@property (nonatomic , copy) NSString *com_context;//用于评价

@end


@interface OrderOnlineModel : NSObject
@property (nonatomic , copy) NSString              * pay_time;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * money_paid;
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , copy) NSString              * zipcode;
@property (nonatomic , copy) NSString              * consignee;
@property (nonatomic , copy) NSString              * shipping_status;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * order_id;
@property (nonatomic , copy) NSString              * order_amount;
@property (nonatomic , strong) NSArray<OrderOnlineGoods *>              * goods;
@property (nonatomic , copy) NSString              * anames;
@property (nonatomic , copy) NSString              * invoice_no;
@property (nonatomic , copy) NSString              * shipping_time_end;
@property (nonatomic , copy) NSString              * order_sn;
@property (nonatomic , copy) NSString              * shipping_fee;
@property (nonatomic , copy) NSString              * pay_status;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * integral_money;
@property (nonatomic , copy) NSString              * add_time;
@property (nonatomic , copy) NSString              * goods_amount;
@property (nonatomic , copy) NSString              * shipping_name;
@property (nonatomic , copy) NSString              * shipping_time;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * order_status;

/**返回当前订单状态*/
+ (void )getOrderStatusOrder_status:(NSInteger)order_status order_statusStringIndex:(void(^)(NSString *orderString))order_statusStringIndex;
@end
