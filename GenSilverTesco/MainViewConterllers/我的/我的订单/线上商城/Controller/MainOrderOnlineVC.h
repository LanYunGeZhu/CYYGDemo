//
//  MainOrderOnlineVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainOrderOnlineVC : UIViewController
/** */
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
/** */
@property (assign, nonatomic)  NSInteger index;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ledingView;

@end
