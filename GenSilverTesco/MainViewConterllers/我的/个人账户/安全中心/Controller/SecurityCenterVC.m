//
//  SecurityCenterVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SecurityCenterVC.h"
#import "ChangePasswordVC.h"
#import "FindPayPWVC.h"

@interface SecurityCenterVC ()

@end

@implementation SecurityCenterVC

#pragma mark 懒加载


#pragma mark 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"安全中心";
    [self selfInitUI];
    [self AFManagerDragon_requestData];
}

#pragma mark 加载UI
/*! 布局UI */
- (void)selfInitUI{
    
    
}
#pragma mark 请求数据
/*! 自定义数据*/
- (void)gitRequestData{
    
}


/*!  数据请求 */
- (void)AFManagerDragon_requestData{
    
}

#pragma mark 代理方法回调

#pragma mark 点击事件
//修改登陆密码
- (IBAction)loginPassword:(id)sender {
    ChangePasswordVC *vc = [ChangePasswordVC new];
    vc.title = @"重置登陆密码";
    vc.type = @"0";
    [self.navigationController pushViewController:vc animated:YES];
}
//找回支付密码
- (IBAction)payPassword:(id)sender {
    FindPayPWVC *vc = [FindPayPWVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
//修改支付密码
- (IBAction)changePayPW:(id)sender {
    ChangePasswordVC *vc = [ChangePasswordVC new];
    vc.title = @"修改支付密码";
    vc.type = @"1";
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 工具方法


@end
