//
//  BusinessActivityManagementModel.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/16.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessActivityManagementModel : NSObject
@property (nonatomic , copy) NSString              * iD;
@property (nonatomic , copy) NSString              * linkman;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * anames;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * etime;
@property (nonatomic , copy) NSString              * sprice;
@property (nonatomic , copy) NSString              * stime;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * actsn;
@property (nonatomic , copy) NSString              * add_time;
@property (nonatomic , copy) NSString              * shop_id;
@property (nonatomic , copy) NSString              * status;
/**是否选中*/
@property (assign, nonatomic) NSInteger isSelected;
@end
