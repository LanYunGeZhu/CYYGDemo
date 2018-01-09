//
//  KSTabBarController.m
//  TwinkleTwinkle
//
//  Created by kangshibiao on 16/8/18.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSTabBarController.h"
#import "KSNavigationController.h"
//#import "EaseManager.h"
@interface KSTabBarController ()<UITabBarControllerDelegate>
@end

@implementation KSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
//    [EaseManager sharedManager];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:setupUnreadMessageCount object:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self setupUnreadMessageCount];
//    });
}


//// 统计未读消息数
//-(void)setupUnreadMessageCount
//{
//
//    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
//    NSInteger unreadCount = 0;
//    UITabBarItem * item=[self.tabBar.items objectAtIndex:3];
//    
//    for (EMConversation *conversation in conversations) {
//        unreadCount += conversation.unreadMessagesCount;
//    }
//    if (self) {
//        if (unreadCount > 0) {
//            item.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
//        }else{
//            item.badgeValue = nil;
//        }
//    }
//    
//    UIApplication *application = [UIApplication sharedApplication];
//    [application setApplicationIconBadgeNumber:unreadCount];
//}


+ (KSNavigationController *)gitNavigationController{
    UIWindow *wiondw = [[UIApplication sharedApplication].delegate window];
    KSTabBarController * tabBarConterrller = (KSTabBarController *)wiondw.rootViewController;
    KSNavigationController *navController = (KSNavigationController *)tabBarConterrller.viewControllers[tabBarConterrller.selectedIndex];
    return navController;
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    if (![[UserInfoManager sharedManager] isLogin]){
        if([viewController.title isEqualToString:@"我的"] ){
            [[UserInfoManager sharedManager] goLoginPrompt:YES];
            return NO;
        }
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
}

- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
