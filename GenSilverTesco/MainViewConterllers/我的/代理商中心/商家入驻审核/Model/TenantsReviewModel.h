//
//  TenantsReviewModel.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/11.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TenantsReviewModel : NSObject
@property (nonatomic , copy) NSString              * anames;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * iD;
@property (nonatomic , copy) NSString              * linkman;
@property (nonatomic , copy) NSString              * parent_user;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * user_name;
@property (nonatomic, assign) NSInteger    isSelected;

@end
