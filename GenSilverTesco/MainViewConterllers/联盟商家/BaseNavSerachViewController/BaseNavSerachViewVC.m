//
//  BaseNavSerachViewVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "BaseNavSerachViewVC.h"
#import "SearchViewVC.h"
@interface BaseNavSerachViewVC ()

@end

@implementation BaseNavSerachViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addNavSerachView:(CGRect)frame isResponse:(BOOL)response addressTextIco:(BOOL)isAddress{
    
    self.searchView  = [SearchNavView initBaseView];
    self.searchView.frame = frame;
    self.searchView.isResponse = response;
    if (isAddress) {
        self.searchView.view_layou.priority = UILayoutPriorityDefaultLow;
        self.searchView.text_layou.priority = UILayoutPriorityRequired;
        self.searchView.text_layou.constant = 8;
    }
    else{
//        self.navigationItem.titleView = self.searchView;
        self.searchView.view_layou.priority = UILayoutPriorityRequired;
        self.searchView.text_layou.priority = UILayoutPriorityDefaultLow;
        self.searchView.view_layou.constant = 0;
        self.searchView.textAddress.hidden = YES;
        self.searchView.iocAddress.hidden = YES;
   
    }
    WeakSelf
    self.searchView.serachTextBlock = ^(NSString *text){
        if (response) {
            
        }else{
            SearchViewVC *serach = [SearchViewVC new];
            serach.serachStringBlock = ^(NSString *serachText){
                if (weakSelf.serachStringBlock) {
                    weakSelf.serachStringBlock(serachText);
                }
            };
            [weakSelf.navigationController pushViewController:serach animated:YES];

        }
        
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"----%f",[UIScreen mainScreen].bounds.size.height )
//        if ([UIScreen mainScreen].bounds.size.height == 812) {
//        }
                    self.searchView.intrinsicContentSize = self.searchView.frame.size;

        self.navigationItem.titleView = self.searchView;
        
    });
}

@end
