//
//  LoginVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "LoginVC.h"
#import "ForgotPasswordVC.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.bgViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.layer setCornerRadius:18];
        [obj.layer setMasksToBounds:YES];
    }];
    
}

- (IBAction)loginClick:(id)sender{
    
//    self.phone.text = @"13486171969";
//    self.password.text = @"789789";
//    self.phone.text = @"18019910357";
//    self.password.text = @"111111";
    
//    self.phone.text = @"13735854466";
//    self.password.text = @"fr123123";
//    self.phone.text = @"18720085077";
//    self.password.text = @"123456";
//
//    self.phone.text = @"13735854466";
//    self.password.text = @"fr123123";
//    self.phone.text = @"18609209075";
//    self.password.text = @"199119";

//    self.phone.text = @"18609209075";
//    self.password.text = @"199119";
    
//    self.phone.text = @"13093405953";
//    self.password.text = @"111111";
    

//    self.phone.text = @"18368161855";
//    self.password.text = @"fr123123";

//    self.phone.text = @"18326527578";
//    self.password.text = @"gao520888";
//    self.phone.text = @"18368161855";
//    self.password.text = @"fr123123";

//    self.phone.text = @"18326527578";
//    self.password.text = @"gao520888";
//    self.phone.text = @"18368161855";
//    self.password.text = @"fr123123";
//    self.phone.text = @"18358581618";
//    self.password.text = @"123456";
  




    if (![KSTool isEqualToStringNew:self.phone.text]) {
        [MBProgressHUD showTipMessageInWindow:pleaseUserName];
        return;
    }
    if (![KSTool isEqualToStringNew:self.password.text]) {
        [MBProgressHUD showTipMessageInWindow:pleasePassword];
        return;
    }
  
    
    [self loginInUSerName:self.phone.text passWord:self.password.text];
    
}

- (void)loginInUSerName:(NSString *)userName passWord:(NSString *)passWord{
    [MBProgressHUD showActivityMessageInWindow:LoginStatus];
    [KSRequestManager postRequestWithUrlString:URL_act_login parameter:@{@"username":userName,@"password":passWord,@"remember":@"1"} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        
        NSMutableDictionary *mutablDic = [[NSMutableDictionary alloc]initWithDictionary:responseObject[@"user"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];

        });

        [mutablDic setObject:self.phone.text forKey:@"username"];
        [[UserInfoManager sharedManager]insterUserInfo:mutablDic];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setNavStatusBarRedColor:[UIColor clearColor]];
            [self dismissViewControllerAnimated:YES completion:nil];

        });
    } failure:^(id error) {
    }];

}

- (IBAction)ForgotPassword:(id)sender{
    ForgotPasswordVC *fogort =[ ForgotPasswordVC new];
    [self.loginMain. navigationController pushViewController:fogort animated:YES];
}


@end
