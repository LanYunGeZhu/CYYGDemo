//
//  ShoppingCartModel.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/9.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel

/**
 * 计算购车里面的数量
 *
 * @param datasArr 购物数组
 */
+ (void )orderShoppingCartrNum:(NSMutableArray *)datasArr numPrice:(void (^)(NSInteger num, float price))numPrice{
    __block NSInteger numNew = 0;
    __block float priceNew = 0;
    [datasArr enumerateObjectsUsingBlock:^(ShoppingCartModel *  model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.isChoose == 1) {
            numNew = numNew + [model.goods_number intValue];
            priceNew = priceNew + [model.goods_price doubleValue] * [model.goods_number doubleValue];
        }

    }];
    numPrice(numNew,priceNew);
}

@end
