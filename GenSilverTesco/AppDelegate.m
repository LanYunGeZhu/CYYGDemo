//
//  AppDelegate.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/5.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//
//18919795806 admin888 后台

#import "AppDelegate.h"
#import <MAMapKit/MAMapKit.h>
#import "EaseSDKHelper.h"
#import <JPush/JPUSHService.h>
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialWechatHandler.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [AMapServices sharedServices].apiKey = @"f8e811c561a6e5b8a21a6769a7be29ab";
    
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    [self registerJPush:launchOptions];
    
    //初始化友盟分享
    [self UMengApplication:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

#pragma mark UMeng友盟分享
- (void)UMengApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //打开调试日志
    [[UMSocialManager defaultManager]openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager]setUmSocialAppkey:UmengAppkey];
    //设置微信的appkey和appSecret
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_WechatSession appKey:kWeiXinKey appSecret:kWeiXinSecretKey redirectURL:@"http://mobile.umeng.com/social"];
    //设置分享到QQ互联的appkey appSecret
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_QQ appKey:kQQLoginKey appSecret:kQQSecretKey redirectURL:@"http://mobile.umeng.com/social"];
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)registerJPush:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //      NSSet<UNNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
        //    else {
        //      NSSet<UIUserNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    //支付宝快钱支付回调
    NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
    //支付页面
//    if ([[uuu objectForKey:@"vcShow"] isEqual:@"1"] && [[uuu objectForKey:@"vc"] isEqual:@"PrderPaymentVC"]) {
//        //获取支付结果
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"getPayResult1" object:self];
//        NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
//        [uuu setObject:@"0" forKey:@"vcShow"];
//        [uuu synchronize];
//    }
    
    //微信支付回调
    if ([[uuu objectForKey:@"vcShow"] isEqual:@"1"] && [[uuu objectForKey:@"vc"] isEqual:@"WebVC"]) {
        //获取支付结果
        [[NSNotificationCenter defaultCenter]postNotificationName:@"getPayResult2" object:self];
        NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
        [uuu setObject:@"0" forKey:@"vcShow"];
        [uuu synchronize];
    }
    
    //充值支付回调
    if ([[uuu objectForKey:@"vcShow"] isEqual:@"1"] && [[uuu objectForKey:@"vc"] isEqual:@"WRechargeVC"]) {
        //获取支付结果
        [[NSNotificationCenter defaultCenter]postNotificationName:@"getPayResult3" object:self];
        NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
        [uuu setObject:@"0" forKey:@"vcShow"];
        [uuu synchronize];
    }
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_8_0
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@",userInfo);
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", userInfo);
    ;
    
    completionHandler(UIBackgroundFetchResultNewData);
}



#endif

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    //
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    //
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        //
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif
#pragma mark 环信注册和处理

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *apnsCertName = nil;
    
#if DEBUG
    apnsCertName = apnsCerNameDebug ;
#else
    apnsCertName = apnsCerNameRelease;
#endif
    
    
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:EmiotionsAppKey
                                         apnsCertName:apnsCertName
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
}

- (void)easemobApplication:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[EaseSDKHelper shareHelper] hyphenateApplication:application didReceiveRemoteNotification:userInfo];
}

#pragma mark - App Delegate

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
        [JPUSHService registerDeviceToken:deviceToken];
        
    });
    
    
}

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
    
    
    
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    
}

#pragma mark - login changed

#pragma mark - EMPushManagerDelegateDevice

// 打印收到的apns信息
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
                                                        options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.content", @"Apns content")
                                                    message:str
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
    
}





@end
