//
//  SFMyAppraiseModel.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFMyAppraiseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;

//时间
@property (nonatomic,strong) NSString *timeLab ;
//标题
@property (nonatomic,strong) NSString *titleLab ;
//评论内容
@property (nonatomic,strong) NSString *contentLab;
//商品图片
@property (nonatomic,strong) NSString *imgView ;
//商品名称
@property (nonatomic,strong) NSString *shopName ;
//商品描述
@property (nonatomic,strong) NSString *describe ;
//商品价格
@property (nonatomic,strong) NSString *price ;
//评论星级
@property (nonatomic,copy) NSString *comment_rank ;

//商品id
@property (nonatomic,copy) NSString *goods_id ;

@end
