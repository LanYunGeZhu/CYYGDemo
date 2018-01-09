//
//  FindPayPWVC.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseViewController.h"
#import "MQVerCodeImageView.h"

@interface FindPayPWVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *imgCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UITextField *codeNum;


@property (weak, nonatomic) IBOutlet UIView *mqBackView;
@property (weak, nonatomic) IBOutlet MQVerCodeImageView *codeImageView;
@end
