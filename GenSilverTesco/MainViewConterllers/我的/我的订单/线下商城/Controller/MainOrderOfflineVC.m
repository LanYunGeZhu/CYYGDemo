//
//  MainOrderOfflineVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MainOrderOfflineVC.h"
#import "OrderOfflineListVC.h"
@interface MainOrderOfflineVC ()
@property (strong, nonatomic) OrderOfflineListVC *orderList0;
@property (strong, nonatomic) OrderOfflineListVC *orderList1;
@property (strong, nonatomic) OrderOfflineListVC *orderList2;
@property (assign, nonatomic) NSInteger offIndex;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray <UIButton *> *menusButton;
@end

@implementation MainOrderOfflineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myScrollView.contentSize = CGSizeMake(Screen_wide *3, 0);
    self.myScrollView.pagingEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self setBtnFrame:0];
        self.orderList0 =  [self addChildVC:self.orderList0];
    });
    
}

- (IBAction)menusClick:(UIButton *)sender{
    
    [self.myScrollView setContentOffset:CGPointMake(Screen_wide * sender.tag , 0) animated:true];
    
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger off = scrollView.contentOffset.x /Screen_wide;
    [self setBtnFrame:off];
    _offIndex = off;
    if (off == 0) {
        
        if (self.orderList0 == nil) {
            self.orderList0 = [self addChildVC:self.orderList0];
        }
    }
    else if (off == 1){
        if (self.orderList1 == nil) {
            self.orderList1 = [self addChildVC:self.orderList1];
        }
    }
    else if (off == 2){
        if (self.orderList2 == nil) {
            self.orderList2 = [self addChildVC:self.orderList2];
        }
        
    }
   
}


- (OrderOfflineListVC *)addChildVC:(OrderOfflineListVC *)order{
    
    order = [OrderOfflineListVC new];
    order.index = _offIndex;

    order.view.frame = CGRectMake(Screen_wide * _offIndex,0,Screen_wide, self.myScrollView.frame.size.height);
    [self.myScrollView addSubview:order.view];
    [self addChildViewController:order];
    return  order;
}

- (void)setBtnFrame:(NSUInteger)tag{
    
    [UIView animateWithDuration:.3 animations:^{
        self.ledingView.constant = Screen_wide/3*tag;
        [self.view layoutIfNeeded];
    }];
    [self.menusButton enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (tag == idx) {
            [obj setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        else
        {
            [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
    }];
    
}

@end
