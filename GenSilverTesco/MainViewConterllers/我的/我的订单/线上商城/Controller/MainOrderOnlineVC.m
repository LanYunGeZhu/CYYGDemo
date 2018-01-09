//
//  MainOrderOnlineVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MainOrderOnlineVC.h"
#import "OrderOnlineListVC.h"
@interface MainOrderOnlineVC ()

@property (strong, nonatomic) OrderOnlineListVC *orderList0;
@property (strong, nonatomic) OrderOnlineListVC *orderList1;
@property (strong, nonatomic) OrderOnlineListVC *orderList2;
@property (strong, nonatomic) OrderOnlineListVC *orderList3;
@property (strong, nonatomic) OrderOnlineListVC *orderList4;
@property (assign, nonatomic) NSInteger offIndex;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray <UIButton *> *menusButton;

@end

@implementation MainOrderOnlineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.myScrollView.contentSize = CGSizeMake(Screen_wide *5, 0);
    self.myScrollView.pagingEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myScrollView setContentOffset:CGPointMake(Screen_wide * self.index , 0) animated:true];
        _offIndex = self.index;
        if (self.index == 0) {
            [self setBtnFrame:_offIndex];
            self.orderList0 =  [self addChildVC:self.orderList0];
        }

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
    else if (off == 3){
        if (self.orderList3 == nil) {
            self.orderList3 = [self addChildVC:self.orderList3];
        }
        
    }
    else if (off == 4){
        if (self.orderList4 == nil) {
            self.orderList4 = [self addChildVC:self.orderList4];
        }
    }
}


- (OrderOnlineListVC *)addChildVC:(OrderOnlineListVC *)order{
    
    order = [OrderOnlineListVC new];
    order.index = _offIndex;

    order.view.frame = CGRectMake(Screen_wide * _offIndex,0,Screen_wide, self.myScrollView.frame.size.height);
    [self.myScrollView addSubview:order.view];
    [self addChildViewController:order];
    return  order;
}

- (void)setBtnFrame:(NSUInteger)tag{
    
    [UIView animateWithDuration:.3 animations:^{
        self.ledingView.constant = Screen_wide/5*tag;
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
