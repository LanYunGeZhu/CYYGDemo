//
//  SFMyShareModel.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SFMyShareModel.h"
//判断字典值是否为空
#define SFDIC(dic,valuer) [dic objectForKey:valuer]==[NSNull null]?@"":[dic objectForKey:valuer]

@implementation SFMyShareModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.time = SFDIC(dic, @"change_time");
        self.title = SFDIC(dic, @"change_desc");
        self.getCode = SFDIC(dic, @"pay_points");

        self.ptype = SFDIC(dic, @"ptype");
        
    }
    return self;
}

@end
