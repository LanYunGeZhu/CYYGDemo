//
//  MainLoginVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MainLoginVC.h"
#import "LoginVC.h"
#import "RegisteredVC.h"
@interface MainLoginVC ()
@property (strong, nonatomic) LoginVC *loginVC;
@property (strong, nonatomic) RegisteredVC *registVC;
@end

@implementation MainLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    
    self.layou_imageView_leading.constant = Screen_wide/ 4.0f -10.0f;
    [self setMensSelecIndex:0];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loginVC = [LoginVC new];
    self.loginVC.loginMain = self;
        self.loginVC.view.frame = CGRectMake(0, 0, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height);
        [self.myScrollView addSubview:self.loginVC.view];
    [self addChildViewController:self.loginVC];
//    });
    [[WHC_KeyboardManager share]addMonitorViewController:self];

    

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"rigisteredClickSuccess" object:nil];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rigisteredClick:) name:@"rigisteredClickSuccess" object:nil];

}

- (void)rigisteredClick:(NSNotification *)not{
    NSLog(@"---%@",not.object);
    self.layou_imageView_leading.constant = Screen_wide/ 4.0f -10.0f;

    [self.myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.loginVC loginInUSerName:KSDIC(not.object, @"userName") passWord:KSDIC(not.object, @"password")];
}

- (IBAction)goBackClick:(id)sender{
    [self setNavStatusBarRedColor:[UIColor clearColor]];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setNavStatusBarRedColor:[UIColor whiteColor]];
}

- (IBAction)mensuClick:(UIButton *)sender{
    if (sender.tag == 0) {
        self.layou_imageView_leading.constant = Screen_wide/ 4.0f -10.0f;
    }else{
        self.layou_imageView_leading.constant = (Screen_wide/2) + (Screen_wide/ 4.0f -10.0f);
    }
    [UIView animateWithDuration:.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self setMensSelecIndex:sender.tag];
    
    if (self.loginVC == nil) {
        /** 线上*/
        self.loginVC.view.frame = CGRectMake(0, 0, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height);
        [self.myScrollView addSubview:self.loginVC.view];
    }
    
    if (self.registVC == nil) {
        self.registVC = [RegisteredVC new];
        self.registVC.view.frame = CGRectMake(Screen_wide, 0, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height);
        [self.myScrollView addSubview:self.registVC.view];
    }
    [self.myScrollView setContentOffset:CGPointMake(sender.tag *Screen_wide, 0) animated:YES];
}

- (void)setMensSelecIndex:(NSInteger)index{
    [self.menusButton enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = index == idx ? YES : NO;
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"rigisteredClickSuccess" object:nil];

}
@end
