//
//  AddTheBusinessmanVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//
#import "AddTheBusinessmanVC.h"

@interface AddTheBusinessmanVC ()

@end

@implementation AddTheBusinessmanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"添加商家";
    
    NSString * name = _model.real_name;
    self.nameLabel.attributedText =  [KSTool setAttributedString:[NSString stringWithFormat:@"给 %@ 添加商家",name] color:[UIColor redColor] startNum:2 length:name.length];
    
    [self setRightWithString:@"添加" action:@selector(addClick)];
}

- (void)addClick{
    
    if ([self.phone_name.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入商家账号"];
        return;
    }
    [MBProgressHUD showActivityMessageInWindow:beingAdded];
    [KSRequestManager postRequestWithUrlString:URL_agent_transhopdo parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"ywid":_model.iD,@"user_name":self.phone_name.text} success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showTipMessageInWindow:addSuccess];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(id error) {
        
    }];
}


@end
