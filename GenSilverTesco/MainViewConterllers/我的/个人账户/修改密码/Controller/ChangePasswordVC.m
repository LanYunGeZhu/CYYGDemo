//
//  ChangePasswordVC.m
//  Diamond
//
//  Created by MrSong on 17/7/11.
//  Copyright © 2017年 FSShao. All rights reserved.
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()

@end

@implementation ChangePasswordVC

#pragma mark 懒加载

#pragma mark 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    [self selfInitUI];
    [self selfCustomData];
    
}

#pragma mark 加载UI
- (void)selfInitUI{
    [self setRightWithString:@"完成" action:@selector(finishBtn)];
}
#pragma mark 请求数据
/*! 自定义数据*/
- (void)selfCustomData{
    
}

/*!  数据请求 */
- (void)AFManagerDragon_requestData{
    
    if (_oldPW.text.length == 0) {
        [MBProgressHUD showSuccessMessage:@"请输入原密码"];
        return;
    }
    if (_password.text.length == 0) {
        [MBProgressHUD showSuccessMessage:@"请输入新密码"];
        return;
    }
    if (_password2.text.length == 0) {
        [MBProgressHUD showSuccessMessage:@"请再次输入新密码"];
        return;
    }
    if (![_password.text isEqualToString:_password2.text]) {
        [MBProgressHUD showSuccessMessage:@"两次新密码输入不一致"];
        return;
    }
    
    [KSRequestManager postRequestWithUrlString:URL_changePW parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"ptype":_type,@"opass":_oldPW.text,@"npass":_password.text} success:^(id responseObject) {
        
        NSLog(@"------(%@)-----",responseObject) ;
        [MBProgressHUD showSuccessMessage:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES]; ;
        });
        
    } failure:^(id error) {
        
    }];
}
#pragma mark 代理方法回调


#pragma mark 点击事件
//完成按钮
- (void)finishBtn {
    [self AFManagerDragon_requestData];
}


@end
