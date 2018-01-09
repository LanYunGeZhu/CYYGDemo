//
//  FindPayPWVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "FindPayPWVC.h"
#import "MQVerCodeImageView.h"

@interface FindPayPWVC ()

//验证码倒计时参数
@property (nonatomic, assign) NSInteger reSendTime;
@property (nonatomic, strong) NSTimer *captchaTimer;

@property (nonatomic,strong) NSString *imgCodeStr ;
@end

@implementation FindPayPWVC

#pragma mark 懒加载

- (void)viewWillLayoutSubviews{
    [self selfInitUI];
    
}
#pragma mark 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"找回支付密码";
    
    [self selfCustomData];
    [self AFManagerDragon_requestData];
    
    _phoneNum.text = [UserInfoManager sharedManager].username;
}

#pragma mark 加载UI
- (void)selfInitUI{
    
    [self setRightWithString:@"完成" action:@selector(finishBtn)];

    //图形验证码
    _codeImageView.bolck = ^(NSString *imageCodeStr){//看情况是否需要
        self.imgCodeStr = imageCodeStr;
    };
    _codeImageView.isRotation = NO;
    [_codeImageView freshVerCode];
    
    //点击刷新
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_codeImageView addGestureRecognizer:tap];
    
}
- (void)tapClick:(UITapGestureRecognizer*)tap
{
    [_codeImageView freshVerCode];
}
#pragma mark 请求数据
/*! 自定义数据*/
- (void)selfCustomData{
    
}

/*!  数据请求 */
- (void)AFManagerDragon_requestData{
    
}
#pragma mark 代理方法回调


#pragma mark 点击事件
//完成按钮
- (void)finishBtn {
    
    if (![_password.text isEqualToString:_password2.text]) {
        [MBProgressHUD showErrorMessage:@"两次密码不一致"];
        return;
    }
    if (![_imgCode.text isEqualToString:_imgCodeStr]) {
        [MBProgressHUD showErrorMessage:@"图形验证码错误"];
        return;
    }
    if (_codeNum.text.length == 0) {
        [MBProgressHUD showErrorMessage:@"请输入短信验证码"];
        return;
    }
    if (_password.text.length == 0) {
        [MBProgressHUD showErrorMessage:@"请输入新密码"];
        return;
    }
    if (_password2.text.length == 0) {
        [MBProgressHUD showErrorMessage:@"请输入确认密码"];
        return;
    }
    
    [KSRequestManager postRequestWithUrlString:URL_findPayPW parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"isapp":@"1",@"sjyzm":_codeNum.text,@"npass":_password.text,@"cpass":_password2.text} success:^(id responseObject) {
        
        NSLog(@"------(%@)-----",responseObject) ;
        [MBProgressHUD showSuccessMessage:@"找回成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES]; ;
            
        });
    } failure:^(id error) {
        
    }];
}

- (IBAction)getCode:(UIButton *)sender {
    
    [KSRequestManager postRequestWithUrlString:URL_findPayPW_getCode parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"isapp":@"1",@"mobile":_phoneNum.text} success:^(id responseObject) {
        
        NSLog(@"------(%@)-----",responseObject) ;
        //设置验证码倒计时
        [_getCodeBtn setTitle:@"  60s已发送" forState:UIControlStateNormal];
        [_getCodeBtn setImage:[UIImage imageNamed:@"竖线"] forState:(UIControlStateNormal)];
        _getCodeBtn.enabled = NO;
        _reSendTime = 60;
        _captchaTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateReSendTime:) userInfo:nil repeats:YES];
        
    } failure:^(id error) {
        
    }];

}
//验证码按钮倒计时
- (void)updateReSendTime:(NSTimer *)timer {
    _reSendTime -= 1;
    
    if (_reSendTime >= 0) {
        [_getCodeBtn setTitle:[NSString stringWithFormat:@"  %lds已发送", (long)_reSendTime] forState:UIControlStateNormal];
        [_getCodeBtn setImage:[UIImage imageNamed:@"竖线"] forState:(UIControlStateNormal)];
    } else {
        _getCodeBtn.alpha = 0.8;
        [_getCodeBtn setTitle:@"  获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setImage:[UIImage imageNamed:@"竖线"] forState:(UIControlStateNormal)];
        
        _getCodeBtn.enabled = YES;
        _captchaTimer = nil;
    }
}




@end
