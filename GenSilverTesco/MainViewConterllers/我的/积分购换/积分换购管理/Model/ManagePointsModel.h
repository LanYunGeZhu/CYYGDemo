//
//  ManagePointsModel.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagePointsModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;

//时间
@property (nonatomic,strong) NSString *time ;
//会员
@property (nonatomic,strong) NSString *name ;
//状态
@property (nonatomic,strong) NSString *status;
//让利
@property (nonatomic,strong) NSString *profits ;
//价格
@property (nonatomic,strong) NSString *price ;

@end
