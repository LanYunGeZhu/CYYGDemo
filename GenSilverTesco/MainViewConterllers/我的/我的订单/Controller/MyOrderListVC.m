//
//  MyOrderListVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MyOrderListVC.h"
#import "LatestNavMenusView.h"
#import "MainOrderOnlineVC.h"
#import "MainOrderOfflineVC.h"
@interface MyOrderListVC ()

@property (strong, nonatomic) LatestNavMenusView *menusView;

@property (strong, nonatomic) MainOrderOnlineVC *onlneVC;
@property (strong, nonatomic) MainOrderOfflineVC *offlineVC;

@end

@implementation MyOrderListVC

- (LatestNavMenusView *)menusView{
    if (_menusView == nil) {
        _menusView = [LatestNavMenusView initBaseView];
        [_menusView.segmentedControl setTitle:@"线上商城" forSegmentAtIndex:0];
        [_menusView.segmentedControl setTitle:@"线下商城" forSegmentAtIndex:1];
        [_menusView.segmentedControl removeSegmentAtIndex:2 animated:NO];
        _menusView.frame = CGRectMake(0, 0, 100, Screen_heigth);
        [_menusView.segmentedControl addTarget:self action:@selector(segmentedControlClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _menusView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.titleView = self.menusView;
 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.isFlog ) {
            self.menusView.segmentedControl.selectedSegmentIndex = 1;
            self.offlineVC = [MainOrderOfflineVC new];
            self.offlineVC.view.frame = CGRectMake(Screen_wide, 0, Screen_wide, self.view.frame.size.height);
            [self.myScrollView addSubview:self.offlineVC.view];
            [self.myScrollView setContentOffset:CGPointMake(Screen_wide, 0) animated:NO];

            return ;
        }
        self.onlneVC = [MainOrderOnlineVC new];
        self.onlneVC.index = self.index;
        self.onlneVC.view.frame = self.view.frame;
        [self.myScrollView addSubview:self.onlneVC.view];
    });
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBackOrderInfoClick) name:@"goBackOrderInfoClick" object:nil];

}

- (void)goBackOrderInfoClick{
    [self.myScrollView setContentOffset:CGPointMake(Screen_wide, 0) animated:NO];

}

- (void)segmentedControlClick:(UISegmentedControl *)sge{
    if (self.onlneVC == nil) {
        /** 线上*/
        self.onlneVC = [MainOrderOnlineVC new];
        self.onlneVC.index = self.index;
        self.onlneVC.view.frame = CGRectMake(0, 0, Screen_wide, self.view.frame.size.height);
        [self.myScrollView addSubview:self.onlneVC.view];
    }
    
    if (self.offlineVC == nil) {
        self.offlineVC = [MainOrderOfflineVC new];
        self.offlineVC.view.frame = CGRectMake(Screen_wide, 0, Screen_wide, self.view.frame.size.height);
        [self.myScrollView addSubview:self.offlineVC.view];
    }
    [self.myScrollView setContentOffset:CGPointMake(sge.selectedSegmentIndex *Screen_wide, 0) animated:YES];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
