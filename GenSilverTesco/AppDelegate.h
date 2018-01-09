//
//  AppDelegate.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/5.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//com.GenSilverTesco.www
//com.GenSilverTesco.www com.ShangJia.huishenghuo 1336044638@qq.com Chuangying2017


static  NSString  *EmiotionsAppKey = @"1106170801178837#genwin"; //环信Appkey
static  NSString  *apnsCerNameDebug = @"cyyg_Debug_mima_cyyg";   // 证书的名字
static  NSString  *apnsCerNameRelease = @"cyyg_Relese_mima_cyyg123456";

static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";


// 极光
static NSString *appKey = @"de782e9f2aa410e172c5e879";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/*
 *
 高德地图：
 18368161855-密码cyyg110
 极光/微信/腾讯/环信（通用账号）
 1336044638@qq.com-密码：1975111600xx
 *
 */

@end

