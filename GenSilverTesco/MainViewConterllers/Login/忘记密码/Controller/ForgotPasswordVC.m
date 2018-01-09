//
//  ForgotPasswordVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/31.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ForgotPasswordVC.h"
#import "SetNewPasswordVC.h"
@interface ForgotPasswordVC ()

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bgViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.layer setCornerRadius:18];
        [obj.layer setMasksToBounds:YES];
    }];
    
    self.title = @"找回密码";
    [[NSNotificationCenter defaultCenter] postNotificationName:interactivePopGesture object:nil];
}

#pragma mark -- 获取验证码
- (IBAction)getCode:(UIButton *)sender{

    self.phoneText = self.phone.text;
    [super getCode:sender];  
}

- (IBAction)nexfitsr:(id)sender{
    [KSRequestManager postRequestWithUrlString:URL_validate parameter:@{@"username":self.phone.text,@"mcaptcha":self.code.text,@"isapp":@"1"} success:^(id responseObject) {
        SetNewPasswordVC * setNew =[SetNewPasswordVC new];
        setNew.phone = self.phone.text;
        [self.navigationController pushViewController:setNew animated:YES];
    } failure:^(id error) {
        
    }];
  
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setNavStatusBarRedColor:[UIColor clearColor]];
   
}

@end
