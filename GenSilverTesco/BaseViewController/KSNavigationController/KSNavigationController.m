//
//  KSNavigationController.m
//  TwinkleTwinkle
//
//  Created by kangshibiao on 16/8/15.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSNavigationController.h"

@interface KSNavigationController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic)UIPanGestureRecognizer *pan;
@end

@implementation KSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    _pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:_pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interactivePopGesture) name:interactivePopGesture object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addInteractivePopGesture) name:addInteractivePopGesture object:nil];

}

- (void)interactivePopGesture{
    [self.view removeGestureRecognizer:_pan];
}

- (void)addInteractivePopGesture{
    [self.view addGestureRecognizer:_pan];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
