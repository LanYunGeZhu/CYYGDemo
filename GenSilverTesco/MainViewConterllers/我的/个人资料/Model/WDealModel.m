//
//  WDealModel.m
//  GenSilverTesco
//
//  Created by LWW on 2017/8/8.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WDealModel.h"


@implementation WDealModel

- (NSMutableArray *)WDealWithArray:(NSMutableArray *)dataArray
{
    NSMutableArray *resultArr = [NSMutableArray array];
    
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WBankModel *model = obj;
        [resultArr addObject:model.title];
        
    }];
    
    return resultArr;

}

- (NSMutableArray *)WDealWithArrayR:(NSMutableArray *)dataArray
{
    
    
    NSMutableArray *nameArr = [NSMutableArray array];

    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WBankModel *model = obj;
        
        [nameArr addObject:model.shop_name];
 
    }];
    
    return nameArr;
    
}

- (NSMutableArray *)WDealWithArrayID:(NSMutableArray *)dataArray
{
    
    
    NSMutableArray *nameArr = [NSMutableArray array];
    
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WBankModel *model = obj;
        
        [nameArr addObject:model.Id];
        
    }];
    
    return nameArr;
    
}

@end
