//
//  ShopForDetailsModel.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/8.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopForDetailsModel : NSObject
@property (nonatomic , copy) NSString              * anames;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * iD;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * orders;
@property (nonatomic , copy) NSString              * linkman;
@property (nonatomic , copy) NSString              * shop_img;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * business;
/** */
@property (copy, nonatomic)  NSString              *industry;
/** */
@property (strong, nonatomic) NSArray *imgs;




@end
