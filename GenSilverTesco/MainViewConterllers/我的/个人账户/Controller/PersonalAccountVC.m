//
//  PersonalAccountVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PersonalAccountVC.h"
#import "MyAddressVC.h"
#import "SecurityCenterVC.h"
#import "WCheckIdeVC.h"
#import "LYMyPurseVC.h"

@interface PersonalAccountVC ()

@end

@implementation PersonalAccountVC

#pragma mark 懒加载


#pragma mark 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"个人账户";
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
//个人信息
- (IBAction)personalMessage:(id)sender {
    WCheckIdeVC *vc = [WCheckIdeVC new];
    [self.navigationController pushViewController:vc animated:YES] ;
}
//收货地址
- (IBAction)receiveAddress:(id)sender {
    MyAddressVC *vc = [MyAddressVC new];
    vc.isAddress = 1;
    [self.navigationController pushViewController:vc animated:YES];
}
//我的钱包
- (IBAction)myPurse:(id)sender {
    LYMyPurseVC *vc = [LYMyPurseVC new];
    vc.mark = @"0";
    [self.navigationController pushViewController:vc animated:YES];
}
//安全中心
- (IBAction)securityCenter:(id)sender {
    SecurityCenterVC *vc = [SecurityCenterVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 工具方法


@end
