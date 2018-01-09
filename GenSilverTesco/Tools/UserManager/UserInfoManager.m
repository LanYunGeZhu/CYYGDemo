//
//  UserInfoManager.m
//  TwinkleTwinkle
//
//  Created by kangshibiao on 2016/11/14.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#define USERLOGINDARA @"USERLOGINDARA"

#import "UserInfoManager.h"
#import "KSTabBarController.h"
#import "MainLoginVC.h"
@implementation UserInfoManager

+ (instancetype)sharedManager{
    static UserInfoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (id)init{
    if (self = [super init]) {
        if ([self  gitUserDefaultsData]) {
            [self setValuesForKeysWithDictionary:[self gitUserDefaultsData]];
            [self writeToLoal:[self gitUserDefaultsData]];
        }else{
            [self removeUserInfoData];
        }

    }
    return self;
}


//登陆成功换成数据
- (void)insterUserInfo:(id)data
{
    [self setValuesForKeysWithDictionary:[self setKeyNullData:data]];
    [self writeToLoal:[self setKeyNullData:data]];
}

- (id)setKeyNullData:(id)data{
    NSArray *allKeys = [data allKeys];
    NSMutableDictionary *mutableDic = [data mutableCopy];
    [allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[mutableDic objectForKey:obj] isKindOfClass:[NSNull class]]) {
            NSLog(@"----%@",obj);
            [mutableDic setObject:@"" forKey:obj];
        }
    }];
    return mutableDic;
}

/** 清除本地数据以及缓存数据*/
- (void)removeUserInfoData{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:USERLOGINDARA];
    self.isagent = @"";
    self.issup = @"";
    self.oper_agent_id = @"";
    self.user_id = @"";
    self.user_type = @"";
    self.user_phone = @"";
    self.pay_password = @"";
}

//登陆成功吧数据存入本地
- (void)writeToLoal:(id)data{
    NSUserDefaults * userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:USERLOGINDARA];
    [userDefaults synchronize];
}

/** 是否登陆过*/
- (BOOL)isLogin{
    
    id data = [self gitUserDefaultsData];
    if (data) {
        return YES;
    }
    return NO;
}

/** 去登陆*/
- (void)goLoginPrompt:(BOOL)prompt{
    id data = [self gitUserDefaultsData];
    if (!data && prompt) {
        [KSTool alertViewWithController:[KSTabBarController gitNavigationController] title:@"温馨提示" message:@"您当前没有登录！" items:@[@"取消",@"去登录"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
            if (indx == 1) {
                [[KSTabBarController gitNavigationController] presentViewController:[[KSNavigationController alloc] initWithRootViewController:[MainLoginVC new]] animated:YES completion:nil];
            };
        }];
    }else{
//        [[KSTabBarController gitNavigationController] pushViewController:[LoginMainVC new] animated:YES];
//        [[KSTabBarController gitNavigationController] presentViewController:[[KSNavigationController alloc] initWithRootViewController:[LoginVC new]] animated:YES completion:nil];

        //[[KSTabBarController gitNavigationController] presentViewController:[[KSNavigationController alloc] initWithRootViewController:[LoginViewController new]] animated:YES completion:nil];

    }
}

- (id)gitUserDefaultsData{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    id data = [userDefaults objectForKey:USERLOGINDARA];
    return data;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
