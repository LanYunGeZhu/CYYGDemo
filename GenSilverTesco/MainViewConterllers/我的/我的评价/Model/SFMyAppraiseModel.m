//
//  SFMyAppraiseModel.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SFMyAppraiseModel.h"
//判断字典值是否为空
#define SFDIC(dic,valuer) [dic objectForKey:valuer]==[NSNull null]?@"":[dic objectForKey:valuer]

@implementation SFMyAppraiseModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.titleLab = SFDIC(dic, @"title");
        
        NSString*str = SFDIC(dic, @"addtime");
        NSTimeInterval time = [str doubleValue];
        NSDate*detaildate = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
        [formatter setTimeZone:[NSTimeZone localTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *timestr = [formatter stringFromDate:detaildate];
        self.timeLab = timestr;
        
        self.contentLab = SFDIC(dic, @"content");
        
        self.imgView = SFDIC(dic, @"goods_thumb");
        self.shopName = SFDIC(dic, @"goods_name");
        self.describe = SFDIC(dic, @"describe");
        self.price = SFDIC(dic, @"shop_price");
        
        self.comment_rank = SFDIC(dic, @"comment_rank");
        
        self.goods_id = SFDIC(dic, @"id_value");
    }
    return self;
}


@end
