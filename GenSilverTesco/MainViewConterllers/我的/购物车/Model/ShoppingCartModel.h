//
//  ShoppingCartModel.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/9.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartModel : NSObject
@property (nonatomic , copy) NSString              * goods_number;
@property (nonatomic , copy) NSString              * rec_id;
@property (nonatomic , copy) NSString              * goods_thumb;
@property (nonatomic , copy) NSString              * goods_sn;
@property (nonatomic , copy) NSString              * goods_price;
@property (nonatomic , copy) NSString              * goods_attr;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , copy) NSString              * stock;
/** 是否选择*/
@property (assign, nonatomic) NSInteger isChoose;

/**
 * 计算购车里面的数量
 *
 * @param datasArr 购物数组
 */
+ (void )orderShoppingCartrNum:(NSMutableArray *)datasArr numPrice:(void (^)(NSInteger num, float price))numPrice;

@end
