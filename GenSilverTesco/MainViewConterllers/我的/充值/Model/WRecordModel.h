//
//  WRecordModel.h
//  GenSilverTesco
//
//  Created by LWW on 2017/8/9.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRecordModel : NSObject
@property (nonatomic,copy)NSString *payment;
@property (nonatomic,copy)NSString *amount;
@property (nonatomic,copy)NSString *add_time;

@property (nonatomic,copy)NSString *ptype;
@property (nonatomic,copy)NSString *bank_addr;
@property (nonatomic,copy)NSString *buser;
@property (nonatomic,copy)NSString *fkstatus;

@end
