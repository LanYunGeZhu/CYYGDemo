//
//  MyHeaderView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeaderView : KSBaseXIBView

/** 是否隐藏 充值 账号 提现*/
@property (weak, nonatomic) IBOutlet UIView *menuBgView;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
/** 昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 购买积分*/
@property (weak, nonatomic) IBOutlet UIButton *buyCredits;
/** */
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

/** 根据账号类型 隐藏对应的模块*/
- (void)hiddenMenusCustomer;
@end
