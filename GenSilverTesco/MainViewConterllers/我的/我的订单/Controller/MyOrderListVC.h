//
//  MyOrderListVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderListVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
/**<#name#>*/
@property (assign, nonatomic) NSInteger index;

/**是否直接加载 线下订单 默认 是线上 商城订单*/
@property (assign, nonatomic) BOOL isFlog;

@end
