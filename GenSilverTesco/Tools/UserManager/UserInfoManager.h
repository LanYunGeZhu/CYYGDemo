//
//  UserInfoManager.h
//  TwinkleTwinkle
//
//  Created by kangshibiao on 2016/11/14.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

+ (_Nullable instancetype)sharedManager;

///** 用户Id*/
//@property (copy, nonatomic) NSString *userId;
//
//
///** 用户账号*/
//@property (copy, nonatomic) NSString *loginCode;
//
///** 用户性别*/
@property ( nullable,copy, nonatomic) NSString *customer;

/**
 * 	用户ID：user_id
用户类型：isshoper  1商家 0普通判断商家用isshoper字段
 是否代理商：isagent  1是 0否
 业务员：oper_agent_id 1是 0否
 支付密码：pay_password:1已设置 0：未设置

 */
@property (nullable,nonatomic , copy) NSString              * oper_agent_id;
@property (nullable,nonatomic , copy) NSString              * isagent;
@property (nullable,nonatomic , copy) NSString              * issup;
@property (nullable,nonatomic , copy) NSString              * user_id;
@property (nullable,nonatomic , copy) NSString              * user_type;
@property (nullable,nonatomic , copy) NSString              * user_phone;
@property (nullable,nonatomic , copy) NSString              * username ;
@property (nullable,nonatomic , copy) NSString              * isshoper ;

@property (nullable,nonatomic , copy) NSString              * pay_password ;

//登陆成功缓存数据
- (void)insterUserInfo:(nullable id)data;

/** 清除本地数据以及缓存数据*/
- (void)removeUserInfoData;

/** 是否登陆过*/
- (BOOL)isLogin;

/** 去登陆 并检查当前有没有登陆 没有的话去登陆
 * prompt 是否显示AlertView 您当前没有登陆提示 Yes 显示
 */
- (void)goLoginPrompt:(BOOL)prompt;
- (nullable id)gitUserDefaultsData;
@end
