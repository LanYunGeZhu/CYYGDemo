//
//  SFMyCollectModel.h
//  Diamond
//
//  Created by MrSong on 17/7/6.
//  Copyright © 2017年 FSShao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFMyCollectModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;
/*
 * 店铺图片
 */
@property (nonatomic,copy) NSString *shopImg ;
/*
 * 店铺名称
 */
@property (nonatomic,copy) NSString *shopName ;
/*
 * 商品名
 */
@property (nonatomic,copy) NSString *name ;
/*
 * 商品图片
 */
@property (nonatomic,copy) NSString *imgView ;
/*
 * 商品描述
 */
@property (nonatomic,copy) NSString *describe ;
/*
 * 商品价格
 */
@property (nonatomic,copy) NSString *price ;
//商品id
@property (nonatomic,copy) NSString *goods_id ;

@end
