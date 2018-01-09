//
//  GoodsDetailsModel.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/7.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "GoodsDetailsModel.h"

@implementation Pros



@end
@implementation Supplier



@end

@implementation Paras

@end
@implementation Gallery

@end
@implementation Goods
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [self whc_Decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [self whc_Encode:encoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self whc_Copy];
}

@end

@implementation Ads

@end
@implementation Values

@end
@implementation Attrs

@end

@implementation GoodsDetailsModel

@end
