//
//  SFMyCollectModel.m
//  Diamond
//
//  Created by MrSong on 17/7/6.
//  Copyright © 2017年 FSShao. All rights reserved.
//

#import "SFMyCollectModel.h"
//判断字典值是否为空
#define SFDIC(dic,valuer) [dic objectForKey:valuer]==[NSNull null]?@"":[dic objectForKey:valuer]

@implementation SFMyCollectModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.shopName = SFDIC(dic, @"goods_name");
        self.shopImg = SFDIC(dic, @"goods_thumb");
        
        self.name = SFDIC(dic, @"goods_name");
        self.imgView = SFDIC(dic, @"goods_thumb");
//        self.describe = SFDIC(dic, @"goods_desc");
        self.price = SFDIC(dic, @"shop_price");
        
        self.goods_id = SFDIC(dic, @"goods_id");
        
        
        
    }
    return self;
}

@end
