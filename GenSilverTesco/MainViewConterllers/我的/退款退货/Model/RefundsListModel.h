//
//  RefundsListModel.h
//  GenSilverTesco
//
//  Created by MrSong on 17/8/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefundsListModel : NSObject

@property (nonatomic , copy) NSString              * add_time;
@property (nonatomic , copy) NSString              * back_id;
@property (nonatomic , copy) NSString              * back_type;
@property (nonatomic , copy) NSString              * goods_attr;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * goods_thumb;
@property (nonatomic , copy) NSString              * refund_money_1;
@property (nonatomic , copy) NSString              * status_back;
@property (nonatomic , copy) NSString              * goods_number;
@property (nonatomic , copy) NSString              *back_goods_number ;

@property (nonatomic , copy) NSString              * back_goods_price;
@property (nonatomic , copy) NSString              * goods_id;

@property (nonatomic,copy) NSString *describe ;//退款说明
@end
