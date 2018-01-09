//
//  ManagePointsModel.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ManagePointsModel.h"
//判断字典值是否为空
#define SFDIC(dic,valuer) [dic objectForKey:valuer]==[NSNull null]?@"":[dic objectForKey:valuer]

@implementation ManagePointsModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.name = SFDIC(dic, @"name");
        self.time = SFDIC(dic, @"time");
        self.status = SFDIC(dic, @"status");
        
        self.profits = SFDIC(dic, @"profits");
        self.price = SFDIC(dic, @"price");
        
    }
    return self;
}

@end
