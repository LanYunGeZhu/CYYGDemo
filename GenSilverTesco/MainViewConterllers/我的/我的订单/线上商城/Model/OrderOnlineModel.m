//
//  OrderOnlineModel.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/7.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OrderOnlineModel.h"

@implementation OrderOnlineGoods
WHC_CodingImplementation


@end

@implementation OrderOnlineModel


/**
 * 返回订单 状态 0 -4 @"待付款",@"待发货",@"待收货",@"待评价",@"已完成"
 *
 */
/**返回当前订单状态*/
+ (void )getOrderStatusOrder_status:(NSInteger)order_status order_statusStringIndex:(void(^)(NSString *orderString))order_statusStringIndex{

    NSArray * array = @[@"待付款",@"待发货",@"待收货",@"待评价",@"交易成功",@"交易关闭"];
 
    order_statusStringIndex(array[order_status]);
}

+ (NSDictionary <NSString *, Class> *)whc_ModelReplaceContainerElementClassMapper{
    return @{@"goods":[OrderOnlineGoods class]};
}

@end
