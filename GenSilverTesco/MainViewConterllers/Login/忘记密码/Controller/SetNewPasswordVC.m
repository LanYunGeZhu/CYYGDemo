//
//  SetNewPasswordVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/31.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SetNewPasswordVC.h"

@interface SetNewPasswordVC ()

@end

@implementation SetNewPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置新密码";
}

- (IBAction)subCommit:(id)sender{

    if (![KSTool isEqualToStringNew:self.password1.text]) {
        [MBProgressHUD showTipMessageInWindow:pleaseNewPassword];
        return;
    }
    if (![self.password1.text isEqualToString:self.password2.text]) {
        [MBProgressHUD showTipMessageInWindow:theTwoPasswordsDonMatch];
        return;
    }
    NSDictionary *dic = @{@"npass":self.password1.text,@"cpass":self.password1.text,@"username":self.phone};
    [MBProgressHUD showActivityMessageInWindow:isSubmitted];
    [KSRequestManager postRequestWithUrlString:URL_reset_password parameter:dic success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showTipMessageInWindow:updatePasswordSuccess];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    } failure:^(id error) {
        
    }];
}

@end
