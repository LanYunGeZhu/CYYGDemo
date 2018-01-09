//
//  RegisteredVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegisteredVC.h"
#import "KSCLLocationManager.h"
@interface RegisteredVC ()
@property (strong, nonatomic) NSString *address;
@end

@implementation RegisteredVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bgViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.layer setCornerRadius:18];
        [obj.layer setMasksToBounds:YES];
    }];
    
    WeakSelf
    KSCLLocationManager * manager = [KSCLLocationManager shareManager];
    manager.isCity = YES;
    manager.locationBlock = ^(CLLocation *loction,id locality){
//        AMapLocationReGeocode * regocdeo = locality;
//        weakSelf.address = locality;
        NSString *state=KSDIC(locality, @"State");
        
        NSString *city= KSDIC(locality, @"City");
        
        NSString *subLocality=KSDIC(locality, @"SubLocality");
        weakSelf.address = [NSString stringWithFormat:@"%@%@%@",state,city,subLocality];

        NSLog(@"---%@",weakSelf.address);
    };
    [manager start];
}

#pragma mark -- 获取验证码
- (IBAction)getCode:(UIButton *)sender{
    self.phoneText = self.phone.text;
    [super getCode:sender];
}

- (IBAction)registered:(id)sender{
    if (![KSTool isEqualToStringNew:self.phone.text]) {
        [MBProgressHUD showTipMessageInWindow:pleasePhone timer:1.5];
        return;
    }
    if (![KSTool isEqualToStringNew:self.code.text]) {
        [MBProgressHUD showTipMessageInWindow:pleaseEnterCode timer:1.5];
        return;
    }
    if (self.password.text.length < 6) {
        [MBProgressHUD showTipMessageInWindow:passwordNumCombination timer:1.5];
        return;
    }
    if (self.address == nil) {
        [MBProgressHUD showTipMessageInWindow:isToGetTheAddress];
        return;
    }
    //17858627414 15566160575
    NSDictionary *dic = @{@"user_name":self.phone.text
                          ,@"sjyzm":self.code.text
                          ,@"password":self.password.text
                          ,@"conform_password":self.password.text
//                          ,@"pay_password":@""
//                          ,@"confirm_pay_password":@""
                          ,@"pid":@""
                          ,@"city":@""
                          ,@"aid":@""
                          ,@"address":self.address
                          ,@"isapp":@1};
    [MBProgressHUD  showActivityMessageInWindow:inTheRegister];
    [KSRequestManager postRequestWithUrlString:URL_register parameter:dic success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccessMessage:@"注册成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"rigisteredClickSuccess" object:@{@"userName":self.phone.text,@"password":self.password.text}];
        });
        
    } failure:^(id error) {
        
    }];
}

@end
