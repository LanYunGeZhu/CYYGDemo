//
//  LYMyPurseModel.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYMyPurseModel : NSObject

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


@end
