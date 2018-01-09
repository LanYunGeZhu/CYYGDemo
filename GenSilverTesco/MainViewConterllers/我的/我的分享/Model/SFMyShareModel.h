//
//  SFMyShareModel.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFMyShareModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;

/*
 * 标题
 */
@property (nonatomic,copy) NSString *title ;
/*
 * 时间
 */
@property (nonatomic,copy) NSString *time ;
/*
 * 获得积分
 */
@property (nonatomic,copy) NSString *getCode ;
/*
 * 积分分类
 */
@property (nonatomic,copy) NSString *ptype ;

@end
