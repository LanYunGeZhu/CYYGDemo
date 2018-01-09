//
//  ViewController.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/5.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ViewController.h"
#import "HomeVC.h"
#import "UnionMerchantVC.h"
#import "FoundNearVC.h"
#import "CommunityVC.h"
#import "MyViewControllerVC.h"
#import "MainLoginVC.h"
#import "MainLoginVC.h"
#import "MyGuidePage.h"
@interface ViewController ()<MyGuidePageDelegata>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [UserInfoManager sharedManager].customer = @"0";
    
    if ([NEXTFIRST isEqualToString:@""]||NEXTFIRST == nil)
    {
        [self guidePage];
    }
    else{
        
        [self initTableViewController];

    }
 

}

//欢迎界面
- (void)guidePage{
    
    if ([NEXTFIRST isEqualToString:@""]||NEXTFIRST == nil)
    {
        MyGuidePage * page =[[MyGuidePage alloc]initWithFrame:[UIScreen mainScreen].bounds arrImages:@[@"yindaoye1",@"yindaoye2",@"yindaoye3"]];
        page.tag = 1222;
        page.delegata = self;
        [self.view addSubview:page];
    }
}

//移除欢迎界面
- (void)remoeviGUidePage {
    MyGuidePage * my = [self.view viewWithTag:1222];
    [my removeFromSuperview];
    [self initTableViewController];
}

- (void)initLoginVC{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = [MainLoginVC new];
    [window makeKeyAndVisible];

}

- (void)initTableViewController{
    
    NSArray *classNameViewController = @[@"HomeVC",@"UnionMerchantVC",@"CommunityVC",@"FoundNearVC",@"MyViewControllerVC"];
    NSArray * images = @[@"home_0",@"lmsh_0",@"shequ_0",@"fujin_0",@"wode_0"];
    NSArray * selectImages =  @[@"home_1",@"lmsh_1",@"shequ_1",@"fujin_1",@"wode_1"];
    NSArray * titArr = @[@"首页",@"联盟商家",@"社区",@"发现附近",@"我的"];
    
    NSMutableArray * viewControllers = [NSMutableArray array];
    [classNameViewController enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *classVC = [NSClassFromString(obj) new];
        KSNavigationController * nav = [[KSNavigationController alloc]initWithRootViewController:classVC];
        classVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:titArr[idx] image:[[UIImage imageNamed:images[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectImages[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [viewControllers addObject:nav];
        classVC.title = titArr[idx];

        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]} forState:UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    }];
    
    KSTabBarController * tabBarVC = [KSTabBarController new];

    tabBarVC.viewControllers = viewControllers;
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = tabBarVC;
    [window makeKeyAndVisible];
}


@end
